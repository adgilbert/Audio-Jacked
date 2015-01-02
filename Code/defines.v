	//States

	`define   	FETCH	  	   5'd0
	`define 	DECODE		   5'd1 
	`define		RTYPEEX		   5'd2  
	`define		RTYPEWR		   5'd3 
	`define		IMMEX		   5'd4 
	`define 	IMMWR		   5'd5 
	`define		SHIFTEX		   5'd6 
	`define		SHIFTWR		   5'd7 
	`define 	BTYPEEX		   5'd8 
	`define  	STYPEDECODE	   5'd9 
	`define		LBRD		   5'd10 
	`define		LBWR		   5'd11 
	`define		SBWR		   5'd12 
	`define 	JIMMEX		   5'd13
	`define 	JIMMEX2		   5'd14 
	`define		JALEX1		   5'd15  
	`define		JALEX2		   5'd16 
	`define		CHECKCOND	   5'd17 
	`define 	JEX			   5'd18 
	`define		SWRITE		   5'd19 
	`define		BTYPEWR		   5'd20
	`define		RDSTALL		   5'd21
	`define		WRSTALL		   5'd22
	`define		LIORD		   5'd23
	`define		LIOWR		   5'd24
	`define		SI			   5'd25
	`define		SBSTL		   5'd26
	`define		INSTUP		   5'd27
	 
	//OP CODES - Bits 15:12
	`define 	REGISTER	  	4'h0 
	`define		ANDI		  	4'h1 
	`define 	ORI			 	4'h2 
	`define 	XORI		  	4'h3
	`define 	SPECIAL		  	4'h4
	`define		ADDI		  	4'h5
	`define 	LOADI		 	4'h6
	`define 	STORI		  	4'h7
//	`define 	ADDUI		 	4'h6
//	`define 	ADDCI		  	4'h7
	`define 	SHIFT		  	4'h8
	`define		SUBI		  	4'h9 
	`define 	SUBCI		  	4'hA 
	`define		CMPI		 	4'hB 
	`define		BCOND		  	4'hC 
	`define 	MOVI		  	4'hD 
	`define 	MULI		  	4'hE
	`define		LUI			 	4'hF
	
	//Register Instructions - Bits 7:4
	`define		WAIT	 	4'h0 
	`define		AND		    4'h1 
	`define 	OR		  	4'h2 
	`define		XOR		  	4'h3
	`define		ADD		  	4'h5
	`define		ADDU	 	4'h6
	`define		ADDC	 	4'h7
	`define		SUB		  	4'h9
	`define		SUBC	 	4'hA
	`define 	CMP		  	4'hB
	`define		MOV		    4'hD
	`define 	MUL		 	4'hE
		
	//Special Instructions - Bits 7:4
	`define 	LOAD		  	4'h0
	`define		STOR		 	4'h4 
	`define		JAL			  	4'h8
	`define 	Jcond		 	4'hC
	`define		Scond		 	4'hD
	`define		Jimm			4'h9
	`define 	JR			  	4'h1
	
	//Shift Instructions - Bits 7:4
	`define 	LSHI		  	4'h0
	`define 	LSH		  		4'h1 
	
	//Cond Instructions	-	Bits 11:8 or 3:0
	`define		EQ			  	4'h0 		// equal to
	`define 	NE			 	4'h1 		// not equal
	`define 	CS			 	4'h2		// carry set 
	`define		CC			 	4'h3		// carry clear
	`define 	HI			 	4'h4		// higher than
	`define 	LS			  	4'h5		// lower than or same as
	`define 	GRT		  		4'h6     	// greater than
	`define		LE			 	4'h7 		// less than or equal
	`define 	FS			 	4'h8 		// flag set
	`define 	FC			 	4'h9 		// flag clear
	`define 	LO			 	4'hA   		// lower than
	`define		HS			  	4'hB 		// higher than or same as
	`define 	LT			  	4'hC		// less than
	`define 	GE			 	4'hD		// greater than or equal
	`define		UC			 	4'hE		// unconditional
	`define		AT				4'hF		// always true
	
/////////////////////////////////////
//IO DEFINES
// 8'b _		_		_		_		_		_		_		_
//		cell	spkr	mic	seg	men?	leds	swtch	dn 
////////////////////////////////////
//I/O
	`define cellram			8'b1xxxxxxx
	`define block				8'b00000000
//INPUTS
	`define spkr_dn			8'b01000001	//speaker done signal
	`define mic				8'b00100000
	`define mic_dn			8'b00100001
	`define menu_num		8'b00001000
	`define switchs			8'b00000010
//OUTPUTS
	`define sp_bufr			8'b01001000 //speaker buffer
	`define speaker			8'b01000000	//speaker
	`define spkr_rst		8'b01001001
	`define leds			8'b00000100
	`define seg				8'b00010000


////////////////////////////
//CELLRAM 
/////////////////////////////
	// PSRAM configuration word
`define psram_config_word 23'b000_10_00_0_1_011_1_0_0_0_0_01_1_111

// FSM state codes (not forcing)
`define init_state 0

`define conf_1_state 1
`define conf_2_state 2
`define conf_3_state 3
`define conf_4_state 4
`define conf_5_state 5
`define conf_6_state 6
`define conf_7_state 7

`define idle_state 8

`define wr_0_state 9
`define wr_1_state 10
`define wr_2_state 11
`define wr_3_state 12
`define wr_4_state 13
`define wr_5_state 14
`define wr_6_state 15
`define wr_7_state 16
`define wr_8_state 17
`define wr_9_state 18
`define wr_10_state 19

`define rd_0_state 20
`define rd_1_state 21
`define rd_2_state 22
`define rd_3_state 23
`define rd_4_state 24
`define rd_5_state 25
`define rd_6_state 26
`define rd_7_state 27
`define rd_8_state 28
`define rd_9_state 29
`define rd_10_state 30


////////////////////////////
// MENU DEFINES
////////////////////////////

`define menu1 	   3'd0
`define menu1_wait 3'd1
`define menu2 	   3'd2
`define menu2_wait 3'd3
`define menu3 	   3'd4
`define menu3_wait 3'd5

