----------------------------------------------------------------------------------
-- Company: Elod Gyorgy
-- Engineer: Digilent Ro
-- 
-- Create Date:    15:32:51 06/03/2011 
-- Design Name: 
-- Module Name:    TouchCtrl - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: This controller is responsible for driving the ADS7846 touch
-- converter on the VmodTFT board. It acquires X, Y and pressure (Z) readings and
-- applies a windowed average filtering algorithm. The throughput rate is 3900
-- filtered 3D (X,Y,Z) coordinates per second. These touch coordinates can be
-- scaled to actual screen coordinates, depending on the characteristics of 
-- the touch panel/LCD assembly. While the sampling is done continuously, the
-- X/Y coordinates are only valid, if there is a touch (Z /= FFF).
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.math_real.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity TouchCtrl is
	Generic (CLOCKFREQ : natural := 100); --in MHz
	Port (
		CLK_I : in STD_LOGIC;
		RST_I : in STD_LOGIC;
		X_O : out STD_LOGIC_VECTOR(11 downto 0);
		Y_O : out STD_LOGIC_VECTOR(11 downto 0);
		Z_O : out STD_LOGIC_VECTOR(11 downto 0);
		PENIRQ_I : in STD_LOGIC;
		CS_O : out  STD_LOGIC;
		DIN_O : out  STD_LOGIC;
		DOUT_I : in  STD_LOGIC;
		DCLK_O : out  STD_LOGIC;
		BUSY_I : in  STD_LOGIC);
end TouchCtrl;

architecture Behavioral of TouchCtrl is
	constant TCH_CL : natural := 250; -- DCLK high/low period in ns (250 minimum)
	constant TSETTLE : natural := 10000; -- ns; delay for X and Y to settle (due to filtering capacitors)
	constant DCLK_CYCLES : natural := 
		natural(ceil(real(CLOCKFREQ*TCH_CL)/1_000.0));
	constant SETTLE_CYCLES : natural := 
		natural(ceil(real(CLOCKFREQ*TSETTLE)/1_000.0));
	constant BITS_PER_CONVERSION : natural := 12;
	constant CLOCKS_PER_CONVERSION : natural := 15;
	constant ACQ_FROM_BIT : natural := 5; --converter acquires starting with bit #5 (zero-based)
	constant AVERAGE_FACTOR : natural := 3;
	
	constant ADS_START : std_logic := '1';
	constant ADS_AX : std_logic_vector(2 downto 0) := "101";
	constant ADS_AY : std_logic_vector(2 downto 0) := "001";
	constant ADS_AZ1 : std_logic_vector(2 downto 0) := "011";
	constant ADS_12BIT : std_logic := '0';
	constant ADS_DIF : std_logic := '0';
	constant ADS_NOPD : std_logic_vector(1 downto 0) := "11";
	constant ADS_PD : std_logic_vector(1 downto 0) := "00";
	
--component div
--	port (
--	clk: in std_logic;
--	nd: in std_logic;
--	rdy: out std_logic;
--	rfd: out std_logic;
--	dividend: in std_logic_vector(12 downto 0);
--	divisor: in std_logic_vector(12 downto 0);
--	quotient: out std_logic_vector(12 downto 0);
--	fractional: out std_logic_vector(11 downto 0));
--end component;
COMPONENT div
  PORT (
    aclk : IN STD_LOGIC;
    s_axis_divisor_tvalid : IN STD_LOGIC;
    s_axis_divisor_tready : OUT STD_LOGIC;
    s_axis_divisor_tdata : IN STD_LOGIC_VECTOR(15 DOWNTO 0); --divisor 12 bits + sign ext
    s_axis_dividend_tvalid : IN STD_LOGIC; --nd
    s_axis_dividend_tready : OUT STD_LOGIC; --rfd
    s_axis_dividend_tdata : IN STD_LOGIC_VECTOR(15 DOWNTO 0); --dividend 12 bits + sign ext
    m_axis_dout_tvalid : OUT STD_LOGIC; --rdy
    m_axis_dout_tdata : OUT STD_LOGIC_VECTOR(31 DOWNTO 0) --quotient&fractional 25 bits + sign ext
  );
