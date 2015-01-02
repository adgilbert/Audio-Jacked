`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:19:38 11/20/2014 
// Design Name: 
// Module Name:    mux 
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
module mux #(parameter REGBITS = 4)
			(input [REGBITS-1:0] a, b, 
			 input control,
			 output reg [REGBITS-1:0] c
    );
	 
	 always @(*)
		if (control)
			c = b;
		else
			c = a;
		
		//assign c = control ? b:a;


endmodule
