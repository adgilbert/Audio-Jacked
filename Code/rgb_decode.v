`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    21:00:06 12/04/2014 
// Design Name: 
// Module Name:    rgb_decode 
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
module rgb_decode #(parameter WIDTH = 32)
		(input clk, reset, 
		 input decode_state,
		 input [3:0] hcount,
		 input [WIDTH-1:0] br_memdata_out,
		 input vga_addr_bit,
		 output reg [7:0] R, G, B	
       );

reg [WIDTH-1:0] br_rgb_data_0; //declare buffer registers
reg [WIDTH-1:0] br_rgb_data_1;
reg get_data;
always@(posedge clk)
    if (reset)
        begin
        br_rgb_data_0 <= 0;
		  br_rgb_data_1 <= 0;
        end
    else if (decode_state)
		  get_data <= 1;
	 else if (get_data)
		begin
		get_data <= 0;
        if (buff_num)
            br_rgb_data_0 <= br_memdata_out; //SET UP TO GET ADDRESS FROM AMAN AND SEND TO BLOCK RAM
        else
            br_rgb_data_1 <= br_memdata_out;
		end
		 
reg buff_num;
always@(vga_addr_bit)
	if (reset)
		buff_num <= 0;
	else 
		buff_num <= ~buff_num; ///assign buff_dumb

wire [1:0] data_color_0;
wire [1:0] data_color_1;
assign data_color_0[1] = br_rgb_data_0[31-(hcount*2)]; //could be using reverse addr
assign data_color_0[0] = br_rgb_data_0[30-(hcount*2)]; //if so use: data_color[1] = (hcount*2)and data_color[0] =(hcount*2)+1

assign data_color_1[1] = br_rgb_data_1[31-(hcount*2)]; //could be using reverse addr
assign data_color_1[0] = br_rgb_data_1[30-(hcount*2)]; //if so use: data_color[1] = (hcount*2)and data_color[0] =(hcount*2)+1

		 
always@(posedge clk)
	if(reset)
	begin
		R <= 8'd0;
		G <= 8'd0;
		B <= 8'd0;
	end
	else if(buff_num)
		case(data_color_0)
		2'b00:begin
				R <= {3'b110,5'd0}; //light blue
				G <= {3'b110,5'd0};
				B <= {2'b11, 6'd0};
				end
		2'b01:begin
				R <= {3'b000,5'd0}; //gray
				G <= {3'b010,5'd0};
				B <= {2'b11, 6'd0};
				end
		2'b10:begin
				R <= {3'b111,5'd0}; //red
				G <= {3'b001,5'd0};
				B <= {2'b00, 6'd0};
				end
		2'b11:begin
				R <= {3'b001,5'd0}; //dark blue
				G <= {3'b100,5'd0};
				B <= {2'b11, 6'd0};
				end
	   endcase
  else
  case(data_color_1)
		2'b00:begin
				R <= {3'b110,5'd0}; //light blue
				G <= {3'b110,5'd0}; 
				B <= {2'b11, 6'd0}; 
				end                 
		2'b01:begin               
				R <= {3'b000,5'd0}; //gray
				G <= {3'b010,5'd0}; 
				B <= {2'b11, 6'd0}; 
				end                 
		2'b10:begin               
				R <= {3'b111,5'd0}; //red
				G <= {3'b001,5'd0}; 
				B <= {2'b00, 6'd0}; 
				end                 
		2'b11:begin               
				R <= {3'b001,5'd0}; //dark blue
				G <= {3'b100,5'd0};
				B <= {2'b11, 6'd0};
				end
	   endcase
		

endmodule
