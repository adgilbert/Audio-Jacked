----------------------------------------------------------------------------------
-- Company: Digilent Ro
-- Engineer: Elod Gyorgy
-- 
-- Create Date:    19:51:12 08/03/2011 
-- Design Name:	 VmodTFT Simple Paint Demo Project 
-- Module Name:    VmodTFT_SimplePaint - Behavioral 
-- Project Name: 
-- Target Devices: Digilent VmodTFT and Nexys3/Atlys
-- Tool versions: 
-- Description: This demo project uses the VmodTFT as a canvas the user can
-- draw on. It continously samples the touch panel on the VmodTFT and draws
-- colored lines on the display where the touch occured. It "feels" three
-- pressure levels, and the color intensity of the lines reflect this.
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
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.math_real.ALL;

library digilent;
use digilent.TouchR.ALL;
use digilent.Video.ALL;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity VmodTFT_SimplePaint_Nexys3 is
    Port ( 
			TFT_R_I : in  STD_LOGIC_VECTOR (7 downto 0);  --R
           TFT_G_I : in  STD_LOGIC_VECTOR (7 downto 0);  --G
           TFT_B_I : in  STD_LOGIC_VECTOR (7 downto 0);  --B
			TFT_VtcHCnt_O: out STD_LOGIC_VECTOR (31 downto 0);
			TFT_VtcVCnt_O: out STD_LOGIC_VECTOR (31 downto 0);
			TouchX_O: out STD_LOGIC_VECTOR (11 downto 0);
			TouchY_O: out STD_LOGIC_VECTOR (11 downto 0);
			TouchZ_O: out STD_LOGIC_VECTOR (11 downto 0);
			TFT_R_O : out  STD_LOGIC_VECTOR (7 downto 0);
           TFT_G_O : out  STD_LOGIC_VECTOR (7 downto 0);
           TFT_B_O : out  STD_LOGIC_VECTOR (7 downto 0);
           TFT_CLK_O : out  STD_LOGIC;
           TFT_DE_O : out  STD_LOGIC;
           TFT_BKLT_O : out  STD_LOGIC; -- LCD backlight driver EN (PWM)
			  TFT_VDDEN_O : out STD_LOGIC; -- LCD power on/off (power sequence)
           TFT_DISP_O : out  STD_LOGIC;
           TP_CS_O : out  STD_LOGIC;
           TP_DIN_O : out  STD_LOGIC;
           TP_DOUT_I : in  STD_LOGIC;
           TP_DCLK_O : out  STD_LOGIC;
           TP_BUSY_I : in  STD_LOGIC;
			  TP_PENIRQ_I : in STD_LOGIC;
			  SW_I : in STD_LOGIC_VECTOR(7 downto 0);
			  AN_O : out STD_LOGIC_VECTOR(3 downto 0);
			  SEG_O : out STD_LOGIC_VECTOR(7 downto 0); -- 7-segment+dot
			  CLK_I : in STD_LOGIC;
			  BTNM_I : in STD_LOGIC);
end VmodTFT_SimplePaint_Nexys3;

architecture Behavioral of VmodTFT_SimplePaint_Nexys3 is

	constant Z_high : natural := 1500;
	constant Z_low : natural := 200;
	constant SCALING_FACTOR : natural := 12;

	constant X_SCALING : natural := natural(round(real(H_480_272p_AV * (2**SCALING_FACTOR)) / 
	real(digilent.TouchR.VmodTFT.TopRight.X - digilent.TouchR.VmodTFT.TopLeft.X)));
	constant Y_SCALING : natural := natural(round(real(V_480_272p_AV * (2**SCALING_FACTOR)) / 
	real(digilent.TouchR.VmodTFT.BottomLeft.Y - digilent.TouchR.VmodTFT.TopLeft.Y))); 

	signal TouchXNorm1, TouchYNorm1 : std_logic_vector(11 downto 0);
	signal TouchXNorm2, TouchYNorm2 : std_logic_vector(11+SCALING_FACTOR downto 0);
	signal TouchXNorm : natural range 0 to H_480_272p_AV;
	signal TouchYNorm : natural range 0 to V_480_272p_AV;
	signal TouchEn : std_logic;

	signal TFT_VtcHCnt: integer;
	signal TFT_VtcVCnt: integer;

	signal TFTClk, TFTClk180, SysRst, SysClk : std_logic;
	signal TFTMSel : std_logic_vector(3 downto 0);

	signal TouchX, TouchY, TouchZ : std_logic_vector(11 downto 0);
	signal DispData : std_logic_vector(15 downto 0);
	attribute KEEP : string;
	attribute KEEP of TouchXNorm: signal is "TRUE";
	attribute KEEP of TouchYNorm: signal is "TRUE";

