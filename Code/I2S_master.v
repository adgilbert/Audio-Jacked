`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    12:18:58 11/19/2014 
// Design Name: 
// Module Name:    I2S_master 
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
//	Currently set for 16 bit input values
// 	with one sample per channel 
// 	and sampling at 8KHz
//
//	Serial clock (s_clk) is derived from Master Clock (m_clk)
//		and Left/Right channel clock (LR_clk) is dependent on s_clk
//
//////////////////////////////////////////////////////////////////////////////////
module I2S_master #(parameter Fs       = 8000,			// The sampling frequency 
						  parameter DIN_W    = 16,				// Data input width
						  parameter FPGA_CLK = 100000000,	// FPGA clock used to clock the hardware
						  parameter LR_SAM   = 1)				// samples per channel
  (input      clk, 
	input		  rst,
	input      [(DIN_W-1):0] data_in,	// Data buffer that will get shifted out	  
	output reg m_clk, 						// master clock (only used as "chip select")
	output reg LR_clk, 						// Clock to choose current channel
	output reg s_clk,							// Clock that data is shifted in on
	output reg DONE,							// buffer is ready for the next input
	output reg data_out);					// the current output bit

//	$clog2(INTEGER) ceiling's the log2 of an integer
	reg [$clog2(DIN_W * LR_SAM):0] LR_count;						// s_clk's in 1/2 LR_clk
	reg [$clog2((FPGA_CLK*LR_SAM)/(2*Fs*DIN_W)):0] s_count;
	reg [$clog2((FPGA_CLK*LR_SAM)/(2*Fs*DIN_W)):0] s_max;
	reg [$clog2(DIN_W)-1:0] shift_count_0;
	reg [$clog2(DIN_W)-1:0] shift_count_1;
	
	
// state machine registers
	reg [1:0] NS, PS;
	
	
// state machine parameters
	parameter IDLE   = 2'b00,
				 CHAN_0 = 2'b01,
				 CHAN_1 = 2'b10;
	
	
always @ (posedge clk) begin
		s_max <= (FPGA_CLK*LR_SAM)/(2*Fs*DIN_W); // variable for debugging
	end
	
//-------------------------------------------------
//-------------------------------------------------
// STATE MACHINE
//-------------------------------------------------
//-------------------------------------------------
//----------------------------------------------
// Bit Shifter Next state
//		Data is shifted out LSB to MSB
//----------------------------------------------
always @ (posedge clk) begin
	if (rst) PS <= IDLE;
	else PS <= NS;
end

//----------------------------------------------
// Bit Shifter State Change
//		Data is shifted out LSB to MSB
//----------------------------------------------
always @ (posedge clk) begin
	case (PS) 
		IDLE:   begin
			NS <= CHAN_0;
		end
		CHAN_0:  begin
			NS <= (shift_count_0 == 15) ? CHAN_1 : CHAN_0;
		end
		CHAN_1: begin
			NS <= (shift_count_1 == 15) ? CHAN_0 : CHAN_1;
		end
	endcase
end


//----------------------------------------------
// Bit Shifter State Machine
//----------------------------------------------
always @ (negedge s_clk) begin
	case (PS) 
		IDLE:   begin
			DONE <= 0;
			shift_count_0 <= 0;
			shift_count_1 <= 0;
			data_out <= 0;
		end
		CHAN_0:  begin
				// shift out the data
			if (shift_count_0 < DIN_W-1) begin
				shift_count_0 <= shift_count_0 + 1;
				data_out <= data_in[shift_count_0];
			end
			else begin
				shift_count_0 <= 0;
				data_out <= data_in[shift_count_0];
			end
			
			if (shift_count_0 == 15) DONE <= 1;
			else DONE <= 0;
		end
		
		CHAN_1: begin
			// shift out the data
			if (shift_count_1 < DIN_W-1) begin
				shift_count_1 <= shift_count_1 + 1;
				data_out <= data_in[shift_count_1];
			end
			else begin
				shift_count_1 <= 0;
				data_out <= data_in[shift_count_1];
			end
			
			if (shift_count_1 == 15) DONE <= 1;
			else DONE <= 0;
		end
	endcase
end


//---------------------------------------------------
//---------------------------------------------------
// CLOCK SECTION	
//---------------------------------------------------
//---------------------------------------------------

//----------------------------------------------
// Master Clock:
//		is always 50MHz
//		m_clk is only used to wake CS4344
//		Chip and put into WAIT state (I think)
//----------------------------------------------
	always @ (posedge clk) begin
		if (rst) m_clk <= 0;
		else m_clk <= ~m_clk;
	end	
	
	
//----------------------------------------------	
// Left/Right Channel Clock:
//		is dependent on Sampling Frequency 
//		(Fs) and samples per channel
//----------------------------------------------
	always @ (s_clk) begin
		if (rst) begin
			LR_count <= 0;
			LR_clk <= 0;
		end
		else if (s_clk == 0) begin      
		//	uses s_clk to count data width and samples 
		//		for each channel						
			if (LR_count < (DIN_W-1) * LR_SAM) begin
				LR_count <= LR_count + 1;
			end
			else begin
				LR_count <= 0;
				LR_clk <= ~LR_clk;
			end
		end
		else
			begin
			LR_count <= LR_count;
			LR_clk <= LR_clk;
			end
	end
	

//------------------------------------------------
// Serial Clock:
//		is dependent on FPGA clock, data width,
//	   sampling rate, and samples per channel
//------------------------------------------------
	always @ (posedge clk) begin
		if (rst) begin
			s_count <= 0;
			s_clk <= 0;
		end
		else begin // made out of master clocks
			if (s_count < s_max) begin
				s_count <= s_count + 1;
			end
			else begin
				s_count <= 0;
				s_clk <= ~s_clk;
			end
		end
	end
endmodule
