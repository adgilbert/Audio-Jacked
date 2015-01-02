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
module enabled_mux4 #(parameter REGBITS = 4)
			(input clk, reset, 
			 input [REGBITS-1:0] a, b, c, d,
			 input [1:0] control,
			 input enable,
			 output reg [REGBITS-1:0] e
    );
	 
	 
	 mux4 #(32)
		dataupdate (a, b, c, d, control, e_o);
	 
	 
always @(*)
	if (reset)	e = 0;
	else if (enable) e = e_o;

endmodule
