----------------------------------------------------------------------------------
-- Company: Digilent Ro
-- Engineer: Elod Gyorgy
-- 
-- Create Date:    14:55:31 04/07/2011 
-- Design Name: 
-- Module Name:    SysCon - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: This module provides clocks and reset signal for the whole design.
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
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.math_real.all;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

library digilent;
use digilent.Video.ALL;
---- Uncomment the following library declaration if instantiating
---- any Xilinx primitives in this code.
library UNISIM;
use UNISIM.VComponents.all;

entity SysCon is
    Port ( CLK_I : in  STD_LOGIC;
			  CLK_O : out STD_LOGIC;
			  TFT_CLK_O : out STD_LOGIC;
			  TFT_CLK_180_O : out STD_LOGIC;
			  MSEL_O : out STD_LOGIC_VECTOR(3 downto 0);
           RSTN_I : in  STD_LOGIC;
			  SW_I : in STD_LOGIC_VECTOR(7 downto 0);
			  ASYNC_RST : out STD_LOGIC);
end SysCon;

architecture Behavioral of SysCon is
  
  -- # of clock cycles to delay deassertion of reset. Needs to be a fairly
  -- high number not so much for metastability protection, but to give time
  -- for reset (i.e. stable clock cycles) to propagate through all state
  -- machines and to all control signals (i.e. not all control signals have
  -- resets, instead they rely on base state logic being reset, and the effect
  -- of that reset propagating through the logic). Need this because we may not
  -- be getting stable clock cycles while reset asserted (i.e. since reset
  -- depends on PLL/DCM lock status)

  constant RST_SYNC_NUM   : integer := 100;
  constant RST_DBNC   : integer := 10;
  
  constant RST_SYNC_NUM_LENGTH : natural := natural(ceil(log(real(RST_SYNC_NUM), 2.0)));
  
	component dcm_TFT9
	port
	 (-- Clock in ports
	  CLK_IN1           : in     std_logic;
	  -- Clock out ports
	  CLK9          : out    std_logic;
	  CLK9_180          : out    std_logic;
	  -- Status and control signals
	  RESET             : in     std_logic;
	  LOCKED            : out    std_logic
	 );
	end component;
	signal Start_Up_Rst, DcmRst, DcmLckd : std_logic;
	signal SysConCLK : std_logic; --buffered input clock that drives this unit
	
	signal RstDbncQ, RstDbncTemp : std_logic_vector(RST_DBNC-1 downto 0);
	signal intRst : std_logic;
	
	--signal CLK_IN : std_logic;
	
	signal intfb, intpllout_xs: std_logic;
	
	signal int_sw : std_logic_vector(7 downto 0);
		
	signal RstQ : std_logic_vector(RST_SYNC_NUM-1 downto 0) := (RST_SYNC_NUM-1 => '0', others => '1');
	signal RstD : std_logic_vector(RST_SYNC_NUM_LENGTH downto 0) := '1' & conv_std_logic_vector(RST_SYNC_NUM, RST_SYNC_NUM_LENGTH);
	signal RstDbnc : std_logic;
	attribute KEEP : string; 
	attribute KEEP of async_rst     : signal is "TRUE";
	signal int_TFTClk : std_logic;
begin

--   IBUFG_inst : IBUFG
--   port map (
--      O => SysConCLK, -- Clock buffer output
--      I => CLK_I  -- Clock buffer input (connect directly to top-level port)
--   );
	
	--CLK_O <= SysConCLK;
	SysConCLK <= CLK_I;
	CLK_O <= CLK_I;
	
	DCM_inst : dcm_TFT9
	port map (
	 -- Clock in ports
    CLK_IN1            => SysConCLK,
    -- Clock out ports
    CLK9           	=> int_TFTClk,
    CLK9_180           => TFT_CLK_180_O,
    -- Status and control signals
    RESET              => DcmRst,
    LOCKED             => DcmLckd
	);
	TFT_CLK_O <= int_TFTClk;
--4-bit Shift Register For resetting the DCM on startup (Xilinx Answer Record: 14425)
--Asserts Start_Up_Rst for 4 clock periods
   SRL16_inst : SRL16
   generic map (
      INIT => X"000F")
   port map (
      Q => Start_Up_Rst,       -- SRL data output
      A0 => '1',     -- Select[0] input
      A1 => '1',     -- Select[1] input
      A2 => '0',     -- Select[2] input
      A3 => '0',     -- Select[3] input
      CLK => SysConCLK,   -- Clock input
      D => '0'        -- SRL data input
   );	
	
----------------------------------------------------------------------------------
-- Debounce Reset
----------------------------------------------------------------------------------	
RstDbncQ(0) <= not RSTN_I;
DBNC_PROC: for i in 1 to RstDbncQ'high generate
	process(SysConCLK)
	begin
		if Rising_Edge(SysConCLK) then
			RstDbncQ(i) <= RstDbncQ(i-1);
		end if;
	end process;
end generate;
RstDbncTemp(0) <= RstDbncQ(0);

DBNCTEMP_PROC: for i in 1 to RstDbncQ'high-1 generate
	RstDbncTemp(i) <= RstDbncTemp(i-1) and RstDbncQ(i);
end generate;	

	RstDbnc <= RstDbncTemp(RstDbncQ'high-1) and (not RstDbncQ(RstDbncQ'high));

----------------------------------------------------------------------------------
-- Reset with take-off and landing
----------------------------------------------------------------------------------	
	process(SysConCLK)
	begin
		if Rising_Edge(SysConCLK) then
			if (RstDbnc = '1' or RstQ(RST_SYNC_NUM-1) = '1') then
				RstQ <= RstQ(RST_SYNC_NUM-2 downto 0) & RstQ(RST_SYNC_NUM-1);
			end if;
		end if;
	end process;
	
	DcmRst <= 	not RstQ(RST_SYNC_NUM-2) or not RstQ(RST_SYNC_NUM-3) or
					not RstQ(RST_SYNC_NUM-4) or Start_Up_Rst;
	
	intRst <= 	not DcmLckd;
	
	process(SysConCLK, intRst)
	begin
		if (intRst = '1') then
			RstD <= '1' & conv_std_logic_vector(RST_SYNC_NUM, RST_SYNC_NUM_LENGTH);
		elsif Rising_Edge(SysConCLK) then
			if (RstD(RstD'high) = '1') then
				RstD <= RstD - 1;
			end if;
		end if;
	end process;
	
	ASYNC_RST <= RstQ(RST_SYNC_NUM-1) or RstD(RstD'high);
----------------------------------------------------------------------------------
-- Synchronize async switch inputs with TFT clock
----------------------------------------------------------------------------------	
--SYNC_SW: entity digilent.InputSyncV	port map (
--	D_I =>	SW_I(3 downto 0),
--	D_O =>	MSEL_O,
--	CLK_I => int_TFTClk  
--);
MSEL_O <= SW_I(3 downto 0);

end Behavioral;