begin

----------------------------------------------------------------------------------
-- System Control Unit
-- This component provides a System Clock, a Synchronous Reset
----------------------------------------------------------------------------------
	Inst_SysCon: entity work.SysCon PORT MAP(
		CLK_I => CLK_I,
		CLK_O => SysClk,
		TFT_CLK_O => TFTClk,
		TFT_CLK_180_O => TFTClk180,
		MSEL_O => TFTMSel,
		RSTN_I => BTNM_I,
		SW_I => SW_I,
		ASYNC_RST => SysRst
	);
----------------------------------------------------------------------------------
-- TFT Controller
----------------------------------------------------------------------------------	
	Inst_TFTCtl: entity work.TFTCtl PORT MAP(
		CLK_I => TFTClk,
		CLK_180_I => TFTClk180,
		RST_I => SysRst,
		X_I => TouchXNorm,
		Y_I => TouchYNorm,
		Z_I => TouchZ,
		R_I => TFT_R_I, 
      G_I => TFT_G_I,
      B_I => TFT_B_I,
		WE_I => TouchEn,
		WR_CLK => SysClk,
		R_O => TFT_R_O,
		G_O => TFT_G_O,
		B_O => TFT_B_O,
		DE_O => TFT_DE_O,
		CLK_O => TFT_CLK_O,
		DISP_O => TFT_DISP_O,
		BKLT_O => TFT_BKLT_O,
		VDDEN_O => TFT_VDDEN_O,
		VtcHCnt => TFT_VtcHCnt,
		VtcVCnt => TFT_VtcVCnt,
		MSEL_I => TFTMSel
	);	
	
----------------------------------------------------------------------------------
-- Touch Controller
----------------------------------------------------------------------------------		
	Inst_TouchCtrl: entity work.TouchCtrl GENERIC MAP (CLOCKFREQ => 100) PORT MAP(
		CLK_I => SysClk,
		RST_I => SysRst,
		X_O => TouchX,
		Y_O => TouchY,
		Z_O => TouchZ,
		PENIRQ_I => TP_PENIRQ_I,
		CS_O => TP_CS_O,
		DIN_O => TP_DIN_O,
		DOUT_I => TP_DOUT_I,
		DCLK_O => TP_DCLK_O,
		BUSY_I => TP_BUSY_I
	);
----------------------------------------------------------------------------------
-- Process Touch Data
----------------------------------------------------------------------------------
	TFT_VtcHCnt_O <= conv_std_logic_vector(TFT_VtcHCnt,32);
	TFT_VtcVCnt_O <= conv_std_logic_vector(TFT_VtcVCnt,32);
	TouchX_O <= TouchX;
	TouchY_O <= TouchY;
	TouchZ_O <= TouchZ;

	TouchXNorm1 <= (TouchX - digilent.TouchR.VmodTFT.TopLeft.X);
	TouchYNorm1 <= (TouchY - digilent.TouchR.VmodTFT.TopLeft.Y);
	process (SysClk) 
	begin 
		if Rising_Edge(SysClk) then
			TouchXNorm2 <= TouchXNorm1 * CONV_STD_LOGIC_VECTOR(X_SCALING, SCALING_FACTOR);
			TouchYNorm2 <= TouchYNorm1 * CONV_STD_LOGIC_VECTOR(Y_SCALING, SCALING_FACTOR);
			if (TouchZ < Z_high and TouchZ > Z_low) then
				TouchEn <= '1';
			else
				TouchEn <= '0';
			end if;
		end if;
	end process;
	TouchXNorm <= CONV_INTEGER(TouchXNorm2(TouchXNorm2'high downto SCALING_FACTOR));
	TouchYNorm <= CONV_INTEGER(TouchYNorm2(TouchYNorm2'high downto SCALING_FACTOR));
	
	Inst_SSegDisp: entity digilent.SSegDisp GENERIC MAP (CLOCKFREQ => 100, DIGITS => 4) PORT MAP(
		CLK_I => SysClk,
		DATA_I => DispData,
		DOTS_I => x"0",
		AN_O => AN_O,
		CA_O => SEG_O
	);	
	
SSEG_DISPLAY_MUX: DispData <= x"0" & TouchX when SW_I(7 downto 6) = "00" else
										x"0" & TouchY when SW_I(7 downto 6) = "01" else
										x"00" & SW_I  when SW_I(7 downto 6) = "10" else
										x"0" & TouchZ;
										
end Behavioral;

