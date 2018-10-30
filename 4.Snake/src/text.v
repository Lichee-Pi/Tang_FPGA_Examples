module text (
	input clk, rst,
	output reg[9:0]  rom_adr,
	input wire[31:0] rom_data,
	input wire[9:0] posx, posy,
	input wire[10:0] x, y,
	input wire[3:0] char,
	output reg do
);

`include "para_define.v"

reg[9:0] rom_adress;
reg[4:0] x_cnt;

// decode char to rom address
always @(char)
	case(char)
		4'd0: rom_adress <= `CHAR_0;
		4'd1: rom_adress <= `CHAR_1;
		4'd2: rom_adress <= `CHAR_2;
		4'd3: rom_adress <= `CHAR_3;
		4'd4: rom_adress <= `CHAR_4;
		4'd5: rom_adress <= `CHAR_5;
		4'd6: rom_adress <= `CHAR_6;
		4'd7: rom_adress <= `CHAR_7;
		4'd8: rom_adress <= `CHAR_8;
		4'd9: rom_adress <= `CHAR_9;
		default: rom_adress <= `CHAR_mh;
	endcase
	
always @(posedge clk or negedge rst)
	if(!rst) x_cnt <= `CHAR_WIDETH-1;
	else if(x >= posx && x < posx + `CHAR_WIDETH) begin
		x_cnt <= x_cnt - 1'b1;
		do <= rom_data[x_cnt];
	end
	else begin
		x_cnt <= `CHAR_WIDETH-1;
		do <= 1'b0;
	end

always @(rom_adress)
	if(y >= posy && y < posy + `CHAR_HEIGHT)
		rom_adr <= rom_adress + (y-posy);
		
endmodule

module block #(parameter N=4)
(
	input clk, rst,
	output wire[9:0] rom_address,
	input wire[31:0] rom_data,
	input wire[9:0] posx, posy,
	input wire[10:0] x, y,
	input wire[11:0] number,
	output wire do
);
`include "para_define.v"

wire[3:0] i, ii;
wire[9:0] poxx, xx;
reg[3:0] char[0:4];

assign xx = (x-posx);
assign i = xx[9:5]<N ?  xx[9:5] : 0;
assign poxx = posx + `CHAR_WIDETH*i;
text text(clk, rst, rom_address, rom_data, poxx, posy, x, y, char[i], do);

always @(number) begin
	char[0] <= number / 1000;
	char[1] <= number / 100 % 10;
	char[2] <= number / 10  % 10;
	char[3] <= number % 10;
end

endmodule
