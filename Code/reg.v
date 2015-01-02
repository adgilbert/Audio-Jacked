`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    20:57:22 10/06/2014 
// Design Name: 
// Module Name:    reg 
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
module enabled_register #(parameter WIDTH = 32)
			(input clk, reset,
			 input [WIDTH-1:0] a,
			 output reg [WIDTH-1:0] b);
	 
always @(posedge clk)
	b <= a;


endmodule
