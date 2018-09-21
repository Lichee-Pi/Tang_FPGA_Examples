module led(
		input wire CLK_IN,
		input wire RST_N,
		output wire [2:0]RGB_LED
		);

reg [15:0] cnt;
wire[7:0] dutyR, dutyG, dutyB;
reg bln_clk;
	
PWM PWMR(.clk(CLK_IN), .rst(RST_N), .duty(dutyR), .pwm(RGB_LED[0]));
PWM PWMG(.clk(CLK_IN), .rst(RST_N), .duty(dutyG), .pwm(RGB_LED[1]));
PWM PWMB(.clk(CLK_IN), .rst(RST_N), .duty(dutyB), .pwm(RGB_LED[2]));

always @(posedge CLK_IN or negedge RST_N) begin
	if(!RST_N) begin
		cnt <= 1'b0;
		bln_clk <= 1'b0;
	end
	else if(cnt == 16'hFFFF) begin
		cnt <= 0;
		bln_clk <= ~bln_clk;
	end
	else begin
		cnt	<= cnt + 1'b1;
	end
end

`define _BLN
`ifdef _BLN

BLN#(000) BLNR(bln_clk, RST_N, dutyR);
BLN#(063) BLNG(bln_clk, RST_N, dutyG);
BLN#(200) BLNB(bln_clk, RST_N, dutyB);

`else

reg[23:0] rgb;
assign dutyR=rgb[7:0];
assign dutyG=rgb[15:8];
assign dutyB=rgb[23:16];

always @(posedge bln_clk)
	if(rgb == 24'hFFFFFF)
		rgb <= 0;
	else rgb <= rgb+1;

`endif

endmodule

module BLN #( parameter DUTY=0) // breathing led notify
(
	input wire clk,	rst,
	output reg[7:0] duty
);
reg r;
always @(posedge clk or negedge rst)
	if(!rst)
		r <= 1'b1;
	else if(duty == 8'hFF || duty == 8'h0)
		r <= ~r;

always @(negedge clk or negedge rst)
	if(!rst)
		duty <= DUTY;
	else
		duty = r ? duty + 1'b1 : duty - 1'b1;

endmodule

module PWM(
	input wire clk, rst,
	input wire[7:0] duty,
	output wire pwm
);
reg[7:0] cnt;
always @(posedge clk or negedge rst)
	if(!rst)
		cnt <= 1'b0;
	else
		cnt	<= cnt + 1'b1;

assign pwm = cnt>=duty;

endmodule
