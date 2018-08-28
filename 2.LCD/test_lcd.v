
module test_lcd
(
	input wire CLK_IN,
	input wire RST_N,
	output wire [0:7] R,
	output wire [0:7] G,
	output wire [0:7] B,
	output wire LCD_CLK,
	output wire LCD_HSYNC,
	output wire LCD_VSYNC,
	output wire LCD_DEN,
	output wire LCD_PWM		//backlight,set to high
);
	wire clk_lcd;
	wire clklock;
	wire [10:0] hsync;
	wire [10:0] vsync;

	ip_pll pll
	(
		.refclk		(CLK_IN),
		.reset		(~RST_N),
		.extlock		(clklock),
		.clk0_out	(clk_lcd)
	);
	
	//lcd display
	wire [10:0] hsync_cnt;
	wire [10:0] vsync_cnt;
	wire lcd_rden;
	wire [15:0]lcd_rddat;	//lcd read
	wire [15:0]lcd_rdaddr;
	
	lcd_sync 
	#(
		.IMG_W(800),
		.IMG_H(480),
		.IMG_X(0),
		.IMG_Y(0)
	)
	u_lcd_sync
	(
  		.clk			(clk_lcd),
  		.rest_n		(RST_N),
		.lcd_clk		(LCD_CLK),
		.lcd_pwm		(LCD_PWM),
  		.lcd_hsync	(LCD_HSYNC), 
  		.lcd_vsync	(LCD_VSYNC), 
  		.lcd_de		(LCD_DEN),
  		.hsync_cnt	(hsync_cnt),
  		.vsync_cnt	(vsync_cnt),
		.img_ack		(lcd_rden),
		.addr		(lcd_rdaddr)
  	);

 	data_out datout
	(	
		.clk_lcd		(clk_lcd), 
		.R			(R),
		.G			(G),
		.B			(B),
		.den			(lcd_rden),
		.hsync		(hsync_cnt),
		.vsync		(vsync_cnt)
	);

endmodule
