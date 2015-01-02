`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:28:31 11/20/2014 
// Design Name: 
// Module Name:    sign_extend 
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
module sign_extend16#(parameter WIDTH = 16)
	(input [WIDTH-1:0] immediate,
	 output [(WIDTH*2)-1:0] extended);

   //sign extend our 16 bit immediate to a 32 bit immediate 
	assign extended = (immediate[WIDTH-1]) ? {16'hff,immediate} : {16'h00,immediate}; 
	

	
																	

endmodule
