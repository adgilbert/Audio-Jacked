`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    21:39:40 11/30/2014 
// Design Name: 
// Module Name:    glyph_addr 
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
module glyph_addr(input clk, rst,
						input [3:0] vcnt,					// Needs bottom 4 bits of vcnt 9:4
						input [5:0] glyph,				// Needs top 6 bits of glyph 13:8
						output[9:0] address		// RGB is going to be a memory address that contains the color
						);
						// Starting address is the starting address of where glyphs are stored
				
			reg [9:0] cur_add;
						
			assign address = cur_add;
						
			always @(posedge clk)
			begin
				if (rst)
					cur_add <= 10'd150;
				else
				begin
					case(glyph)
					'd0: begin
								if (vcnt == 'd0) 
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd1)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd2)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd3)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd4)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd5)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd6)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd7)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd8)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd9)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd10)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd11)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd12)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd13)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd14)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd15)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
						end
					'd1: begin
								if (vcnt == 'd0) 
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd1)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd2)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd3)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd4)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd5)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd6)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd7)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd8)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd9)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd10)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd11)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd12)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd13)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd14)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd15)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
						end
					'd2:begin
								if (vcnt == 'd0) 
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd1)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd2)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd3)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd4)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd5)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd6)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd7)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd8)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd9)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd10)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd11)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd12)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd13)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd14)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd15)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
						end
					'd3:begin
								if (vcnt == 'd0) 
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd1)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd2)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd3)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd4)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd5)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd6)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd7)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd8)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd9)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd10)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd11)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd12)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd13)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd14)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd15)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
						end
					'd4:begin
								if (vcnt == 'd0) 
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd1)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd2)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd3)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd4)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd5)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd6)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd7)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd8)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd9)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd10)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd11)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd12)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd13)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd14)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd15)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
						end
					'd5:begin
								if (vcnt == 'd0) 
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd1)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd2)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd3)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd4)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd5)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd6)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd7)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd8)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd9)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd10)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd11)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd12)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd13)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd14)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd15)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
						end
					'd6:begin
								if (vcnt == 'd0) 
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd1)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd2)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd3)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd4)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd5)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd6)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd7)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd8)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd9)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd10)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd11)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd12)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd13)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd14)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd15)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
						end
					'd7:begin
								if (vcnt == 'd0) 
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd1)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd2)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd3)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd4)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd5)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd6)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd7)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd8)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd9)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd10)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd11)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd12)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd13)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd14)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd15)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
						end
					'd8:begin
								if (vcnt == 'd0) 
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd1)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd2)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd3)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd4)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd5)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd6)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd7)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd8)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd9)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd10)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd11)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd12)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd13)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd14)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd15)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
						end
					'd9:begin
								if (vcnt == 'd0) 
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd1)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd2)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd3)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd4)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd5)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd6)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd7)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd8)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd9)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd10)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd11)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd12)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd13)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd14)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd15)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
						end
					'd10:begin
								if (vcnt == 'd0) 
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd1)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd2)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd3)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd4)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd5)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd6)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd7)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd8)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd9)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd10)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd11)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd12)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd13)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd14)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd15)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
						end
					'd11:begin
								if (vcnt == 'd0) 
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd1)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd2)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd3)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd4)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd5)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd6)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd7)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd8)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd9)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd10)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd11)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd12)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd13)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd14)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd15)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
						end
					'd12:begin
								if (vcnt == 'd0) 
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd1)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd2)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd3)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd4)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd5)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd6)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd7)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd8)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd9)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd10)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd11)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd12)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd13)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd14)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd15)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
						end
					'd13:begin
								if (vcnt == 'd0) 
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd1)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd2)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd3)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd4)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd5)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd6)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd7)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd8)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd9)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd10)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd11)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd12)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd13)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd14)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd15)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
						end
					'd14:begin
								if (vcnt == 'd0) 
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd1)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd2)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd3)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd4)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd5)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd6)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd7)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd8)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd9)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd10)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd11)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd12)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd13)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd14)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd15)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
						end
					'd15:begin
								if (vcnt == 'd0) 
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd1)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd2)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd3)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd4)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd5)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd6)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd7)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd8)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd9)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd10)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd11)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd12)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd13)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd14)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd15)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
						end
					'd16:begin
								if (vcnt == 'd0) 
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd1)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd2)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd3)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd4)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd5)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd6)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd7)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd8)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd9)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd10)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd11)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd12)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd13)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd14)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd15)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
						end
					'd17:begin
								if (vcnt == 'd0) 
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd1)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd2)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd3)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd4)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd5)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd6)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd7)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd8)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd9)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd10)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd11)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd12)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd13)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd14)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd15)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
						end
					'd18:begin
								if (vcnt == 'd0) 
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd1)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd2)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd3)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd4)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd5)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd6)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd7)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd8)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd9)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd10)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd11)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd12)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd13)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd14)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd15)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
						end
					'd19:begin
								if (vcnt == 'd0) 
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd1)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd2)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd3)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd4)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd5)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd6)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd7)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd8)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd9)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd10)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd11)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd12)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd13)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd14)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd15)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
						end
					'd20:begin
								if (vcnt == 'd0) 
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd1)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd2)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd3)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd4)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd5)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd6)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd7)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd8)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd9)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd10)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd11)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd12)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd13)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd14)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd15)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
						end
					'd21:begin
								if (vcnt == 'd0) 
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd1)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd2)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd3)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd4)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd5)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd6)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd7)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd8)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd9)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd10)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd11)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd12)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd13)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd14)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd15)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
						end
					'd22:begin
								if (vcnt == 'd0) 
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd1)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd2)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd3)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd4)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd5)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd6)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd7)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd8)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd9)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd10)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd11)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd12)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd13)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd14)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd15)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
						end
					'd23:begin
								if (vcnt == 'd0) 
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd1)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd2)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd3)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd4)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd5)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd6)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd7)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd8)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd9)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd10)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd11)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd12)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd13)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd14)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd15)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
						end
					'd24:begin
								if (vcnt == 'd0) 
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd1)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd2)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd3)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd4)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd5)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd6)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd7)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd8)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd9)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd10)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd11)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd12)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd13)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd14)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd15)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
						end
					'd25:begin
								if (vcnt == 'd0) 
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd1)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd2)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd3)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd4)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd5)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd6)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd7)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd8)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd9)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd10)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd11)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd12)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd13)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd14)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd15)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
						end
					'd26:begin
								if (vcnt == 'd0) 
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd1)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd2)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd3)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd4)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd5)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd6)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd7)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd8)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd9)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd10)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd11)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd12)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd13)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd14)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd15)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
						end
					'd27:begin
								if (vcnt == 'd0) 
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd1)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd2)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd3)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd4)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd5)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd6)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd7)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd8)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd9)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd10)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd11)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd12)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd13)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd14)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd15)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
						end
					'd28:begin
								if (vcnt == 'd0) 
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd1)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd2)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd3)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd4)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd5)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd6)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd7)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd8)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd9)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd10)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd11)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd12)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd13)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd14)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd15)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
						end
					'd29:begin
								if (vcnt == 'd0) 
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd1)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd2)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd3)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd4)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd5)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd6)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd7)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd8)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd9)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd10)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd11)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd12)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd13)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd14)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd15)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
						end
					'd30:begin
								if (vcnt == 'd0) 
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd1)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd2)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd3)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd4)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd5)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd6)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd7)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd8)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd9)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd10)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd11)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd12)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd13)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd14)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd15)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
						end
					'd31:begin
								if (vcnt == 'd0) 
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd1)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd2)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd3)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd4)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd5)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd6)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd7)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd8)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd9)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd10)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd11)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd12)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd13)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd14)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd15)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
						end
					'd32:begin
								if (vcnt == 'd0) 
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd1)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd2)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd3)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd4)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd5)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd6)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd7)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd8)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd9)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd10)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd11)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd12)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd13)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd14)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd15)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
						end
					'd33:begin
								if (vcnt == 'd0) 
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd1)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd2)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd3)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd4)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd5)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd6)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd7)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd8)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd9)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd10)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd11)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd12)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd13)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd14)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd15)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
						end
					'd34:begin
								if (vcnt == 'd0) 
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd1)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd2)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd3)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd4)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd5)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd6)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd7)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd8)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd9)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd10)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd11)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd12)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd13)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd14)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd15)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
						end
					'd35:begin
								if (vcnt == 'd0) 
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd1)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd2)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd3)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd4)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd5)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd6)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd7)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd8)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd9)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd10)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd11)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd12)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd13)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd14)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd15)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
						end
					'd36:begin
								if (vcnt == 'd0) 
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd1)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd2)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd3)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd4)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd5)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd6)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd7)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd8)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd9)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd10)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd11)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd12)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd13)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd14)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd15)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
						end
					'd37:begin
								if (vcnt == 'd0) 
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd1)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd2)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd3)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd4)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd5)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd6)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd7)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd8)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd9)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd10)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd11)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd12)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd13)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd14)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd15)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
						end
					'd38:begin
								if (vcnt == 'd0) 
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd1)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd2)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd3)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd4)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd5)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd6)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd7)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd8)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd9)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd10)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd11)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd12)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd13)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd14)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd15)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
						end
					'd39:begin
								if (vcnt == 'd0) 
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd1)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd2)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd3)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd4)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd5)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd6)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd7)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd8)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd9)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd10)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd11)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd12)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd13)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd14)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd15)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
						end
					'd40:begin
								if (vcnt == 'd0) 
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd1)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd2)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd3)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd4)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd5)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd6)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd7)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd8)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd9)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd10)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd11)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd12)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd13)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd14)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd15)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
						end
					'd41:begin
								if (vcnt == 'd0) 
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd1)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd2)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd3)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd4)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd5)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd6)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd7)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd8)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd9)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd10)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd11)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd12)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd13)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd14)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd15)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
						end
					'd42:begin
								if (vcnt == 'd0) 
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd1)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd2)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd3)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd4)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd5)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd6)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd7)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd8)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd9)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd10)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd11)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd12)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd13)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd14)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd15)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
						end
					'd43:begin
								if (vcnt == 'd0) 
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd1)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd2)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd3)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd4)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd5)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd6)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd7)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd8)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd9)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd10)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd11)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd12)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd13)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd14)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd15)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
						end
					'd44:begin
								if (vcnt == 'd0) 
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd1)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd2)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd3)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd4)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd5)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd6)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd7)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd8)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd9)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd10)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd11)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd12)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd13)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd14)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd15)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
						end
					'd45:begin
								if (vcnt == 'd0) 
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd1)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd2)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd3)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd4)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd5)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd6)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd7)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd8)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd9)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd10)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd11)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd12)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd13)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd14)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
								else if (vcnt == 'd15)
									cur_add <= 10'd150 + ({glyph, 4'b0000}) + {4'b0000, vcnt};
						end
					default: cur_add <= 10'd150;
			endcase
			end
		end


endmodule
