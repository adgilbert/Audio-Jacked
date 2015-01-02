`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    14:32:19 11/06/2014 
// Design Name: 
// Module Name:    menus 
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
module menus(input clk, rst, 
				input [5:0] i,
				input [9:0] hcnt,vcnt,
				input [1:0] menu,
				input [2:0] filter,
				output reg [13:0] glyph	// glyph is going to which glyph is being used. 0-5 is the hcnt and vcnt. 6-11 chooses the glyph
				//output reg cnt_en
			);	
		
	// The block RAM contains what color the each pixel in the glyph is. The memory addresses that are assigned
	// are coming from the block RAM. The locations in memory starts at 32KB (hex 7D00??)
	
	always @(posedge clk)
	begin
		if (rst)
			glyph[7:0] <= 'd0;
		else
			glyph [7:0] <= {hcnt[3:0], vcnt[3:0]};
	end
	
	always @(posedge clk)
	begin
		if (rst)
				glyph[13:8] <= 'd0;
		else
		case (menu)
		
		'd0: begin
				if((hcnt[9:4] >= 'd0 && hcnt[9:4] <= 'd30 && vcnt[9:4] <= 'd2 && vcnt[9:4] >= 'd0) ||			// Top blue
				   (hcnt[9:4] >= 'd0 && hcnt[9:4] <= 'd30 && vcnt[9:4] >= 'd15 && vcnt[9:4] <= 'd17))			// Bottom blue
					glyph[13:8] <= 'd0;		// This is the first glyph, which is the blue background
				else if (vcnt[9:4] >= 'd3 && vcnt[9:4] <= 'd14 && 
						(hcnt[9:4] >= 'd0 && hcnt[9:4] <= 'd2 || hcnt[9:4] >= 'd28 && hcnt[9:4] <= 'd30))	// Blue right and left side of menu
					glyph[13:8] <= 'd0;		
				else if ((vcnt[9:4] >= 'd3 && vcnt[9:4] <= 'd6 && hcnt[9:4] >= 'd3 && hcnt[9:4] <= 'd27) ||	// Top grey part of menu
						(vcnt[9:4] >= 'd8 && vcnt[9:4] <= 'd10 && hcnt[9:4] >= 'd3 && hcnt[9:4] <= 'd27) ||  // Grey in between lettering and record sign
						(vcnt[9:4] == 'd7 && hcnt[9:4] >= 'd3 && hcnt[9:4] <= 'd7))					// Grey before the lettering
					glyph[13:8] <= 'd1;
				else if (vcnt[9:4] == 'd7 && hcnt[9:4] == 'd8)
					glyph[13:8] <= 'd27;								// P
				else if (vcnt[9:4] == 'd7 && hcnt[9:4] == 'd9)
					glyph[13:8] <= 'd29;								// R
				else if (vcnt[9:4] == 'd7 && hcnt[9:4] == 'd10)
					glyph[13:8] <= 'd16;								// E
				else if (vcnt[9:4] == 'd7 && hcnt[9:4] == 'd11)
					glyph[13:8] <= 'd30;								// S
				else if (vcnt[9:4] == 'd7 && hcnt[9:4] == 'd12)
					glyph[13:8] <= 'd30;								// S
				else if (vcnt[9:4] == 'd7 && hcnt[9:4] == 'd13)
					glyph[13:8] <= 'd1;								// grey space
				else if (vcnt[9:4] == 'd7 && hcnt[9:4] == 'd14)
					glyph[13:8] <= 'd31;								// T
				else if (vcnt[9:4] == 'd7 && hcnt[9:4] == 'd15)
					glyph[13:8] <= 'd26;								// O
				else if (vcnt[9:4] == 'd7 && hcnt[9:4] == 'd16)
					glyph[13:8] <= 'd1;								// grey space
				else if (vcnt[9:4] == 'd7 && hcnt[9:4] == 'd17)
					glyph[13:8] <= 'd29;								// R
				else if (vcnt[9:4] == 'd7 && hcnt[9:4] == 'd18)
					glyph[13:8] <= 'd16;								// E
				else if (vcnt[9:4] == 'd7 && hcnt[9:4] == 'd19)
					glyph[13:8] <= 'd14;								// C
				else if (vcnt[9:4] == 'd7 && hcnt[9:4] == 'd20)
					glyph[13:8] <= 'd26;								// O
				else if (vcnt[9:4] == 'd7 && hcnt[9:4] == 'd21)
					glyph[13:8] <= 'd29;								// R
				else if (vcnt[9:4] == 'd7 && hcnt[9:4] == 'd22)
					glyph[13:8] <= 'd15;								// D
				else if (vcnt[9:4] == 'd7 && hcnt[9:4] >= 'd23 && hcnt[9:4] <= 'd27)
					glyph[13:8] <= 'd1;								// Grey space after the lettering
				else if ((vcnt[9:4] == 'd11 && hcnt[9:4] >= 'd3 && hcnt[9:4] <= 'd14) ||	// Grey space before record sign
						 (vcnt[9:4] == 'd11 && hcnt[9:4] >= 'd16 && hcnt[9:4] <= 'd27))	// Grey space after record sign
					glyph[13:8] <= 'd1;				
				else if (vcnt[9:4] == 'd11 && hcnt[9:4] == 'd15)
					glyph[13:8] <= 'd38;								// Record sign
				else if (vcnt[9:4] >= 'd12 && vcnt[9:4] <= 'd14 && hcnt[9:4] >= 'd3 && hcnt[9:4] <= 'd27)	// Bottom grey of menu
					glyph[13:8] <= 'd1;
				else 
					glyph[13:8] <= 'd0;		// Shouldn't happen
			end
		
		'd1: begin
				if((hcnt[9:4] >= 'd0 && hcnt[9:4] <= 'd30 && vcnt[9:4] <= 'd2 && vcnt[9:4] >= 'd0) ||			// Top blue
				   (hcnt[9:4] >= 'd0 && hcnt[9:4] <= 'd30 && vcnt[9:4] >= 'd15 && vcnt[9:4] <= 'd17))			// Bottom blue
					glyph[13:8] <= 'd0;		// This is the first glyph, which is the blue background
				else if (vcnt[9:4] >= 'd3 && vcnt[9:4] <= 'd14 && 
						(hcnt[9:4] >= 'd0 && hcnt[9:4] <= 'd2 || hcnt[9:4] >= 'd28 && hcnt[9:4] <= 'd30))	// Blue right and left side of menu
					glyph[13:8] <= 'd0;		
				else if ((vcnt[9:4] >= 'd3 && vcnt[9:4] <= 'd4 && hcnt[9:4] >= 'd3 && hcnt[9:4] <= 'd27) ||	// Top grey part of menu
						 (vcnt[9:4] >= 'd13 && vcnt[9:4] <= 'd14 && hcnt[9:4] >= 'd3 && hcnt[9:4] <= 'd27) || 	// Bottom grey of menu
						 (vcnt[9:4] == 'd5 && hcnt[9:4] >= 'd3 && hcnt[9:4] <= 'd5))						// Grey before lettering
					glyph[13:8] <= 'd1;
				else if (vcnt[9:4] == 'd5 && hcnt[9:4] == 'd6)
					glyph[13:8] <= 'd29;								// R
				else if (vcnt[9:4] == 'd5 && hcnt[9:4] == 'd7)
					glyph[13:8] <= 'd16; 								// E
				else if (vcnt[9:4] == 'd5 && hcnt[9:4] == 'd8)
					glyph[13:8] <= 'd14;								// C
				else if (vcnt[9:4] == 'd5 && hcnt[9:4] == 'd9)
					glyph[13:8] <= 'd26;								// O
				else if (vcnt[9:4] == 'd5 && hcnt[9:4] == 'd10)
					glyph[13:8] <= 'd29;								// R
				else if (vcnt[9:4] == 'd5 && hcnt[9:4] == 'd11)
					glyph[13:8] <= 'd15;								// D
				else if (vcnt[9:4] == 'd5 && hcnt[9:4] == 'd12)
					glyph[13:8] <= 'd20;								// I
				else if (vcnt[9:4] == 'd5 && hcnt[9:4] == 'd13)
					glyph[13:8] <= 'd25;								// N
				else if (vcnt[9:4] == 'd5 && hcnt[9:4] == 'd14)
					glyph[13:8] <= 'd18;								// G
				else if (vcnt[9:4] == 'd5 && hcnt[9:4] == 'd15)
					glyph[13:8] <= 'd1;								// grey space 
				else if (vcnt[9:4] == 'd5 && hcnt[9:4] == 'd16)
					glyph[13:8] <= 'd14;								// C
				else if (vcnt[9:4] == 'd5 && hcnt[9:4] == 'd17)	
					glyph[13:8] <= 'd12; 								// A
				else if (vcnt[9:4] == 'd5 && hcnt[9:4] == 'd18)
					glyph[13:8] <= 'd25;								// N
				else if (vcnt[9:4] == 'd5 && hcnt[9:4] == 'd19)
					glyph[13:8] <= 'd1;								// grey space
				else if (vcnt[9:4] == 'd5 && hcnt[9:4] == 'd20)
					glyph[13:8] <= 'd13;								// B
				else if (vcnt[9:4] == 'd5 && hcnt[9:4] == 'd21)
					glyph[13:8] <= 'd16;								// E
				else if (vcnt[9:4] == 'd5 && hcnt[9:4] == 'd22)
					glyph[13:8] <= 'd1;								// grey space
				else if (vcnt[9:4] == 'd5 && hcnt[9:4] == 'd23)
					glyph[13:8] <= 'd12;								// A
				else if ((vcnt[9:4] == 'd5 && hcnt[9:4] >= 'd24 && hcnt[9:4] <= 'd27) ||	// Grey after lettering
						 (vcnt[9:4] == 'd6 && hcnt[9:4] >= 'd3 && hcnt[9:4] <= 'd6))	// Grey before lettering
					glyph[13:8] <= 'd1;
				else if (vcnt[9:4] == 'd6 && hcnt[9:4] == 'd7)
					glyph[13:8] <= 'd24;								// M
				else if (vcnt[9:4] == 'd6 && hcnt[9:4] == 'd8)
					glyph[13:8] <= 'd12;								// A
				else if (vcnt[9:4] == 'd6 && hcnt[9:4] == 'd9)
					glyph[13:8] <= 'd35;								// X
				else if (vcnt[9:4] == 'd6 && hcnt[9:4] == 'd10)
					glyph[13:8] <= 'd1;								// grey space
				else if (vcnt[9:4] == 'd6 && hcnt[9:4] == 'd11)
					glyph[13:8] <= 'd26; 								// O
				else if (vcnt[9:4] == 'd6 && hcnt[9:4] == 'd12)
					glyph[13:8] <= 'd17;								// F
				else if (vcnt[9:4] == 'd6 && hcnt[9:4] == 'd13)
					glyph[13:8] <= 'd1;								// grey space
				else if (vcnt[9:4] == 'd6 && hcnt[9:4] == 'd14)
					glyph[13:8] <= 'd4;								// 2
				else if (vcnt[9:4] == 'd6 && hcnt[9:4] == 'd15)
					glyph[13:8] <= 'd26;								// 0
				else if (vcnt[9:4] == 'd6 && hcnt[9:4] == 'd16)
					glyph[13:8] <= 'd1;								// grey space
				else if (vcnt[9:4] == 'd6 && hcnt[9:4] == 'd17)
					glyph[13:8] <= 'd30;								// S
				else if (vcnt[9:4] == 'd6 && hcnt[9:4] == 'd18)
					glyph[13:8] <= 'd16;								// E
				else if (vcnt[9:4] == 'd6 && hcnt[9:4] == 'd19)
					glyph[13:8] <= 'd14;								// C
				else if (vcnt[9:4] == 'd6 && hcnt[9:4] == 'd20)
					glyph[13:8] <= 'd26;								// O
				else if (vcnt[9:4] == 'd6 && hcnt[9:4] == 'd21)
					glyph[13:8] <= 'd25;								// N
				else if (vcnt[9:4] == 'd6 && hcnt[9:4] == 'd22)
					glyph[13:8] <= 'd15;								// D
				else if (vcnt[9:4] == 'd6 && hcnt[9:4] == 'd23)
					glyph[13:8] <= 'd30;								// S
				else if ((vcnt[9:4] == 'd6 && hcnt[9:4] >= 'd24 && hcnt[9:4] <= 'd27) ||	// Grey after lettering
						 ((vcnt[9:4] == 'd7 || vcnt[9:4] == 'd9) && hcnt[9:4] >= 'd3 && hcnt[9:4] <= 'd27) || 	// line of grey as a spacer
						 (vcnt[9:4] == 'd8 && ((hcnt[9:4] >= 'd3 && hcnt[9:4] <= 'd11) || (hcnt[9:4] >= 'd18 && hcnt[9:4] <= 'd27))) || // Grey before and after stop
						 ((vcnt[9:4] == 'd10 || vcnt[9:4] == 'd12) && 
						 (hcnt[9:4] == 'd3 || hcnt[9:4] == 'd27)))	// Grey before and after progress bar		
					glyph[13:8] <= 'd1;
				else if (vcnt[9:4] == 'd8 && hcnt[9:4] == 'd12)
					glyph[13:8] <= 'd30;								// S
				else if (vcnt[9:4] == 'd8 && hcnt[9:4] == 'd13)
					glyph[13:8] <= 'd31;								// T
				else if (vcnt[9:4] == 'd8 && hcnt[9:4] == 'd14)
					glyph[13:8] <= 'd26;								// O
				else if (vcnt[9:4] == 'd8 && hcnt[9:4] == 'd15)
					glyph[13:8] <= 'd27;								// P
				else if (vcnt[9:4] == 'd8 && hcnt[9:4] == 'd16)
					glyph[13:8] <= 'd1;								// grey space
				else if (vcnt[9:4] == 'd8 && hcnt[9:4] == 'd17)
					glyph[13:8] <= 'd39;								// Stop sign. Next "else if" is for progress bar
				else if ((vcnt[9:4] == 'd10 || vcnt[9:4] == 'd12) && (hcnt[9:4] == 'd4 || hcnt[9:4] == 'd26))
					glyph[13:8] <= 'd1;								// Needed one grey spot so that the bar lines up
				else if (vcnt[9:4] == 'd10 && hcnt[9:4] >= 'd5 && hcnt[9:4] <= 'd25)
					glyph[13:8] <= 'd43;								// top line of the progress bar
				else if (vcnt[9:4] == 'd12 && hcnt[9:4] >= 'd5 && hcnt[9:4] <= 'd25)
					glyph[13:8] <= 'd44;								// bottom line of progress bar
				else if (vcnt[9:4] == 'd11)  // This segment is for the entire color of row 11
				begin												// Movement of color across the progress bar
					if(i >= 'd0 && i <= 'd19)
						if (hcnt[9:4] >= 'd5 && hcnt[9:4] <= ('d5 + i))
							glyph[13:8] <= 'd41;				// Moves blue across progress bar
						else if (hcnt[9:4] >= ('d6 + i) && hcnt[9:4] <= 'd25)
							glyph[13:8] <= 'd1;					// Shortens the range for grey in the bar as i increases
						else if (hcnt[9:4] == 'd4)
							glyph[13:8] <= 'd42;				// left line of progress bar
						else if (hcnt[9:4] == 'd26)
							glyph[13:8] <= 'd45;				// right line of progress bar
						else if (hcnt[9:4] == 'd3 || hcnt[9:4] == 'd27)
							glyph[13:8] <= 'd1;					// fill outside the region of the progress bar line
						else if((hcnt[9:4] >= 'd0 && hcnt <= 'd2) || (hcnt[9:4] >= 'd28 && hcnt[9:4] <= 'd30)) 
							glyph[13:8] <= 'd0;					// fill outside of the menu hcnt: 0-2 and 28-30
						else
							glyph[13:8] <= 'd0; 	// shouldn't happen
					else if (i == 'd20)
						if (hcnt[9:4] >= 'd5 && hcnt[9:4] <= 'd25)
							glyph[13:8] <= 'd41;				// Progress bar filled
						else if (hcnt[9:4] == 'd4)
							glyph[13:8] <= 'd42;				// left line of progress bar
						else if (hcnt[9:4] == 'd26)
							glyph[13:8] <= 'd45;				// right line of progress bar
						else if (hcnt[9:4] == 'd3 || hcnt[9:4] == 'd27)
							glyph[13:8] <= 'd1;					// fill outside the region of the progress bar line
						else if((hcnt[9:4] >= 'd0 && hcnt <= 'd2) || (hcnt[9:4] >= 'd28 && hcnt[9:4] <= 'd30))
							glyph[13:8] <= 'd0;					// Outside of menu hcnt: 0-2 and 28-30
						else
							glyph[13:8] <= 'd0; 	// shouldn't happen
					else
						glyph[13:8] <= 'd1;		// Shouldn't happen since i should not go higher than 20
				end
				else
					glyph[13:8] <= 'd1;			// shouldn't happen
			end                                              
		                                                     
		'd2: begin
				if((hcnt[9:4] >= 'd0 && hcnt[9:4] <= 'd30 && vcnt[9:4] <= 'd1 && vcnt[9:4] >= 'd0) ||			// Top blue
				   (hcnt[9:4] >= 'd0 && hcnt[9:4] <= 'd30 && vcnt[9:4] >= 'd16 && vcnt[9:4] <= 'd17))			// Bottom blue
					glyph[13:8] <= 'd0;		// This is the first glyph, which is the blue background
				else if (vcnt[9:4] >= 'd2 && vcnt[9:4] <= 'd15 && 
						((hcnt[9:4] >= 'd0 && hcnt[9:4] <= 'd1) || (hcnt[9:4] >= 'd29 && hcnt[9:4] <= 'd30)))	// Blue right and left side of menu
					glyph[13:8] <= 'd0;
				else if (vcnt[9:4] == 'd5 && (hcnt[9:4] == 'd3 || (hcnt[9:4] >= 'd15 && hcnt[9:4] <= 'd28)))
					glyph[13:8] <= 'd1;								// Grey before and after "Operations:"
				else if (vcnt[9:4] == 'd2 && ((hcnt[9:4] >= 'd2 && hcnt[9:4] <= 'd13) || (hcnt[9:4] >= 'd26 && hcnt[9:4] <= 'd28))) 
					glyph[13:8] <= 'd1;								// before top line of record new and after
				else if (vcnt[9:4] == 'd2 && hcnt[9:4] >= 'd14 && hcnt[9:4] <= 'd25)
					glyph[13:8] <= 'd43;								// top line of record new
				else if (vcnt[9:4] == 'd5 && hcnt[9:4] == 'd4)
					glyph[13:8] <= 'd26;								// O
				else if (vcnt[9:4] == 'd5 && hcnt[9:4] == 'd5)
					glyph[13:8] <= 'd27;								// P
				else if (vcnt[9:4] == 'd5 && hcnt[9:4] == 'd6)
					glyph[13:8] <= 'd16;								// E
				else if (vcnt[9:4] == 'd5 && hcnt[9:4] == 'd7)
					glyph[13:8] <= 'd29;								// R
				else if (vcnt[9:4] == 'd5 && hcnt[9:4] == 'd8)
					glyph[13:8] <= 'd12;								// A
				else if (vcnt[9:4] == 'd5 && hcnt[9:4] == 'd9)
					glyph[13:8] <= 'd31;								// T
				else if (vcnt[9:4] == 'd5 && hcnt[9:4] == 'd10)
					glyph[13:8] <= 'd20;								// I
				else if (vcnt[9:4] == 'd5 && hcnt[9:4] == 'd11)
					glyph[13:8] <= 'd26;								// O
				else if (vcnt[9:4] == 'd5 && hcnt[9:4] == 'd12)
					glyph[13:8] <= 'd25;								// N
				else if (vcnt[9:4] == 'd5 && hcnt[9:4] == 'd13)
					glyph[13:8] <= 'd30;								// S
				else if (vcnt[9:4] == 'd5 && hcnt[9:4] == 'd14)
					glyph[13:8] <= 'd40;								// :
				else if (vcnt[9:4] == 'd3 && hcnt[9:4] == 'd13)
					glyph[13:8] <= 'd42;								// left line of record new
				else if (vcnt[9:4] == 'd3 && hcnt[9:4] == 'd14)
					glyph[13:8] <= 'd1;								// grey space
				else if (vcnt[9:4] == 'd3 && hcnt[9:4] == 'd15)
					glyph[13:8] <= 'd29;								// R
				else if (vcnt[9:4] == 'd3 && hcnt[9:4] == 'd16)
					glyph[13:8] <= 'd16;								// E
				else if (vcnt[9:4] == 'd3 && hcnt[9:4] == 'd17)
					glyph[13:8] <= 'd14;								// C
				else if (vcnt[9:4] == 'd3 && hcnt[9:4] == 'd18)
					glyph[13:8] <= 'd26;								// O
				else if (vcnt[9:4] == 'd3 && hcnt[9:4] == 'd19)
					glyph[13:8] <= 'd29;								// R 
				else if (vcnt[9:4] == 'd3 && hcnt[9:4] == 'd20)
					glyph[13:8] <= 'd15;								// D	
				else if (vcnt[9:4] == 'd3 && hcnt[9:4] == 'd21)
					glyph[13:8] <= 'd1;								// grey space
				else if (vcnt[9:4] == 'd3 && hcnt[9:4] == 'd22)
					glyph[13:8] <= 'd25;								// N
				else if (vcnt[9:4] == 'd3 && hcnt[9:4] == 'd23)
					glyph[13:8] <= 'd16;								// E
				else if (vcnt[9:4] == 'd3 && hcnt[9:4] == 'd24)
					glyph[13:8] <= 'd34;								// W
				else if (vcnt[9:4] == 'd3 && hcnt[9:4] == 'd25)
					glyph[13:8] <= 'd1;								// grey space		
				else if (vcnt[9:4] == 'd3 && hcnt[9:4] == 'd26)
					glyph[13:8] <= 'd45;								// right line of record new box
				else if (vcnt[9:4] == 'd4 && ((hcnt[9:4] >= 'd2 && hcnt[9:4] <= 'd13) || (hcnt[9:4] >= 'd26 && hcnt[9:4] <= 'd28)))
					glyph[13:8] <= 'd1;								// grey before and after bottom line of record new
				else if (vcnt[9:4] == 'd4 && hcnt[9:4] >= 'd14 && hcnt[9:4] <= 'd25)
					glyph[13:8] <= 'd44;								// bottom line of record new
				else if (vcnt[9:4] == 'd6 && hcnt[9:4] >= 'd2 && hcnt[9:4] <= 'd28)
					glyph[13:8] <= 'd1;
				else if (vcnt[9:4] == 'd7 && ((hcnt[9:4] >= 'd2 && hcnt[9:4] <= 3) || 
											  (hcnt[9:4] >= 'd8 && hcnt[9:4] <= 9) ||
											  (hcnt[9:4] >= 'd14 && hcnt[9:4] <= 15) ||
											  (hcnt[9:4] >= 'd20 && hcnt[9:4] <= 21) ||
											  (hcnt[9:4] >= 'd26 && hcnt[9:4] <= 'd28)))
					glyph[13:8] <= 'd1;								// grey on line of top lines of boxes
				else if (vcnt[9:4] == 'd7 && ((hcnt[9:4] >= 'd4 && hcnt[9:4] <= 'd7) || 
											   (hcnt[9:4] >= 'd10 && hcnt[9:4] <= 'd13) || 
											   (hcnt[9:4] >= 'd16 && hcnt[9:4] <= 'd19) ||
											   (hcnt[9:4] >= 'd22 && hcnt[9:4] <= 'd25)))
					glyph[13:8] <= 'd43;								// top line first box
				else if ((vcnt[9:4] >= 'd8 && vcnt[9:4] <= 'd12) && ((hcnt[9:4] == 'd2) ||
																	 (hcnt[9:4] >= 'd27 && hcnt[9:4] <= 'd28) ))
					glyph[13:8] <= 'd1;								// Grey fill in between boxes
				else if (vcnt[9:4] >= 'd8 && vcnt[9:4] <= 'd12 && (hcnt[9:4] == 'd3 || hcnt[9:4] == 'd9 || hcnt[9:4] == 'd15 || hcnt[9:4] == 'd21)) 
					glyph[13:8] <= 'd42;								// left line for boxes
				else if (vcnt[9:4] >= 'd8 && vcnt[9:4] <= 'd12 && (hcnt[9:4] == 'd8 || hcnt[9:4] == 'd14 || hcnt[9:4] == 'd20 || hcnt[9:4] == 'd26))
					glyph[13:8] <= 'd45;								// Right line for boxes
					
				////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
				// added filter input to make the box blue if touched
				////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
				else if ((vcnt[9:4] == 'd8 || vcnt[9:4] == 'd9 || vcnt[9:4] == 'd11 || vcnt[9:4] == 'd12) && (hcnt[9:4] >= 'd4 && hcnt[9:4] <= 'd7))
							if (filter == 'd1)
								glyph [13:8] <= 'd0;
							else glyph [13:8] <= 'd1;
				else if ((vcnt[9:4] == 'd8 || vcnt[9:4] == 'd9 || vcnt[9:4] == 'd11 || vcnt[9:4] == 'd12) && (hcnt[9:4] >= 'd10 && hcnt[9:4] <= 'd13))
							if (filter == 'd2)
								glyph [13:8] <= 'd0;
							else glyph [13:8] <= 'd1;
				else if ((vcnt[9:4] == 'd8 || vcnt[9:4] == 'd9 || vcnt[9:4] == 'd11 || vcnt[9:4] == 'd12) && (hcnt[9:4] >= 'd16 && hcnt[9:4] <= 'd19))
							if (filter == 'd3)
								glyph [13:8] <= 'd0;
							else glyph [13:8] <= 'd1;
				else if ((vcnt[9:4] == 'd8 || vcnt[9:4] == 'd9 || vcnt[9:4] == 'd11 || vcnt[9:4] == 'd12) && (hcnt[9:4] >= 'd22 && hcnt[9:4] <= 'd25))
							if (filter == 'd4)
								glyph [13:8] <= 'd0;
							else glyph [13:8] <= 'd1; 			// Grey in the boxes above and below the number. The number will appear on line 15
				///////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////////
				
				/////////////////////////////////////////////////////////////////////////////////////////////////////////////////
				// added filter input to make the box blue if touched
				/////////////////////////////////////////////////////////////////////////////////////////////////////////////////
				else if (vcnt[9:4] == 'd10 && (hcnt[9:4] == 'd4 || hcnt[9:4] == 'd6 || hcnt[9:4] == 'd7)) // first box
							if (filter == 'd1)
								glyph [13:8] <= 'd0;
							else glyph [13:8] <= 'd1;
				else if (vcnt[9:4] == 'd10 && (hcnt[9:4] == 'd10 || hcnt[9:4] == 'd12 || hcnt[9:4] == 'd13)) //second box 
							if (filter == 'd2)
								glyph [13:8] <= 'd0;
							else glyph [13:8] <= 'd1;
				else if (vcnt[9:4] == 'd10 && (hcnt[9:4] == 'd16 || hcnt[9:4] == 'd18 || hcnt[9:4] == 'd19)) //third box
							if (filter == 'd3)
								glyph [13:8] <= 'd0;
							else glyph [13:8] <= 'd1; 
				else if (vcnt[9:4] == 'd10 && (hcnt[9:4] == 'd22 || hcnt[9:4] == 'd24 || hcnt[9:4] == 'd25)) //fourth box box
							if (filter == 'd4)
								glyph [13:8] <= 'd0;
							else glyph [13:8] <= 'd1; // Grey before and after lettering in each box for the 3 in line
				//////////////////////////////////////////////////////////////////////////////////////////////////////////////////////							   
	
							
				else if (vcnt[9:4] == 'd10 && hcnt[9:4] == 'd5)		// placing the numbers into the boxes
					glyph[13:8] <= 'd3;						// 1
				else if (vcnt[9:4] == 'd10 && hcnt[9:4] == 'd11)
					glyph[13:8] <= 'd4;						// 2	
				else if (vcnt[9:4] == 'd10 && hcnt[9:4] == 'd17)
					glyph[13:8] <= 'd5;						// 3
				else if (vcnt[9:4] == 'd10 && hcnt[9:4] == 'd23)
					glyph[13:8] <= 'd6;						// 4
				else if (vcnt[9:4] == 'd13 && ((hcnt[9:4] >= 'd4 && hcnt[9:4] <= 'd7) || 
											   (hcnt[9:4] >= 'd10 && hcnt[9:4] <= 'd13) || 
											   (hcnt[9:4] >= 'd16 && hcnt[9:4] <= 'd19) ||
											   (hcnt[9:4] >= 'd22 && hcnt[9:4] <= 'd25)))
					glyph[13:8] <= 'd44;						// Bottom line for the first 3 boxes
				else if (vcnt[9:4] == 'd13 && ((hcnt[9:4] >= 'd2 && hcnt[9:4] <= 3) || 
											  (hcnt[9:4] >= 'd8 && hcnt[9:4] <= 9) ||
											  (hcnt[9:4] >= 'd14 && hcnt[9:4] <= 15) ||
											  (hcnt[9:4] >= 'd20 && hcnt[9:4] <= 21) ||
											  (hcnt[9:4] >= 'd26 && hcnt[9:4] <= 'd28)))
					glyph[13:8] <= 'd1; 						// Grey in between the bottom lines of the boxes
				else if (vcnt[9:4] >= 'd14 && vcnt[9:4] <= 'd15 && hcnt[9:4] >= 'd2 && hcnt[9:4] <= 'd28)
					glyph[13:8] <= 'd1;						// bottom grey of menu
				else
					glyph[13:8] <= 'd1; 						//Shouldn't happen
			end                                              
		                                                     
		                                                     
	default:	glyph[13:8] <= 'd0;                              
	endcase                                                  
				                                             
	                                                         
	                                                         
	end                                                      

endmodule