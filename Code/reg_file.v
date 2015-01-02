`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:27:43 11/20/2014 
// Design Name: 
// Module Name:    reg_file 
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
module reg_file #(parameter WIDTH = 32, REGBITS = 4)
(   input clk, reset, regwrite,
	 input [REGBITS - 1:0] src_addr,
    input [REGBITS - 1:0] dst_addr,
    input [WIDTH - 1:0] data_in,
    output [WIDTH - 1:0] data_out1,
    output [WIDTH - 1:0] data_out2
    );


reg  [WIDTH-1:0] RAM [(1<<REGBITS)-1:0];

assign data_out1 = RAM[src_addr];
assign data_out2 = RAM[dst_addr];

always@(posedge clk)
	if (reset)	  begin
						RAM[32'd0] = 0;
						RAM[32'd1] = 0;
						RAM[32'd2] = 0;
						RAM[32'd3] = 0;
						RAM[32'd4] = 0;
						RAM[32'd5] = 0;
						RAM[32'd6] = 0;
						RAM[32'd7] = 0;
						RAM[32'd8] = 0;
						RAM[32'd9] = 0;
						RAM[32'd10] = 0;
						RAM[32'd11] = 0;
						RAM[32'd12] = 0;
						RAM[32'd13] = 0;
						RAM[32'd14] = 0;
						RAM[32'd15] = 0;
					 end
	else if (regwrite) RAM[dst_addr] = data_in;

endmodule
