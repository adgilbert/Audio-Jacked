`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:26:00 11/20/2014 
// Design Name: 
// Module Name:    adder_signed 
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
module adder_signed #(parameter WIDTH = 16)
	(input [WIDTH-1:0] a, b,
	 output [WIDTH-1:0] c);
	 
	 assign c = a + b;
	 
	 //always @(*)
	//	c  = b[WIDTH-1] ? ~c1:c1;
	 
endmodule 