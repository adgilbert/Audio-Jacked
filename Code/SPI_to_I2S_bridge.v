`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    12:10:52 11/19/2014 
// Design Name: 
// Module Name:    SPI_to_I2S_bridge 
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
//	Bridge is currently connecting BLOCK RAM (through exmem.v) 
//	to the I2S_master module for output. BLOCK RAM address is 
//	updated upon receiving the DONE signal from I2S_master
//
//////////////////////////////////////////////////////////////////////////////////
module SPI_to_I2S_bridge(
		input  clk, rst,
		input [15:0] spkr_data,
		output data_out, m_clk, LR_clk, s_clk, DONE
    );
		
		reg [8:0] adr;
		wire [15:0] memdata;
		
		i2s_output i2s (clk, spkr_data, spkr_data, DONE, data_out, LR_clk, s_clk, m_clk);

endmodule
