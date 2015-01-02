`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    21:01:01 10/06/2014 
// Design Name: 
// Module Name:    top_module 
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
module top_module #(parameter WIDTH = 32, 
								parameter REGBITS = 4, 
								parameter BLOCK_ADDR_BITS = 10, 
								parameter RAM_ADDR_BITS = 32, 
								parameter CLOCKFREQ = 100) //MHz
			(input CLK_I, reset, BTNM_I,
			//SWITCHES and LEDS
			 input	[7:0] SW_I, 
			 output	[7:0] LEDS,
			// SEV SEG
			output [3:0] AN_O,
			output [7:0] SEG_O,
			//TOUCH and VGA
			input  TP_PENIRQ_I, TP_DOUT_I, TP_BUSY_I,
			output TP_CS_O, TP_DIN_O, TP_DCLK_O,
			output [7:0] R, G, B,
			output TFT_CLK_O, TFT_DE_O, TFT_BKLT_O, TFT_VDDEN_O, TFT_DISP_O,
			//MIC 
			 input	mic_sdata,
			 output mic_sclk, mic_nCS,
			//SPKR
			output spkr_data_out, m_clk, LR_clk, s_clk,
			//CELLRAM
			 output RAM_CEN, MEM_OEN, MEM_WEN, RamCRE, MemAdv, MEMClk,
			 output [1:0] RAM_BEN, 
			 output [25:0] cr_mem_addr,
			 inout [15:0] CR_MEM_DATA
			 );

	//These signal are for Cell Ram to make it behave Asyncronously
	assign MEMClk = 0;
	assign RamCRE = 0;
	assign MemAdv = 0;
	assign RAM_BEN = {MEM_UBN, MEM_LBN};
	
	

	
	assign vga_clk = CLK_I_BUFG;

	wire [1:0] memtoreg;		//memtoreg is used to control which data goes to the input of the reg file
								//--options are alu, i/o, prog_count, or whether the code was met. 
	wire [1:0] mem_select_ctrl;	//mem_select_ctrl is used to control where the mem_address comes from.
								//--options are prog_count, data_out1 (jal), instr[23:0] (iostor and iowr), and
								//--vga_mem_addr (set by AMAN's vga module).
	wire [3:0] alu_op;		// this contains the alu_op code set by the alu_controller
	wire [3:0] cond_input;	// this contains the conditional code from the instruction.
	
	wire [REGBITS-1:0] dst_addr;	// this is the destination address in the reg_file
	wire [WIDTH-1:0] prog_count;	//this contains the current program count
	wire [WIDTH-1:0] data_out1, data_out2;	//this contains the data in the src_addr and dst_addr of the reg file
	wire [WIDTH-1:0] instruction;	//the current instruction being implemented
	wire [WIDTH-1:0] pc_in;	//this is the final input to the pc after the adder mux, branch mux, and jump mux
	wire [WIDTH-1:0] pc_incremented, pc_branched;	//these are the outputs to the pc adder and branch adder
	wire [WIDTH-1:0] pc1, pc2;	// these are the outputs of the muxes that select b/t the pc adder, brancher, and jump
	wire [WIDTH-1:0] branch_extended;	//sign extended version of the first 15 bits of the instruction
	wire [WIDTH-1:0] extended;	//sign extended version of the first 24 bits of the instruction
	wire [WIDTH-1:0] alu_in1, alu_in2;	// the inputs to the alu
	wire [WIDTH-1:0] shift_src;	//input to the shifter
	wire [WIDTH-1:0] shift_out;	//output from the shifter 
	wire [WIDTH-1:0] reg_data_in;	//the data currently being fed into the reg_file
	wire [WIDTH-1:0] en_reg_data_in;	//the data going to the reg_file is stored in an enabled reg. This contains the
										//--data being sent into that enabled reg. becomes reg_data_in when enabled. 
	wire [9:0] flags_out;	//this contains the output of the enabled reg which contains the flag data. 
	wire [WIDTH-1:0] alu_out;	//this contains the output of the alu
	wire [WIDTH-1:0] alu_shift_output; // this contains the output of the mux that chooses between the alu and shifter
	wire [23:0] mem_addr;	// current memory address
	//////////////////////////////
	//I/O SIGNALS
	/////////////////////////////
	wire [1:0] menu; // holds value of current menu 
	wire [2:0] filter; // which filter we should be executing
	wire [15:0] cr_app_data_in, cr_app_data_out;	//data to and from cellular ram
	wire [WIDTH-1:0] br_memdata_in, br_memdata;		//data to and from block ram
	wire [WIDTH-1:0] io_data;	//this contains the output data from the i/o controller
	wire [11:0] mic_data;	//input data from mic.
	wire [15:0] spkr_data; //Speaker data
	reg initialized, state_time; // signals for counters
	reg [16:0] count; // for first counter
	reg [5:0] count_bt; // for second counter
	wire [23:0] vga_mem_addr; //current vga address. still needs to be implemented

//CLOCK BUFFER MODULE FROM XILINX
IBUFG clkin1_buf	
 (
.I (CLK_I),
.O (CLK_I_BUFG)
);
	 
//==================================================================================================
//INPUT/OUTPUT
//	includes leds, switches, the seven seg display, mic, speaker, video output and touch input as well as a 
// module to decode all of our I/O.
//==================================================================================================

	/* This module communicates with the Microphone. The Mic sends in data serially when given a start signal and this module
		concatenates it into 12 bit data which it then sends to the I/O controller. It also has a done signal to tell when the 
		new data is ready. */
	PmodMICRefComp	
			mic	(CLK_I_BUFG, reset, mic_sdata, mic_sclk, mic_nCS, mic_data, mic_start, mic_done);
	
	/* This module communicates with our speaker chip using I2S protocol. It takes in 16 bit data and outputs it serially 
		to the audio jack along with a master clock, left/right clock, and serial clock. It also has a done signal to 
		signify when the current data is done being processed */
	SPI_to_I2S_bridge
			da_spkr(CLK_I_BUFG, reset, spkr_data, spkr_data_out, m_clk, LR_clk, s_clk, spkr_done);
	
	/* This module holds the value of spkr_done. The spkr module only makes this high for one clock cycle, but we may not 
		be checking for the signal at the correct time. Therefore, this module holds the signal high for program until the 
		program aknowledges that it has been seen (buffer_updated) */
	buffer_mod
		bfmd(CLK_I_BUFG, spkr_done, buffer_updated, spkr_update);
	
	/* This module interfaces with our Touch Screen sending it the correct signals for the display and decoding the Touch 
		response into X, Y, and Z coordinates that are used by the menu controller (inside this module) to decide which 
		menu to go to */
	vgaandtouch
		VGATCH (vga_mem_addr, R, G, B,
					TFT_CLK_O, TFT_DE_O, TFT_BKLT_O, TFT_VDDEN_O, TFT_DISP_O, 
					TP_CS_O, TP_DIN_O, TP_DOUT_I, TP_DCLK_O, TP_BUSY_I, TP_PENIRQ_I, 
					SW_I, AN_O, SEG_O, /*vga_mem_addr,*/ CLK_I_BUFG, reset, BTNM_I, 
					br_memdata, decode_state, menu, filter);

	/* This is our I/O module which interfaces with each piece of I/O except the touchscreen based on the memory address */
	
	iocontroller   #(WIDTH)
			iocont (CLK_I_BUFG, vga_clk, reset, 
					//Address
					mem_addr[23:16],
					//SWITCHES and LEDS
					SW_I, LEDS,
					//MIC
					mic_done, mic_start, mic_data,
					//SPKR
					spkr_update, spkr_data, buffer_updated,
					// VGA and TOUCH
					menu, filter,
					//Block_mem
					br_memdata,
					br_memdata_in,
					br_memwrite,
					br_memread,
					//Cell_mem
					cr_app_data_out,
					cr_app_data_in,
					cr_memwrite,
					cr_memread,
					//Processor
					data_out2, memwrite, mem_en, decode_state, io_rd,
					//IODATA
					io_data);
					
			

//==================================================================================================
//MEMORY
//	includes Block Ram and Cellular Ram and muxes to decide which signals go to and from memory
// also includes instruction register which holds currently executing instruction (is and enabled reg)
// 	instruction reg is neg enabled because this cuts out a state from many of the loops b/c else
//    one enable signal puts gets the new instruction from memory and then a new state and enable signal 
//    is required to update the instruction reg. 
//==================================================================================================


	/* This mux selects where the mem address comes from. It can either come from the program count (for gettting the next 
		instruction), the registers (for loading from or storing to an address in a register), an immediate value (for 
		loading or storing from an address in the instruction), or the vga module (when we are setting the vga values) */
	mux4		#(24)
				mem_select			(prog_count[23:0], data_out1[23:0], instruction[23:0], vga_mem_addr, mem_select_ctrl, mem_addr);
	
	/* This assigns the block ram enable signal to be high when we are either trying to read from block ram 
		or the processor is in the decode state. During the decode state we know that the processor is trying to get 
		data from the memory because it is still decoding the previous instruction. Therefore we can fill the next vga 
		buffer during this time. */
	assign br_mem_en = br_memread || decode_state;
	
	exmem 		#(WIDTH, BLOCK_ADDR_BITS)												//was data_out1
				block_ram 			(CLK_I_BUFG, br_mem_en, br_memwrite, mem_addr[9:0], br_memdata_in, br_memdata);
	
	/* This holds the current instruction. */
	enabled_reg #(WIDTH) 
			instruction_reg			(CLK_I_BUFG, reset, inst_write, br_memdata, instruction);
	
	/* This cell ram module uses one signal to tell when an operation needs to be performed and another to decide whether 
		to read or write */ 
	assign cr_go = (cr_memwrite || cr_memread);		
	
	/* This is our cell ram controller module which handles sending signals to and from the off chip PSRAM. This was a module 
		that was found online but several changes were made. First of all an additional wait state was added before we checked 
		for a value or finished storing. Additionally, two additional wait states were added after we checked for a value. */
	AsyncPSRAM
		cr (CLK_I_BUFG, reset, cr_app_data_in, {3'd0, mem_addr[22:0]}, 2'b00, ~cr_memwrite, 
			cr_go, cr_ready, cr_app_data_out, cr_mem_addr, RAM_CEN, MEM_OEN, MEM_WEN, 
			MEM_LBN, MEM_UBN, MEM_ADV, CR_MEM_DATA);	



//==================================================================================================
//CONTROLLER
//	sets all control signals
//==================================================================================================
		
		/* This counter is used to ensure that the cellular ram has enough time to initialize
			it counts to 20,000 whenever reset is pressed and the processor won't execute instructions until 
			initialized has been set high.
		*/
		always@(posedge CLK_I_BUFG)
		if (reset)
			begin
			count <= 0;
			initialized <= 0;
			end
		else if (count < 20000) //000)
			begin
			count <= count + 1;
			initialized <= 0;
			end
		else
			begin
			count <= 20000; //000;
			initialized <= 1;
			end
	
		/* This counter is used to ensure that there is enough time in between reads and writes to cellram. Cellram needs 
			some time in between each read or write before the next once can be processed so this counter prevents the 
			processor from executing additional instructions accesssing the cellram until that count has been reached. 
		*/

	always@(posedge CLK_I_BUFG)
		if (reset || cnt_rst)
			begin
			count_bt <= 0;
			state_time <= 0;
			end
		else if (count < 40)
			begin
			count_bt <= count_bt + 1;
			state_time <= 0;
			end
		else
			begin
			count_bt <= 40;
			state_time <= 1;
			end

		/* This is the main controller which sends signals to all of the muxes telling them which input to select based
			on the instruction. It will also send enable signals to the enabled registers and read and write signals 
			to the I/O controller if a load or store is being performed. 
		*/
	
	controller 	#(WIDTH)
				MAIN_CTRLR	 	(CLK_I_BUFG, reset, code_met, instruction[31:28], instruction[23:20], alusrcb, mem_en, 
											jump, branch, jump_reg, cond_ctrl,
											memtoreg, mem_select_ctrl, data_update, alu_shift_slct, memwrite, 
						 					regwrite, reg_dst, inst_write, pc_enable, flag_update, decode_state, io_rd,
											mem_addr[23], cr_ready, initialized, state_time, cnt_rst
											);

//==================================================================================================
//CONDITION DECODE
//	muxes to decide where in instruction condition is located. 
// Enabled reg to only update flags (and condition) on non condition related instructions
// 	e.g. doesn't update for branch and jump instructions but will for all Rtype and immediates
// condition decode block to decide whether condition was met
//==================================================================================================

	//most instructions have a conditional code in the [23:30] block but Jcond uses [15:12] for the condition
	mux			#(4)
				cond_input_ctrl	(instruction[23:20], instruction[15:12], cond_ctrl, cond_input);
	
	/*this module takes inputs from the ALU and checks it with the instruction to report whether or not the conditional
		code was met */
	cond_decode	#(WIDTH)
				cd (flags_out[5], flags_out[4], flags_out[3], flags_out[2], flags_out[1], flags_out[9:6], code_met);	
	
	/* this enabled reg holds the output of the ALU flags because some operations are dependent on the conditional output 
		from the operation before. This ensures that the flags are not updated when they shouldn't be. */
	enabled_reg #(10)
				flags (CLK_I_BUFG, reset, flag_update, {cond_input, C, L, F, N, Z, zero}, flags_out);
	
//==================================================================================================
//PROGRAM COUNTER
//	includes PC, which is an enabled reg holding the current program count.
// includes a normal adder which adds 1 for normal opperation
// includes a separate adder for branch instructions (other input comes from instruction)
// also includes muxes to decide whether pc input should be from the normal adder, branch adder, 
// jump from an immediate value, or jump from a register value.
//==================================================================================================
	/* This register contains the program count. It contains an enable signal so that it is only updated once every 
		instruction cycle */
	enabled_reg #(WIDTH)
				 PC 				(CLK_I_BUFG, reset, pc_enable, pc_in, prog_count);
				
	/* Adds one to the current program count for normal operation */
	adder		#(WIDTH)
				normal_increment	(prog_count, 32'd1, pc_incremented);

	/* sign extends the last 16 bits of the instruction so that it can be correctly added for branch instructions */
	sign_extend16	#(16)
				pc_sign				(instruction[15:0], branch_extended);
				
	/* adds the immediate value from the instruction if we are trying to do a branch */
	adder_signed #(WIDTH)
				branch_instr		(pc_incremented, branch_extended, pc_branched);
				
	/* These three muxes select between normal operation (increment one), branching (increment by immediate), 
		jumping (go to immediate address), and jump register (go to a value stored in a register).  */
	mux			#(WIDTH)
				branch_pick			(pc_incremented, pc_branched, branch, pc1);

	mux			#(WIDTH)
				jump_pick			({20'd0, instruction[11:0]}, pc1, jump, pc2);

	mux			#(WIDTH)
				jumpreg_pick		(data_out1, pc2, jump_reg, pc_in);
				
//==================================================================================================
//REGISTER FILE
//	includes mux to decide where the input to the regs comes from and mux to decide where the source
// address comes from. Includes reg file which has 16 32-bit registers.
//==================================================================================================
	
	/* This mux picks which data is passed to the registers. It can either come from the alu or shift 
		(in the case of a R Type or I Type instruction) or I/O data (in the case of a load or store), 
		or the program count (if we are jumping and linking), or code met (if we are storing the result 
		of the condition check). */
	mux4	#(WIDTH) 
				data_pick			(alu_shift_output, io_data, prog_count, {31'd0, code_met}, memtoreg, reg_data_in);
	
	/* This picks whether the source address comes from the instruction or is set to 15 (in the case of a JAL)*/
	mux			#(REGBITS)
				source_address 	(instruction[27:24], 4'd15, reg_dst, dst_addr);
		
	/* This module contains our registers */
	reg_file 	#(WIDTH, REGBITS)
				main_reg 			(CLK_I_BUFG, reset, regwrite, instruction[19:16], dst_addr, reg_data_in, data_out1, data_out2);
//==================================================================================================
//ALU AND SHIFT
// Does all arithmetic operations on values
// includes muxes to decide whether inputs are registers or immediate values and includes the actual 
// shifter and alu. Also includes the instruction_to_alu decoder which takes the appropriate bits of
// of the instruction and transforms it into an ALU op code. 
// Finally, includes a mux to decide whether the output should come from the shifter or alu 
// and  a register to hold the resulting calculation (may not be necessary).
//==================================================================================================
	
	/* This module picks whether the second alu source is an immediate or from a register */
	mux 		#(WIDTH)
 				alu_sourceb			(data_out1, extended, alusrcb, alu_in2);

	/* Sign extends the last 24 bits of the instruction for I type instructions */
	sign_extend	#(24)
				sign				(instruction[23:0], extended);
	
	/* This module decodes instruction to determine what operation the alu should perform */
	instr_to_alu #(WIDTH)
				alu_controller		(instruction[31:28], instruction[23:20], alu_op);
	
	/* The main ALU that performs all operations */
	alu 		#(WIDTH)
				main_alu 			(alu_in2, data_out2, alu_op, C, L, F, Z, N, zero, alu_out);
	
	/* This mux selects between an immediate value or a register value to send to the shifter */
	mux 		#(WIDTH)
				shift_source		(extended, data_out1, instruction[22], shift_src);
				 
	/* This module performs all shifts */
	shift 	 	#(WIDTH,16)
				main_shift 			(data_out2, shift_src, instruction[21], shift_out);
	 
	/* This module selects whether we wanted the output of the ALU or shifter */
	mux 		#(WIDTH)
				out_decide 			(shift_out, alu_out, alu_shift_slct, alu_shift_output);
				 


endmodule
