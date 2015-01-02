`timescale 1ns / 1ps
`include "./defines.v"
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    18:06:11 10/09/2014 
// Design Name: 
// Module Name:    instr_to_alu 
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
module instr_to_alu 	#(parameter WIDTH = 16)
	   (input [3:0] op_hi, op_lo,
		output reg [3:0] alu_op);

		
always @(*)		
	case (op_hi)
		`REGISTER:	case (op_lo)
						`ADD: 	alu_op = 4'b0010; //add
						`MUL:	alu_op = 4'b0111; //multiply
						`SUB: 	alu_op = 4'b1010; //subtract
						`CMP: 	alu_op = 4'b0011; //do nothing
						`AND: 	alu_op = 4'b0000; //and
						`OR:	alu_op = 4'b0001; //or
						`XOR:	alu_op = 4'b0100; //xor
						default:alu_op = 4'b0011; //just do nothing
					endcase
		`ADDI:	alu_op = 4'b0010; //add
		//ADDUI:	alu_op = 4'b0110; //add without flags
		//`ADDCI:	alu_op = 4'b0110; //add with carry
		`MULI:	alu_op = 4'b0111; //multiply
		`ANDI:	alu_op = 4'b0000; //and
		`ORI:	alu_op = 4'b0001; //or
		`XORI:	alu_op = 4'b0100; //xor
		`SUBI:	alu_op = 4'b1010; //subtract
		//SUBCI:	alu_op = 4'b1110; //subtract with carry bit
		`CMPI:	alu_op = 4'b0011; //do nothing
		`SPECIAL: alu_op = 4'b0011; //do nothing
		default:alu_op = 4'b0011; //just do nothing
	endcase
endmodule