END COMPONENT;
	
   type state_type is (stIdle, stCmdLd, stCmd, stBusy, stAcqDelay); 
   type stateSmp_type is (stSample, stWindowing, stXdivZ1, stNewData); 
	type measure_type is (X_pos, Y_pos, Z1_pos);
	signal measure, prevMeasure : measure_type := X_pos;
   signal state, nstate : state_type; 
   signal stateSmp, nstateSmp : stateSmp_type; 
	
	signal ads_a : std_logic_vector(2 downto 0); --ADS7846 multiplexer selector
	signal ads_cmd : std_logic_vector(7 downto 0); --ADS7846 command
	
----------------------------------------------------------------------------------
-- Windowed average filtering signals
-- The algorithm does 2^AVERAGE_FACTOR+2 acquisitions, discards the smallest and
-- the largest reading, averaging the rest
----------------------------------------------------------------------------------	
	signal avgAcc, wAvg1, wAvg : std_logic_vector(BITS_PER_CONVERSION-1+AVERAGE_FACTOR+1 downto 0); -- +1 width to accomodate for +2 samples
	signal sampleMin : std_logic_vector(BITS_PER_CONVERSION-1 downto 0) := x"FFF"; --smallest reading
	signal sampleMax : std_logic_vector(BITS_PER_CONVERSION-1 downto 0) := x"000"; --largest reading
	
	signal avgCntEn, avgCntRst : std_logic;
	signal sampleCnt : natural range 0 to 2**AVERAGE_FACTOR+2 - 1 := 2**AVERAGE_FACTOR + 2 - 1;
	signal sampleCntEn, sampleCntRst : std_logic;
	signal int_X, int_Y, int_Z : std_logic_vector(BITS_PER_CONVERSION-1 downto 0);

----------------------------------------------------------------------------------
-- Touch Pressure measurement arithmetics
-- To calculate touch pressure, a Z1 measurement is performed and the following
-- formula used:
-- Z = (X/Z1*4096 - X + Y/4 - 1024)/4
-- The resulting pressure value ranges from FFF (no touch) to 000 (hard touch)
-- The equation from above is the simplified form of the general equation
-- shown in the user manual and approximates the X-panel resistance with 1024 and
-- the Y-panel resistance with 256.
----------------------------------------------------------------------------------
	signal fX_Z1 : std_logic_vector(BITS_PER_CONVERSION-1 downto 0);
	signal qX_Z1 : std_logic_vector(BITS_PER_CONVERSION downto 0); --signed
	signal rfd, rdyX_Z1, ndX_Z1 : std_logic;
	signal X_Z1_4096, RTouch_4, RTouch : std_logic_vector(BITS_PER_CONVERSION*2-1 downto 0);
	signal m_axis_dout_tdata : std_logic_vector(((2*BITS_PER_CONVERSION+1)/8+1)*8-1 downto 0); --AXI4-Stream interface byte oriented
	
	signal clkCnt : natural range 0 to DCLK_CYCLES-1; --clock divider for DCLK of the ADS7846
	signal clkCntEn : std_logic;
	signal int_DCLK, int_CS, dclkREdge, dclkFEdge : std_logic := '0';
	
	signal bitCnt : natural range 0 to CLOCKS_PER_CONVERSION - 1;
	signal bitCntRst : std_logic;

----------------------------------------------------------------------------------
-- Settle Counter
-- When changing the ADS7846's multiplexer, Tsettle delay is inserted into the
-- sampling process to allow for the touch screen voltage to settle. This
-- settling delay is only added when the XY driver configuration is changed.
----------------------------------------------------------------------------------	
	signal settleCnt : natural range 0 to SETTLE_CYCLES - 1;
	signal settleCntEn, settleCntRst : std_logic;
	
	signal srDataIn : std_logic_vector(BITS_PER_CONVERSION-1 downto 0);
	signal srDataOut : std_logic_vector(7 downto 0);	
	signal shiftOutLd : std_logic;
	
