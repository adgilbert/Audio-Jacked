`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 		 University of Utah
// Engineer: 		 Paymon Saebi
// 
// Create Date:    06:48:13 03/03/2013 
// Design Name:    Nexys 3 interface for the 7 segment LEDs
// Module Name:    LED_7seg
// Project Name:   CE 3700 - S14 - Lab 5
// Target Devices: Digilent Nexys 3
// Tool versions:  Xilinx ISE 14.7
//
//////////////////////////////////////////////////////////////////////////////////
module LED_7SEG(input            clock, clear,
					 input 	   [3:0] data0, data1, data2, data3,				
					 output 			   decimal,
					 output reg [3:0] enable,
					 output reg [6:0] segs);
	 
	reg [19:0] ticks = 0; // to count up 800000 clock ticks (8 ms)
	reg [3:0]  digit = 0; // to register and hold current hex digit values
	
	assign decimal = 1; //turn off the decimal point	

	always@(posedge clock)
		if(clear)
			ticks <= 0;
		else if (ticks > 800000) // The total refresh time window
			ticks <= 0;
		else
			ticks <= ticks + 1;

	always@(*)
	begin
		digit = 4'h0;
		enable = 4'hF; // all are kept high, besides the one in the current quarter
		
		if(ticks < 200000) // first quarter of the refresh window
		begin
			digit = data0; // first hex digit picked from the 16 bit input
			enable[0] = 0;
		end
		else if((ticks > 200000) && (ticks < 400000)) // second refresh quarter
		begin
			digit = data1; // second hex digit
			enable[1] = 0;
		end
		else if((ticks > 400000) && (ticks < 600000)) // third refresh quarter
		begin
			digit = data2; // third hex digit
			enable[2] = 0;
		end
		else if((ticks > 600000) && (ticks < 800000)) // forth refresh quarter
		begin
			digit = data3; // forth hex digit
			enable[3] = 0;
		end
	end
	
	always@(*) 
		case(digit) // convert the 4 bit hex to 7 segment display of hex
			0:  segs = 7'b1000000; // 0
			1:  segs = 7'b1111001; // 1
			2:  segs = 7'b0100100; // 2
			3:  segs = 7'b0110000; // 3
			4:  segs = 7'b0011001; // 4
			5:  segs = 7'b0010010; // 5
			6:  segs = 7'b0000010; // 6
			7:  segs = 7'b1111000; // 7
			8:  segs = 7'b0000000; // 8
			9:  segs = 7'b0010000; // 9
			10: segs = 7'b0001000; // A
			11: segs = 7'b0000011; // B
			12: segs = 7'b1000110; // C
			13: segs = 7'b0100001; // D
			14: segs = 7'b0000110; // E
			15: segs = 7'b0001110; // F
			default: segs = 7'b0110110; // Error 
		endcase
		
endmodule
