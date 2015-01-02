`timescale 1ns / 1ps
`include "./defines.v"
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    18:06:32 11/20/2014 
// Design Name: 
// Module Name:    iocontroller 
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
module iocontroller #(parameter WIDTH = 32)
					(input clk, vga_clk, reset, 
					//Address
					input [7:0] mem_addr,
					//SWITCHES and LEDS
					input [7:0] SW_I, 
					output reg [7:0] LEDS,
					//MIC
					input mic_done,
					output reg mic_start,
					input [11:0] mic_data,
					//SPKR
					input spkr_update, 
					output reg [15:0] spkr_data, 
					output reg buffer_updated,
					//TOUCH
 					input [1:0] menu_in,
					input [2:0] filter,
					//Block_mem
					input [WIDTH-1:0] br_memdata_out, 
					output reg [WIDTH-1:0] br_memdata_in,
					output br_memwrite, br_memread,
					//Cell_mem
					input [15:0] cr_app_data_out,
					output reg [15:0] cr_app_data_in,	
					output cr_memwrite, cr_memread,
					//Processor
					input [WIDTH-1:0] data_out1, 
					input memwrite, mem_en, decode_state, io_rd, 
					//IODATA
					output reg [WIDTH-1:0] io_data);
					

	 
reg [15:0] speaker_buffer;
wire br;
reg [3:0] present_state, next_state;


// assign memread and write signals based on control signals from controller
assign br = !(mem_addr[7] || mem_addr[6] || mem_addr[5] || mem_addr[4] || mem_addr[3] || mem_addr[2] || mem_addr[1] || mem_addr[0]); 
/* if all mem_addr bits are low we are trying to access block ram*/
assign br_memread = (br && mem_en);
assign br_memwrite = (br && memwrite);
assign cr_memread = mem_addr[7] && mem_en && !memwrite;
assign cr_memwrite = mem_addr[7] && memwrite;



/////////////////////////////////////////////////////////////////////////////////////////////
//OUTPUT BLOCK- 
// used when processor is trying to store data. This includes the LEDS, the speaker, mic_start, and memory (cell and block)
/////////////////////////////////////////////////////////////////////////////////////////////
always@(posedge clk)
	if (reset)
		begin
		LEDS <= 8'd0;
		br_memdata_in <= 0;
		speaker_buffer <= 0;
		spkr_data <= 0;
		mic_start <= 0;
		buffer_updated <= 0;
		end
	else if (memwrite)
		casex (mem_addr)
			/* if the top value is a 1 then going to cellram. Set cellram to be the value in the data registers. 
				In this case we also set mic_start high because whenever we are storing to cellram we know we are in a loop
				where we are trying to get data from the mic and put it in cellram. */
			8'b1xxxxxxx: begin 
							cr_app_data_in <= data_out1[15:0]; // will be mic_data
							mic_start <= 1;
							end
			/* Storing to the mic causes the mic_start signal to be set low again. This needs to happen once for every set
				of data that the mic takes in because the mic will only start collecting data again when the mic_start signal
				goes from low to high. */
			`mic:		mic_start <= 0;
			/* This sets the value in the speaker equal to the value inside our speaker buffer register. We have a buffer register
				because it can take a few clock cycles to load a value from cell-ram and we want to always have a value ready to
				send to the speaker. In this case we also set buffer_updated high to awknowledge that the speaker done signal
				has been received. */
			`speaker:	begin spkr_data <= speaker_buffer;
							buffer_updated <= 1; end
			/* This loads the next value from cellram into our speaker buffer. It is actually from the register module, but for
				our application speaker data will always come from cellram through the processor. It also sets the value of 
				buffer updated low again in preparation for the next cycle. */
			`sp_bufr:	begin speaker_buffer <= data_out1[15:0];
							buffer_updated <= 0; end
			/* Store to leds */
			`leds:		LEDS <= data_out1[7:0];
			/* This stores to block ram */
			`block:		br_memdata_in <= data_out1;
		endcase


/////////////////////////////////////////////////////////////////////////////////////////////
//INPUT BLOCK- 
// used when processor is trying to load data. This needs to happen immediately because
// the processor tries to load it expects a response in the same state. Therefore it has an
// asyncronous response
/////////////////////////////////////////////////////////////////////////////////////////////
always@(*)
if (mem_en && !memwrite)
		casex (mem_addr)
			// if the top value is a 1 then going to cellram
			8'b1xxxxxxx: io_data = cr_app_data_out;
			// load from switches
			8'b00000010: io_data = {24'b0, SW_I};	//switches
			// load whether or not the mic is done.
			8'b00100000: io_data = {16'b0, mic_data, 4'b0};
			8'b00100001: io_data = {31'b0, mic_done};
			// load whether or not the speaker is done.
			8'b01000001: io_data = {31'b0, spkr_update};
			// load menu
			8'b00001000: io_data = {27'b0, filter, menu_in};
			// load value from block_ram
			8'b00000000: io_data = br_memdata_out; //is block ram used for anything besides vga and instructions?
			default: io_data = 0; //shouldn't happen
		endcase
else
	io_data = 0;

endmodule




