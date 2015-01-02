`timescale 1ns / 1ps
`include "./defines.v"
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    18:06:11 10/09/2014 
// Design Name: 
// Module Name:    test_ctrlr 
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
module controller 	#(parameter WIDTH = 16)
		(input clk, reset, code_met,
		 input [3:0] op, ext,
		 output reg alusrcb, mem_en, jump, branch, jump_reg, cond_ctrl,
		 output reg [1:0] memtoreg, mem_select_ctrl,
		 output reg data_update, alu_shift_slct, 
		 output reg memwrite, regwrite, 
		 output reg reg_dst, 
		 output reg	inst_write, pc_enable, flag_update, decode_state, io_rd,
		 input cellram, cr_ready, initialized, state_time,
		 output reg cnt_rst
		 //op_finished,
		 //input app_ctrlr_good, app_data_ok
		 );			
		 
	



   reg [4:0] state, nextstate;
   reg       pcwrite, pcwritecond;

   // state register
   always @(posedge clk)
			state <= nextstate;

   // next state logic
   always @(*)
		if (reset)
			begin
			nextstate <= `INSTUP;
			cnt_rst <= 0;
			end
		else
      begin
		cnt_rst <= 0;
         case(state) 
            `INSTUP:	  	if (initialized) nextstate <= `FETCH;
								else 					  nextstate <= `INSTUP;
			`FETCH:		nextstate <= `DECODE;
            `DECODE:  case(op)
						`REGISTER:	nextstate <= `RTYPEEX; //
						`ANDI:		nextstate <= `IMMEX;//
						`ORI:		nextstate <= `IMMEX;//
						`XORI:		nextstate <= `IMMEX;// 
						`SPECIAL:	nextstate <= `STYPEDECODE;//
						`ADDI:		nextstate <= `IMMEX;//
						`LOADI:		nextstate <= `LIORD;
						`STORI:		nextstate <= `SI;
						//`ADDUI:		nextstate <= `IMMEX;// not implemented currently
						//`ADDCI:		nextstate <= `IMMEX;// 
						`SHIFT:		nextstate <= `SHIFTEX;//
						`SUBI:		nextstate <= `IMMEX;//
						`SUBCI:		nextstate <= `IMMEX;//not implemented currently
						`CMPI:		nextstate <= `IMMEX;//
						`BCOND:		nextstate <= `BTYPEEX; //
						`MOVI:		nextstate <= `IMMEX;//
						`MULI:		nextstate <= `IMMEX;//
						`LUI:		nextstate <= `IMMEX;//
						default:	nextstate <= `INSTUP; //should never happen
					endcase
			`IMMEX:	nextstate <= `IMMWR; //
			`IMMWR:	nextstate <= `INSTUP; //
			`SHIFTEX:nextstate <= `SHIFTWR;
			`SHIFTWR:nextstate <= `INSTUP;
			`STYPEDECODE: case(ext)
							`LOAD:		nextstate <= `LBRD; //
							`STOR:		if ( cellram && state_time)	nextstate <= `WRSTALL; //
										else if (cellram) nextstate <= `STYPEDECODE;
										else 			nextstate <= `SBWR;
							`JAL:		nextstate <= `CHECKCOND; // 
							`Jcond:		nextstate <= `CHECKCOND; //
							`Scond:		nextstate <= `CHECKCOND;// 
							`Jimm:		nextstate <= `CHECKCOND;
						default:		nextstate <= `INSTUP;//
						endcase
			`BTYPEEX:	if(code_met)	nextstate <= `BTYPEWR; //
						else			nextstate <= `INSTUP; //
			`BTYPEWR:	nextstate <= `INSTUP;
			`LIORD:		nextstate <= `LIOWR;
			`LIOWR:		nextstate <= `INSTUP;
			`SI:		nextstate <= `INSTUP;
			`LBRD:		if(cellram && state_time) 	nextstate <= `RDSTALL;
						else if (cellram)			nextstate <= `LBRD;
						else			nextstate <= `LBWR;//
			`LBWR:		nextstate <= `INSTUP;//
			`SBWR:		nextstate <= `SBSTL;
			`SBSTL:		nextstate <= `INSTUP;//
			`CHECKCOND:	if(code_met)
							case (ext)
								`Jcond:		nextstate <= `JEX; //
								`JAL:		nextstate <= `JALEX1; //
								`Scond:		nextstate <= `SWRITE;
								`Jimm:		nextstate <= `JIMMEX;
								default:	nextstate <= `INSTUP;
							endcase							
						else 				nextstate <= `INSTUP; //
			`JEX:		nextstate <= `INSTUP; //
			`JALEX1:	nextstate <= `JALEX2;
			`JALEX2: 	nextstate <= `INSTUP;
			`RTYPEEX:	nextstate <= `RTYPEWR; //
			`RTYPEWR:	nextstate <= `INSTUP; //
			`SWRITE:	nextstate <= `INSTUP;
			`JIMMEX:	nextstate <= `JIMMEX2;
			`JIMMEX2:	nextstate <= `INSTUP;
			`WRSTALL:	if (cr_ready) 	begin nextstate <= `SBWR;  cnt_rst <= 1; end
						else				nextstate <= `WRSTALL;
			`RDSTALL:	if (cr_ready)	begin nextstate <= `LBWR; cnt_rst <= 1; end
						else				nextstate <= `RDSTALL;
			default: nextstate <= `INSTUP; // should never happen
         endcase
      end		 
	
always @(*)
      begin
			// set all outputs to zero, then conditionally assert just the appropriate ones
			mem_en <= 0;
			alusrcb <= 0;
			jump <=	1; branch <= 0; jump_reg <= 1;
			alu_shift_slct <= 1;
			memwrite <= 0;
			regwrite <= 0;
			reg_dst <= 0;
			inst_write <= 0;
			pc_enable <=0;
			memtoreg  <=0;
			data_update <= 0;
			mem_select_ctrl <= 2'b0;
			flag_update <= 0;
			cond_ctrl <= 0;
			decode_state <= 0;
			io_rd <= 0;
			case(state)
				`INSTUP:	begin	/*inst_write <= 1;*/
									mem_en <= 1;	 end
				`FETCH: 	begin	mem_en <= 1;
									inst_write <= 1; 		end
				`DECODE: 	begin	decode_state <= 1;
									mem_select_ctrl <= 2'b11;
									if(op != `SPECIAL)  begin
									$display("op = %d", op);
									flag_update <= 1;
									end
									else if ((ext != `Jcond) && (ext != `Scond) && (ext != `JAL)) begin
									$display("ext = %d", ext);
									flag_update <= 1; end	end		//alusrcbb <= 1; // ?? need 2 bits??
				`IMMEX: 	begin	alusrcb <= 1;
									flag_update <= 1;
									data_update <= 1;
									regwrite <= 1; end			// ?? need 2 bits??
				`IMMWR:		begin	/*regwrite <= 1; changed 12/06*/
									pc_enable <= 1;  		end
				`STYPEDECODE:begin	mem_select_ctrl <= 2'b01;	 	end  //to allow cellram to be set high
				`BTYPEEX:	begin	pc_enable <= 1;
							if (code_met)
							begin	branch <= 1;
									pc_enable <= 1;
									mem_en <= 1;			end end
				`BTYPEWR:	begin	mem_en <= 1;
									pc_enable <= 1;			end
				`LIORD:		begin	mem_en <= 1;
									mem_select_ctrl <= 2'b10;
									memtoreg <= 2'b01;
									data_update <= 1;
									regwrite <= 1; //changed 12/06
									//io_rd <= 1; 
									end
				`LIOWR:		begin	//regwrite <= 1; changed 12/06
									pc_enable <= 1;
									mem_en <= 1;			end	
				`SI:		begin	mem_en <= 1;
									memwrite <= 1;
									pc_enable <= 1;
									mem_select_ctrl <= 2'b10;
									io_rd <= 1; end
				`LBRD:		begin	mem_en <= 1;
									mem_select_ctrl <= 2'b01;
									data_update <= 1;
									regwrite <= 1; //changed 12/06
									//memtoreg <= 2'b01;
									//io_rd <= 1;	
									end
				`LBWR:		begin	//regwrite <= 1;
									memtoreg <= 2'b01;
									pc_enable <= 1;
									data_update <= 1;
									/*inst_write <= 1;*/
									mem_en <= 1;			end							
				`SBWR:		begin	mem_en <= 1;
									memwrite <= 1;
									mem_select_ctrl <= 2'b01;
									io_rd <= 1;	end
				`SBSTL:		begin	pc_enable <= 1;
									mem_en <= 1;			end
				`CHECKCOND:begin	cond_ctrl <= 1;
									if(~code_met)
										pc_enable <= 1;		end
				`JEX:		begin	jump_reg <= 0;
									pc_enable <= 1;			end			
				`JALEX1:	begin	memtoreg <= 2'b10;
									regwrite <= 1;
									reg_dst <= 1;			end
				`JALEX2:	begin	jump <= 0;
									pc_enable <= 1;			end
				`JIMMEX:	begin	jump <= 0;
									pc_enable <= 1;			end
				`JIMMEX2:	begin	mem_en <= 1;
									pc_enable <= 1;
									/*inst_write <= 1;*/			end
				`RTYPEEX:	begin	data_update <= 1;
									flag_update <= 1;
									regwrite <= 1; /* changed 12/06*/ end
				`RTYPEWR:	begin	/*regwrite <= 1;*/
									pc_enable <= 1; 		end
				`SHIFTEX:	begin	data_update <= 1;
									alu_shift_slct <= 0;
									regwrite <= 1; /*changed 12/06*/ end
				`SHIFTWR:	begin	/*regwrite <= 1;*/
									pc_enable <= 1;	 		end
				`SWRITE:	begin	memtoreg <= 2'b11;
									regwrite <= 1;
									pc_enable <= 1;			end
				`WRSTALL:	begin	mem_en <= 1;
									memwrite <= 1;
									mem_select_ctrl <= 2'b01;
									io_rd <= 1;			end
				`RDSTALL:	begin	memtoreg <= 2'b01; //added for cellram
									regwrite <= 1; //added for cellram
									mem_en <= 1;
									mem_select_ctrl <= 2'b01;
									data_update <= 1;
									io_rd <= 1;		end
				
         endcase
      end

endmodule

