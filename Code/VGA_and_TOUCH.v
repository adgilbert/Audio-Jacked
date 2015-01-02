`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    22:46:07 11/11/2014 
// Design Name: 
// Module Name:    top_mod 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module vgaandtouch(
 output [23:0] vga_addr, 
 output [7:0] TFT_R_O, TFT_G_O, TFT_B_O,
 output TFT_CLK_O, TFT_DE_O, TFT_BKLT_O, TFT_VDDEN_O, TFT_DISP_O, TP_CS_O, TP_DIN_O, 
 input TP_DOUT_I, 
 output TP_DCLK_O, 
 input TP_BUSY_I, TP_PENIRQ_I, 
 input [7:0] SW_I, 
 output [3:0] AN_O, 
 output [7:0] SEG_O,  
 input CLK_I, reset, BTNM_I, 
 input [31:0] br_memdata_out,
 input decode_state,
 output [1:0] menu,
 output [2:0] filter);
	
wire [7:0] TFT_R_I, TFT_G_I, TFT_B_I;
wire [31:0] TFT_VtcHCnt_O, TFT_VtcVCnt_O;
wire [11:0] X, Y, Z;
	
	/* This is a VHDL module which controls the touchscreen and decodes all signals. It has been 
		modified to take in RGB values for the display and put out XYZ coordinates of the pressure sensed. */
	 VmodTFT_SimplePaint_Nexys3 
			tchscrencntrlr (TFT_R_I, TFT_G_I, TFT_B_I, TFT_VtcHCnt_O, TFT_VtcVCnt_O, X, Y, Z,
				TFT_R_O, TFT_G_O, TFT_B_O, TFT_CLK_O, 
				TFT_DE_O, TFT_BKLT_O, TFT_VDDEN_O, TFT_DISP_O, TP_CS_O, TP_DIN_O, TP_DOUT_I, 
				TP_DCLK_O, TP_BUSY_I, TP_PENIRQ_I, SW_I, AN_O, SEG_O, CLK_I, BTNM_I);
 
parameter BLACK = 8'h00, WHITE = 8'hFF, BLUE = 8'hc0;
wire [13:0] rgb;
reg [15:0] total_data;
wire [3:0] data0, data1, data2, data3;
wire [5:0] prg_cnt;
reg div_clk;

	/* The menu controller decides what menu we should be on based on our Touch inputs*/
	menuctrlr
		da_mc (CLK_I, reset, prg_cnt,  X, Y, Z, menu, filter);

	/* This module decides which glyph should be used based on the current Hcnt and Vcnt. It outputs an address which
		gets sent to block ram and a progress count which is used for the progress bar */
	top_glyph
		TG(CLK_I, reset, TFT_VtcHCnt_O[9:0], TFT_VtcVCnt_O[9:0], menu, filter, vga_addr, prg_cnt);

	/* This module takes the data from the Block Ram and decodes it into RGB values. Although the Touchscreen was capable
		of 24 bit color we only used 4 colors so we were able to store our color with 2 bits for each pixel. This module 
		stores the next vga values in a buffer and then bases the pixel number number based on the Hcnt. It decodes the 2 
		bit color values into 24 bit color as well. */
	rgb_decode #(32)
		RGB(CLK_I, reset, decode_state, TFT_VtcHCnt_O[4:0],br_memdata_out,vga_addr[0], TFT_R_I, TFT_G_I, TFT_B_I);
		
		

endmodule
