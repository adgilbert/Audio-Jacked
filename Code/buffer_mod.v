`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    22:07:17 12/04/2014 
// Design Name: 
// Module Name:    buffer_mod 
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
module buffer_mod(
	input clk, spkr_done, buffer_updated,
	output reg spkr_update);

// sets speaker_update high when speaker done signal goes high. When signal is awknowledged, it goes low again. 
	always @ (posedge clk)
		if (spkr_done)
			spkr_update <= 1;
		else if(buffer_updated)
			spkr_update <= 0;
			
		
			
		

endmodule
