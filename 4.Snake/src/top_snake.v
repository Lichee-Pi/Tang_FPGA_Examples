module top_snake(
	input wire clk_in, rst,
	input wire btn, btn1,
	// Touch I2C
	output wire LCD_TP_SCL,
	output wire LCD_TP_SDA,
	//output wire LCD_TP_INT,
	// LCD 800*480
	output reg  [7:0] R,G,B,
	output wire LCD_CLK,
	output wire LCD_HSYNC,
	output wire LCD_VSYNC,
	output wire LCD_DEN,
	output wire LCD_PWM		//backlight,set to high
);

wire clk, clklock;
ip_pll pll(
	.refclk		(clk_in),
	.reset		(~rst),
	.extlock	(clklock),
	.clk0_out	(clk)
);

// lcd video
wire[10:0] x, y;
wire[10:0] h_cnt, v_cnt;
lcd_sync lcd(
	.clk		(clk),
	.rst		(rst),
	.lcd_clk	(LCD_CLK),
	.lcd_pwm	(LCD_PWM),
	.lcd_hsync	(LCD_HSYNC), 
	.lcd_vsync	(LCD_VSYNC), 
	.lcd_de		(LCD_DEN),
	.pix_x		(x),
	.pix_y		(y),
	.h_cnt		(h_cnt),
	.v_cnt		(v_cnt)
);

// snake game logic
localparam Key_Left=4'h2, Key_Right=4'h4, Key_Down=4'h3, Key_Up=4'h7;

wire frame_v1 = v_cnt==1 && h_cnt==0;
wire frame_v2 = v_cnt==2 && h_cnt==0;
wire keydown = 1;
wire[3:0] code = btn ? (btn1? Key_Left : Key_Down) : Key_Up;
wire[1:0] vout;
wire[11:0] score, hi_score;
snake game(
	.clk		(clk), 
	.rst		(rst), 
	.code		(code),
	.keydown	(keydown),
	.x			(x),
	.y			(y),
	.frame_sync0(frame_v1),
	.frame_sync1(frame_v2),
	.pixel		(vout),
	.score		(score),
	.hi_score	(hi_score)
);

// font 0-9 rom
wire[9:0]	rom_adr;
wire[31:0]	rom_q;
chrom number(
	.wclk		(clk), // input clk
	.raddr		(rom_adr), // input [9:0] address from 0-703
	.do			(rom_q) // output [31:0] dout
);

// score text, use font 0-9
wire text_q;
wire[9:0] posx = x<660 ? 500 : 660;
wire[9:0] posy=5;
wire[11:0] num = x<660 ? hi_score : score;
block text_score(
	.clk		(clk),
	.rst		(rst),
	.rom_address(rom_adr),
	.rom_data	(rom_q),
	.posx		(posx), 
	.posy		(posy),
	.x			(x), 
	.y			(y), 
	.number		(num),
	.do			(text_q)
);

/*
// display ':'
wire[3:0] char=10; //':'
wire[9:0] pox=628;
text text(clk, rst, rom_adr, rom_q, poxx, posy, x, y, char, text_q);
*/

// display, pixel rgb color
localparam None = 2'd0, Body=2'd1, Brick=2'd2, Apple=2'd3;

localparam	None_Color = {8'hFF, 8'hFF, 8'hFF},
			Body_Color = {8'h08, 8'hFF, 8'h00},
			Apple_Color ={8'hFF, 8'h00, 8'h00},	
			Score_Color ={8'h08, 8'h08, 8'hFF}, 
			HiSco_Color ={8'hFF, 8'h88, 8'h00};
// every tile size is 32 pixel 
always @(negedge clk)
	if(LCD_DEN) begin
		case(vout[1:0]) // type
			None:	{R,G,B} <= None_Color ;
			Body:	{R,G,B} <= Body_Color ;
//			Brick:	{R,G,B} <= Brick_Color;
			Apple:	{R,G,B} <= Apple_Color;
		endcase
		if(text_q>0){R,G,B} <= x<660 ? HiSco_Color : Score_Color;
	end 
	else {R,G,B} <= 1'b0;


endmodule
