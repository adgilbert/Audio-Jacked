`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:31:38 11/20/2014 
// Design Name: 
// Module Name:    shift 
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
module shift #(parameter WIDTH = 16, parameter HALF_WIDTH = 16)
			(input [WIDTH-1:0] a, 
			 input [WIDTH-1:0] b,
			 input control,
			 output reg [WIDTH-1:0] c);
			 
			 reg neg; 
			 reg [WIDTH-1:0] b2;
always @(a, b, control)
begin
neg = 0;
if (b[WIDTH-1] == 1) begin  
			b2 = ~b;
			b2 = b2 + 1;
			neg = 1;
			end
else b2 = b;
case (control)
	0:	if (neg) c = a >> b2; //Logical
		else 		c = a << b2;
	1: if(neg)	c = a >>> b2; //Arithmetic
		else 		c = a <<< b2;
	default: c = a;
endcase
end

endmodule