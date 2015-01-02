`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    21:57:02 10/06/2014 
// Design Name: 
// Module Name:    enabled_reg 
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
module enabled_reg#(parameter WIDTH = 16)
			(input clk, reset, enable, 
			 input [WIDTH-1:0] a,
			 output reg [WIDTH-1:0] b);
	 


always @(posedge clk)
	if (reset)	b <= 0;
	else if (enable) b <= a;
	



endmodule
