`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    21:22:04 11/30/2014 
// Design Name: 
// Module Name:    progress_cnt 
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
module progress_cnt( input clk, rst, 
							input [1:0] menu,
							output reg [5:0] i
							);

		reg [25:0] count;
		reg div_clk;

	always @ (posedge clk) begin
		if (rst) begin
			count <= 0;
			div_clk <= 0;
		end
		else if (menu == 2'b01 || menu == 2'b10) begin
			if (count == 0) begin
				count <= 50000000;
				div_clk <= ~div_clk;
			end 
			else count <= count - 1;
		end
		else begin
			count <= 0;
			div_clk <= 0;
		end
	end
	
	always @ (posedge div_clk) begin
		if (menu == 2'b01) begin	
			if (i > 19 || i < 0)
				i <= 0;
			else i <= i + 1;
		end
		else i <= 0;
	end

endmodule