begin
----------------------------------------------------------------------------------
-- Input Shift Register (will hold conversion data)
-- Output Shift Register (shifts out commands for the AD)
----------------------------------------------------------------------------------
	process(CLK_I)
	begin
		if Rising_Edge(CLK_I) then
			if (dclkREdge = '1') then -- we read DOUT on Rising Edge
				srDataIn <= srDataIn(srDataIn'high-1 downto 0) & DOUT_I;
			end if;
			
			if (shiftOutLd = '1') then
				srDataOut <= ads_cmd;
			elsif (dclkFEdge = '1') then -- we write DIN on Falling Edge
				srDataOut <= srDataOut(srDataOut'high-1 downto 0) & '0';
			end if;		
		end if;
	end process;
	
	DIN_O <= srDataOut(srDataOut'high);
	DCLK_O <= int_DCLK;
	CS_O <= int_CS;
	X_O <= int_X;
	Y_O <= int_Y;
	Z_O <= int_Z;
	with (measure) select
		ads_A <= ADS_AX when X_pos,
					ADS_AY when Y_pos,
					ADS_AZ1 when Z1_pos;
	ads_cmd <= ADS_START & ads_A & ADS_12BIT & ADS_DIF & ADS_NOPD;
	
----------------------------------------------------------------------------------
-- Clock divider
----------------------------------------------------------------------------------
	process(CLK_I)
	begin
		if Rising_Edge(CLK_I) then
			if (clkCntEn = '1') then
				if (clkCnt = 0) then
					clkCnt <= DCLK_CYCLES - 1;
					int_DCLK <= not int_DCLK;
				else
					clkCnt <= clkCnt - 1;
				end if;
			end if;
		end if;
	end process;
	
	dclkREdge <= not int_DCLK when clkCnt = 0 else
					'0';
	dclkFEdge <= int_DCLK when clkCnt = 0 else
					'0';

----------------------------------------------------------------------------------
-- Bit Counter 
----------------------------------------------------------------------------------
	process(CLK_I)
	begin
		if Rising_Edge(CLK_I) then
			if (bitCntRst = '1') then
				bitCnt <= 0;
			elsif (dclkFEdge = '1') then --bit ends on falling edge of DCLK
				if (bitCnt = CLOCKS_PER_CONVERSION - 1) then
					bitCnt <= 0;
				else
					bitCnt <= bitCnt + 1;
				end if;
			end if;
		end if;
	end process;
	
----------------------------------------------------------------------------------
-- Settle Time Counter (to delay acquisition and allow the voltage to stabilize)
----------------------------------------------------------------------------------
	process(CLK_I)
	begin
		if Rising_Edge(CLK_I) then
			if (settleCntRst = '1') then
				settleCnt <= SETTLE_CYCLES - 1;
			elsif (settleCntEn = '1' and settleCnt /= 0) then
				settleCnt <= settleCnt - 1;
			end if;
		end if;
	end process;

----------------------------------------------------------------------------------
-- Sample Counter (for filtering)
----------------------------------------------------------------------------------
	process(CLK_I)
	begin
		if Rising_Edge(CLK_I) then
			if (sampleCntRst = '1') then
				sampleCnt <= 2**AVERAGE_FACTOR + 2 - 1;
			elsif (sampleCntEn = '1') then
				sampleCnt <= sampleCnt - 1;
			end if;
		end if;
	end process;
----------------------------------------------------------------------------------
-- Measurement type
----------------------------------------------------------------------------------	
	process(CLK_I)
	begin
		if Rising_Edge(CLK_I) then
			if (dclkFEdge = '1' and bitCnt = 8) then
				prevMeasure <= measure;
				if (sampleCnt = 0) then
					case (measure) is
						when X_pos =>
							measure <= Y_pos;
						when Y_pos =>
							measure <= Z1_pos;
						when Z1_pos =>
							measure <= X_pos;
						when others =>
							measure <= X_pos;
					end case;
				end if;
			end if;
		end if;
	end process;
	
----------------------------------------------------------------------------------
-- Accumulator (for averaging converted coordinates)
----------------------------------------------------------------------------------
	process(CLK_I)
	begin
		if Rising_Edge(CLK_I) then
			if (avgCntRst = '1') then
				avgAcc <= (others => '0');
				sampleMin <= x"FFF";
				sampleMax <= x"000";
			elsif (avgCntEn = '1') then
				avgAcc <= avgAcc + srDataIn; --add sample to accumulator
				if (srDataIn < sampleMin) then --keep track of minimum
					sampleMin <= srDataIn;
				end if;
				if (srDataIn > sampleMax) then --keep track of maximum
					sampleMax <= srDataIn;
				end if;
			end if;
		end if;
	end process;

	avgCntEn <= sampleCntEn;
	
	wAvg1 <= avgAcc - EXT(sampleMin, avgAcc'length);
	wAvg <= wAvg1 - EXT(sampleMax, wAvg1'length); --we lose the two extremes

----------------------------------------------------------------------------------
-- X/Z1 divider
-- A high-radix divider with a 12 bit fractional part. The result is actually
-- scaled to 4096 by concatenating the quotient with the fractional
----------------------------------------------------------------------------------
--Inst_X_div_Z1 : div
--		port map (
--			clk => CLK_I,
--			nd => ndX_Z1,			
--			rfd => rfd,
--			rdy => rdyX_Z1,			
--			dividend => '0' & int_X, --signed X
--			divisor => '0' & wAvg(BITS_PER_CONVERSION-1+AVERAGE_FACTOR downto AVERAGE_FACTOR), --signed Z1
--			quotient => qX_Z1,
--			fractional => fX_Z1);
Inst_X_div_Z1 : div
  PORT MAP (
    aclk => CLK_I,
    s_axis_divisor_tvalid => ndX_Z1,
    s_axis_divisor_tready => open,
    s_axis_divisor_tdata => "0000" & wAvg(BITS_PER_CONVERSION-1+AVERAGE_FACTOR downto AVERAGE_FACTOR), --sign-extended Z1
    s_axis_dividend_tvalid => ndX_Z1,
    s_axis_dividend_tready => rfd,
    s_axis_dividend_tdata => "0000" & int_X, --sign-extended X
    m_axis_dout_tvalid => rdyX_Z1,
    m_axis_dout_tdata => m_axis_dout_tdata
  );
-- X/Z1*4096
X_Z1_4096 <= m_axis_dout_tdata(2*BITS_PER_CONVERSION-1 downto 0);
process (CLK_I)
begin
	if Rising_Edge(CLK_I) then
		-- X/Z1*4096 - X + Y/4 - 1024
		RTouch_4 <= X_Z1_4096 - int_X + int_Y(int_Y'high downto 2) - 1024;
	end if;
end process;

----------------------------------------------------------------------------------
-- Coordinate buffers
-- After acquiring the required number of samples, the averaging and other
-- calculations (Z-touch) are performed. The resulting coordinates are stored in
-- three 12-bit registers
----------------------------------------------------------------------------------
   RESULT_PROC: process (CLK_I)
   begin
      if Rising_Edge(CLK_I) then
			if (stateSmp = stNewData) then
				case (prevMeasure) is
					when X_pos =>
						int_X <= wAvg(BITS_PER_CONVERSION-1+AVERAGE_FACTOR downto AVERAGE_FACTOR);
					when Y_pos =>
						int_Y <= wAvg(BITS_PER_CONVERSION-1+AVERAGE_FACTOR downto AVERAGE_FACTOR);
					when Z1_pos =>
						-- Z = (X/Z1*4096 - X + Y/4 - 1024) / 4
						if (RTouch_4(RTouch_4'high downto BITS_PER_CONVERSION-1+3) /= 0) then
							int_Z <= (others => '1'); --overflow
						else
							int_Z <= RTouch_4(BITS_PER_CONVERSION-1+2 downto 2); --/4
						end if;
					when others =>
				end case;
			end if;
		end if;
	end process;
	
----------------------------------------------------------------------------------
-- Acquire state machine
----------------------------------------------------------------------------------		
--Insert the following in the architecture after the begin keyword
   SYNC_PROC: process (CLK_I)
   begin
      if Rising_Edge(CLK_I) then
         if (RST_I = '1') then
            state <= stIdle;
         else
            state <= nstate;
         end if;        
      end if;
   end process;
 
   --MOORE State-Machine - Outputs based on state only
   OUTPUT_DECODE: process (state, sampleCnt, sampleCntRst, dclkFEdge, bitCnt)
	variable ads_A : std_logic_vector(2 downto 0);
   begin
		clkCntEn <= '0';
		if (state = stCmd or state = stBusy or state = stCmdLd) then
			clkCntEn <= '1';
		end if;
		
		settleCntEn <= '0';
		if (state = stAcqDelay) then
			settleCntEn <= '1';
		end if;
		settleCntRst <= '0';
		if (dclkFEdge = '1' and bitCnt = 8 and sampleCnt = 0) then
			settleCntRst <= '1';
		end if;
		
		shiftOutLd <= '0';
		if (state = stCmdLd) then
			shiftOutLd <= '1';
		end if;
		
		int_CS <= '1';
		if (state /= stIdle) then
			int_CS <= '0';
		end if;
		
		sampleCntEn <= '0';
		sampleCntRst <= '0';
		if (dclkFEdge = '1' and bitCnt = ACQ_FROM_BIT) then
			sampleCntEn <= '1';
			if (sampleCnt = 0) then
				sampleCntRst <= '1';
			end if;
		end if;
   end process;
 
   NEXT_STATE_DECODE: process (state, dclkFEdge, bitCnt, settleCnt)
   begin
      nstate <= state;  --default is to stay in current state
      case (state) is
         when stIdle =>
            nstate <= stCmdLd;
         when stCmdLd =>
            nstate <= stCmd;
         when stCmd =>
				if (dclkFEdge = '1') then
					if (bitCnt = ACQ_FROM_BIT and SETTLE_CYCLES > 0 and settleCnt /= 0) then -- we add acquisition delay to the first sample
						nstate <= stAcqDelay;
					elsif (bitCnt = 7) then --command is 8-bit wide
						nstate <= stBusy;
					elsif (bitCnt = CLOCKS_PER_CONVERSION - 1) then
						nstate <= stCmdLd;
					end if;
				end if;
			when stAcqDelay =>
				if (settleCnt = 0) then
					nstate <= stCmd; --return to sending the rest of the command after the delay
				end if;
			when stBusy =>
				if (dclkFEdge = '1') then
					nstate <= stCmd;
				end if;
         when others =>
            nstate <= stIdle;
      end case;      
   end process;	
	
----------------------------------------------------------------------------------
-- Filtering and touch calculations FSM
----------------------------------------------------------------------------------
--Insert the following in the architecture after the begin keyword
   SYNCSMP_PROC: process (CLK_I)
   begin
      if Rising_Edge(CLK_I) then
         if (RST_I = '1') then
            stateSmp <= stSample;
         else
            stateSmp <= nstateSmp;
         end if;        
      end if;
   end process;
 
	OUTPUTSMP_DECODE: process (stateSmp)
   begin
		avgCntRst <= '0';
		if (stateSmp = stNewData) then
			avgCntRst <= '1';
		end if;
		
		ndX_Z1 <= '0';
		if (stateSmp = stWindowing) then
			ndX_Z1 <= '1';
		end if;
	end process;
 
   NEXT_STATESMP_DECODE: process (stateSmp, sampleCntRst, prevMeasure, rdyX_Z1)
   begin
      nstateSmp <= stateSmp;  --default is to stay in current state
      case (stateSmp) is
         when stSample =>
				if (sampleCntRst = '1') then
					nstateSmp <= stWindowing;
				end if;
			when stWindowing =>
				if (prevMeasure = Z1_pos) then
					nstateSmp <= stXdivZ1;
				else
					nstateSmp <= stNewData;
				end if;
			when stXdivZ1 =>
				if (rdyX_Z1 = '1') then
					nstateSmp <= stNewData;
				end if;
			when stNewData =>
				nstateSmp <= stSample;
      end case;      
   end process;	

end Behavioral;

