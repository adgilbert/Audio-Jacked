`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:26:26 11/20/2014 
// Design Name: 
// Module Name:    mux4 
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
module mux4 #(parameter REGBITS = 4)
			(input [REGBITS-1:0] a, b, c, d,
			 input [1:0] control,
			 output reg [REGBITS-1:0] e
    );
	 
	 always @(*)
		case(control)
			2'b00: e = a;
			2'b01: e = b;
			2'b10: e = c;
			2'b11: e = d;
			default: e = a;
		endcase


endmodule
