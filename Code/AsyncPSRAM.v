`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    11:12:16 02/19/2012 
// Design Name: 
// Module Name:    AsyncPSRAM 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: This module provides a simple interface to a common SRAM (static RAM) interface.
// In particular, it's designed for a 70ns Micron PSRAM part as included on the Digilent Nexys 2 and 3 dev boards.
// It will drive the 16-bit bidirectional data bus based on the state of the Output Enable line, and will also
// register the incoming value during a read which will remain persistently output until another read takes place.
// The inputs are self-describing. Wait until mem_idle is high, then setup the inputs and raise "go." When mem_idle
// goes low, you can de-assert go, and wait for the command to finish, signaled by mem_idle going high again. At that
// point it is safe to read data (if appropriate - The mem_data_in is not affected during a write.)
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
/* +------------------------------------------------------------------------------------------------------------------------------+
                                                      TERMS OF USE: MIT License                                                                                                              
   +------------------------------------------------------------------------------------------------------------------------------
   Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation     
   files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy,    
   modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software
   is furnished to do so, subject to the following conditions:                                                                   
                                                                                                                                 
   The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.
                                                                                                                                 
   THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE          
   WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR         
   COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,   
   ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.                         
   +------------------------------------------------------------------------------------------------------------------------------+

   This is a simple test application for the Digilent Nexys-3 which writes a value of 16'h1234 to the onboard PSRAM, reads the value
   back again, and displays the read value on the seven segment display.  A small Picoblaze processor is included to drive the
   interface to the PSRAM, which is documented in the AsyncPSRAM.v module.  The picoblaze is 8 bit and the memory is 16-bit, so it's
   not super efficient, but it works.
   
   */
//////////////////////////////////////////////////////////////////////////////////
module AsyncPSRAM(
	input sysclk,
	input rst,
	input [15:0] mem_data_out,
	input [25:0] mem_addr,
	input [1:0] mem_byte_en,
	input command,					// 0 = write, 1 = read
	input go,						// Signals that the command is ready to run.
	output reg mem_idle,			// 1 = unit is idle, ready for a command, 0 = busy.
	output reg [15:0] mem_data_in, 	// Contains last read data.
	output reg [25:0] MEM_ADDR_OUT, // To PSRAM address bus
	output reg MEM_CEN,				// To PSRAM chip enable
	output reg MEM_OEN,				// To PSRAM output enable
	output reg MEM_WEN,				// To PSRAM write enable
	output reg MEM_LBN,				// To PSRAM low byte write enable
	output reg MEM_UBN,				// To PSRAM high byte write enable
	output MEM_ADV,					// To PSRAM address valid line
	inout [15:0] MEM_DATA			// To PSRAM data bus
    );

reg [15:0] inp = 0;
reg [15:0] a = 0;
reg [15:0] b = 0;
wire [15:0] outp;
reg [25:0] active_addr = 0;
reg [3:0] waitcount = 0;
reg [1:0] waitcount2 = 0;
reg current_cmd;

assign MEM_ADV = 0;						// Tied low for async access.

// Bidirectional memory data bus
assign MEM_DATA = MEM_OEN ? a : 16'bz; //Active low signal.  Tri-state when OE is low, allowing incoming data to get to b and outp. Otherwise, drive the bus with A.
assign outp  = b;
always @ (posedge sysclk)
begin
    b <= MEM_DATA;
    a <= mem_data_out;
end

parameter st_RESET 			= 	2'b01;
parameter st_COUNT		 	= 	2'b10;
parameter st_HOLD				=  2'b11;

(* FSM_ENCODING="ONE-HOT", SAFE_IMPLEMENTATION="YES" *) reg [1:0] state = 0;
always @(posedge sysclk) begin
	if (rst) begin
		state <= st_RESET;
		mem_idle <= 1'b1;
		mem_data_in <= 0;
		current_cmd <= 1;
		MEM_CEN <= 1'b1;
		MEM_OEN <= 1'b1;
		MEM_WEN <= 1'b1;
		MEM_ADDR_OUT <= 0;
		MEM_LBN <= 1;
		MEM_UBN <= 1;		
		end
	else
	case (state)
		st_RESET: begin						// Wait for incoming command.
			if (go)
				state <= st_COUNT;
			else
				state <= st_RESET;
			
			if (go) begin					// Got a command.
				MEM_ADDR_OUT <= mem_addr;	// Latch the address
				mem_idle <= 1'b0;			// Tell caller we're busy now.
				current_cmd <= command;		// Save current command for later.
				MEM_OEN <= ~command;		// Setup OEN/WEN based on the command.
				MEM_WEN <= command;
				MEM_CEN <= 1'b0;
				MEM_LBN <= mem_byte_en[0];	// Set the write mask bits.
				MEM_UBN <= mem_byte_en[1];
			end
			else begin
				MEM_ADDR_OUT <= 26'hXXXXXXX;	// No command yet, just wait.
				current_cmd <= 1'b1;
				mem_idle <= 1'b1;
				MEM_OEN <= 1'b1;
				MEM_WEN <= 1'b1;
				MEM_CEN <= 1'b1;
				MEM_LBN <= 1;
				MEM_UBN <= 1;
			end
		end
		
		st_COUNT: begin
			// If using a sysclk other than 100Mhz (10ns period) you must adjust the number of wait states accordingly below.
			if (((waitcount == 8/*6*/) && (current_cmd == 0)) || (waitcount == 9))  // If count 6 (during write) or 7 (during read), we're done after this cycle.
				state <= st_HOLD; /* RESET;*/
			else
				state <= st_COUNT;
				
			if ((waitcount == 8 /*6*/) && (current_cmd == 0)) begin	// This is a write command.  We bail out as soon as the 70ns is completed.
				MEM_OEN <= 1'b1;		// Positive strobe latches address and data in.
				MEM_WEN <= 1'b1;
				MEM_CEN <= 1'b1;
				waitcount <= 0;
				mem_idle <= 1'b1;		// We'll be idle next cycle and ready for new commands.
			end
			else if (waitcount == 9/*7*/) begin	// This is a read command.  We have to wait the 70ns, and then use one more cycle to latch in the incoming data.
				MEM_OEN <= 1'b1;			// Positive strobe latches address and data in.
				MEM_WEN <= 1'b1;
				MEM_CEN <= 1'b1;
				waitcount <= 0;
				mem_idle <= 1'b1;
				if (current_cmd == 1)
					mem_data_in <= outp;	// Grab read data on read cycles.
				else
					$display("Got to 7th waitstate without a read command! (Should never happen.)");
				end
			else							// We are still mid-wait.  Go another 10ns and reevaluate.
				waitcount <= waitcount + 1;
		end	
		 st_HOLD: begin
			// If using a sysclk other than 100Mhz (10ns period) you must adjust the number of wait states accordingly below.
			if (waitcount2 == 2)
				state <= st_RESET; /* RESET;*/
			else
				state <= st_HOLD;
			
			mem_idle <= 1'b1;
			MEM_OEN <= 1'b1;
			MEM_WEN <= 1'b1;
			MEM_CEN <= 1'b1;
				
			if (waitcount2 == 2)
				waitcount2 <= 0;
			else							// We are still mid-wait.  Go another 10ns and reevaluate.
				waitcount2 <= waitcount2 + 1;
		end
	
	endcase
end

endmodule
