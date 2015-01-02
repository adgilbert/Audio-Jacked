`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:30:55 11/20/2014 
// Design Name: 
// Module Name:    alu 
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
module alu #(parameter WIDTH = 16)
           (input      [WIDTH-1:0] alu_in1, alu_in2, 
            input      [3:0]       alucont, 
			output		C,L,F,Z,N,zero,		//C - carry bit, L - low flag, F - overflow, Z - equal comparisons, N - negative bit, zero - result is zero
            output reg [WIDTH-1:0] result);

   wire  [WIDTH-1:0] b2, slt, sub_b;
   wire 	[WIDTH:0] sum;
   wire Cin;

   assign b2 = alucont[3] ? ~alu_in1:alu_in1; //invert secondinput  if subtract or comparison
   assign sum = alu_in2 + b2 + alucont[3]; //adder -- adds the inverse of alu_in2 +1 if subtract
   // slt should be 1 if most significant bit of sum is 1
   //assign slt = sum[WIDTH-1];
   
   //assign Z if registers are equal
   assign Z = (alu_in1==alu_in2);
   
   //assign carry bit
   assign C = sum[WIDTH];
   
   //assign carry bit for addc
   assign Cin = sum[WIDTH];
   
   //assign low flag
   assign L = (alu_in1 > alu_in2);
   
   //assign F if overflow
   assign F = ((sum[WIDTH-1]!= alu_in1[WIDTH-1]) && (sum[WIDTH-1]!=b2[WIDTH-1]));
   
   //assign negative bit N
   assign sub_b = alu_in1 + ~alu_in2 + 1;
   assign N = sub_b[WIDTH-1];
   
   //set 'zero' high if result is 0
   assign zero = (result==0) ? 1'b1:1'b0;
   
	//Assing output based on the alu control signal. 
   always@(*)
      case(alucont[2:0])
			3'b000: result <= alu_in1 & alu_in2;
			3'b001: result <= alu_in1 | alu_in2;
			3'b010: result <= sum[WIDTH-1:0];
			3'b011: result <= alu_in2;
			3'b100: result <= alu_in1 ^ alu_in2;
			3'b101: result <= ~alu_in1;
			3'b110: result <= sum[WIDTH-1:0] + Cin;
			3'b111:	result <= alu_in1*alu_in2;
			default: result <= 0;
      endcase
endmodule
