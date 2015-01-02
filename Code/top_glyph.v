`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    21:29:33 11/30/2014 
// Design Name: 
// Module Name:    top_glyph 
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
module top_glyph( input clk, rst,
						input [9:0] hcnt, vcnt,
						input [1:0] menu,
						input [2:0] filter,
						output [23:0] address,
						//output [13:0] glyph,
						output [5:0] prg_cnt
						);

		wire [5:0] i;
		wire [13:0] glyph;
		wire [9:0] glyph_address;
		
		assign prg_cnt = i;
		assign address = {14'd0,glyph_address};
		
		glyph_addr addr(clk, rst, vcnt[3:0], glyph[13:8], glyph_address);

		menus men(clk, rst, i, hcnt, vcnt, menu, filter, glyph);
		
		progress_cnt cnt(clk, rst, menu, i);
		


endmodule
