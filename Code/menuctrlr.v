`timescale 1ns / 1ps
`include "./defines.v"
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    15:22:21 11/30/2014 
// Design Name: 
// Module Name:    menuctrlr 
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
module menuctrlr(
	input clk, reset,
	input [5:0] menu2_cnt,
	input [11:0] tp_x, tp_y, tp_z, 
	output reg [1:0] menu_in,
	output reg [2:0] filter
    );

///////////////////////////////////////////////////////////////////////////////////
//
// This module needs to be updated to handle transitioning to the third menu when
// the progress bar is complete
// The touch values also need to be updated to their correct locations on the screen
// if need be
//
//////////////////////////////////////////////////////////////////////////////////////



///////////////////////////////////////////////////////////////
// assign control signals based on touch input to change states
////////////////////////////////////////////////////////////////

wire record, stop, record_new, no_touch, end_progress_bar, filter1, filter2, filter3, filter4;

assign record 		      = (tp_z < 12'h800) && (tp_x > 12'h750) && (tp_x < 12'h850) && (tp_y > 12'h9F0) && (tp_y < 12'hB90);
assign stop   			   = (tp_z < 12'h800) && (tp_x > 12'h690) && (tp_x < 12'h9C0) && (tp_y > 12'h650) && (tp_y < 12'h850);
assign record_new 	   = (tp_z < 12'h800) && (tp_x > 12'h780) && (tp_x < 12'hd90) && (tp_y > 12'h2E0) && (tp_y < 12'h460);
assign no_touch         = (tp_z > 12'hF00);
assign end_progress_bar = (menu2_cnt == 'd20);

//control signals for filter touch data
assign filter1 = (tp_z < 12'h800) && (tp_x > 12'h2A0) && (tp_x < 12'h410) && (tp_y > 12'h7A0) && (tp_y < 12'hB70);
assign filter2 = (tp_z < 12'h800) && (tp_x > 12'h590) && (tp_x < 12'h730) && (tp_y > 12'h7A0) && (tp_y < 12'hB70);
assign filter3 = (tp_z < 12'h800) && (tp_x > 12'h890) && (tp_x < 12'hA30) && (tp_y > 12'h7A0) && (tp_y < 12'hB70);
assign filter4 = (tp_z < 12'h800) && (tp_x > 12'hBC0) && (tp_x < 12'hD40) && (tp_y > 12'h7A0) && (tp_y < 12'hB70);


////////////////////////////////////////////////
// State Machine for Menus
//
// *wait states mean we are waiting for the user  
//	to release touch before moving to next menu*
/////////////////////////////////////////////////

reg [2:0] present_state, next_state;

always@(*)
	case(present_state)
		`menu1: 		if(record)
							next_state = `menu1_wait;
						else
							next_state = `menu1;
		`menu1_wait:if(no_touch)
							next_state = `menu2;
						else
							next_state = `menu1_wait;
		`menu2: 		if(stop)
							next_state = `menu2_wait;
						else if (end_progress_bar)
							next_state = `menu3;
						else
							next_state = `menu2;
		`menu2_wait:if(no_touch)
							next_state = `menu3;
						else
							next_state = `menu2_wait;
		`menu3: 		if(record_new)
							next_state = `menu3_wait;
						else
							next_state = `menu3;
		`menu3_wait:if(no_touch)
							next_state = `menu1;
						else
							next_state = `menu3_wait;
		default: next_state = `menu1;
	endcase

////////////////////////////////
// Sequential block
/////////////////////////////////

always@(posedge clk)
if (reset)
	present_state <= `menu1;
else
	present_state <= next_state;
	
/////////////////////////////////
// Output block
/////////////////////////////////

always@(posedge clk)
	case(present_state)
		`menu1:  	 begin
						 menu_in <= 2'b00;
						 filter  <= 3'd0;
						 end
		`menu1_wait: begin
						 menu_in <= 2'b00;
						 filter  <= 3'd0;
						 end
		`menu2: 		 begin
						 menu_in <= 2'b01;
						 filter  <= 3'd0;
						 end
		`menu2_wait: begin
						 menu_in <= 2'b01;
						 filter  <= 3'd0;
						 end						 
		`menu3: 		 begin
						 menu_in <= 2'b10;
						 if(filter1)
							filter  <= 3'd1;
						 else if(filter2)
							filter  <= 3'd2;
						 else if(filter3)
							filter  <= 3'd3;
						 else if(filter4)
							filter <=  3'd4;
						 else	
							filter <=  3'd0;
						 end											
		`menu3_wait: begin
						 menu_in <= 2'b10;
						 filter  <= 3'd0;
						 end
		default:		 begin
						 menu_in <= 2'b00;
						 filter  <= 3'd0;
						 end
	endcase
	
endmodule
