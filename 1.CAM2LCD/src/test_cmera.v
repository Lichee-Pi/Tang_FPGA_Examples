
module test_cmera
	(
		input wire CLK_IN,	 	//ϵͳʱ
		input wire RST_N,		//λ,Ĭ
		//camera
		input wire CSI_PCLK,	//CSIʱ
		output wire CSI_XCLK,	//CSIϵͳʱ
		input wire CSI_HREF,	//ͬ
		input wire CSI_VSYNC,	//֡ͬ
		output wire CSI_PWDN,	//ģʽ
		output wire CSI_RST,	//λ
		output wire CSI_SOIC,	//SCCB,ʱ
		inout wire CSI_SOID,	//SCCB,
		input wire [7:0]CSI_D,	//
		//lcd
		output wire [7:0] R,
		output wire [7:0] G,
		output wire [7:0] B,
		output wire LCD_CLK,
		output wire LCD_HSYNC,
		output wire LCD_VSYNC,
		output wire LCD_DEN,
		output wire LCD_PWM,	//backlight,set to high
		//test
		output wire TESTA,
		output wire TESTB,
		output wire TESTC,
		output wire TESTD,
		output wire TESTE,
		output wire TESTF,
		output wire [0:7]OD
	 );
	 
	wire clk_lcd;
	wire clk_cam;
	wire clk_sccb;
	
	ip_pll pll(
		.refclk(CLK_IN),		//24M
		.clk0_out(clk_lcd),		//lcd clk
		.clk1_out(clk_cam),		//12m,for cam xclk
		.clk2_out(clk_sccb)		//4m,for sccb init
	);
	
	reg init_state;
	wire init_ready;
	wire sda_oe;
	wire sda;
	wire sda_in;
	wire scl;

	camera_init u_camera_init
	(
		.clk(clk_sccb),
		.reset_n(RST_N),
		.ready(init_ready),
		.sda_oe(sda_oe),
		.sda(sda),
		.sda_in(sda_in),
		.scl(scl)
	);
	assign CSI_SOID = (sda_oe == 1'b1) ? sda : 1'bz;
	assign sda_in = CSI_SOID;
	assign CSI_SOIC = scl;
	assign CSI_PWDN = 1'b0;
	assign CSI_RST = 1'b1;
	//test
//	assign TESTE = (sda_oe == 1'b1) ? sda : 1'bz;
//	assign TESTF = scl;

	//lcd display
	wire [10:0] hsync_cnt;
	wire [10:0] vsync_cnt;
	wire lcd_rden;
	wire [15:0]lcd_rddat;	//lcd read
	wire [15:0]lcd_rdaddr;
	
	lcd_sync 
	#(
		.IMG_W(200),
		.IMG_H(164),
		.IMG_X(50),
		.IMG_Y(50)
	)
	u_lcd_sync
	(
  		.clk		(clk_lcd),
  		.rest_n		(RST_N),
		.lcd_clk	(LCD_CLK),
		.lcd_pwm	(LCD_PWM),
  		.lcd_hsync	(LCD_HSYNC), 
  		.lcd_vsync	(LCD_VSYNC), 
  		.lcd_de		(LCD_DEN),
  		.hsync_cnt	(hsync_cnt),
  		.vsync_cnt	(vsync_cnt),
		.img_ack	(lcd_rden),
		.addr		(lcd_rdaddr)
  	);
  
	wire camera_wrreq,camera_wclk;
	wire [15:0]camera_wrdat;
	wire [19:0]camera_addr;

	cameraReader u_cameraReader
	(
		.clk(clk_cam),
		.reset_n(RST_N),
		.csi_xclk(CSI_XCLK),
		.csi_pclk(CSI_PCLK),
		.csi_data(CSI_D),
		.csi_vsync(!CSI_VSYNC),
		.csi_hsync(CSI_HREF),
		.data_out(camera_wrdat),
		.wrreq(camera_wrreq),
		.wrclk(camera_wclk),
		.wraddr(camera_addr)
	);

  	img_cache uimg 
  	( 
  		//write 45000*8
		.dia(camera_wrdat), 
		.addra(camera_addr), 
		.cea(camera_wrreq), 
		.clka(camera_wclk), 
		.rsta(!RST_N), 
		//read 22500*16
		.dob(lcd_rddat), 
		.addrb(lcd_rdaddr), 
		.ceb(lcd_rden),
		.clkb(clk_lcd), 
		.rstb(!RST_N)
	);

//	assign TESTA = fifo_we;
//	assign TESTB = CSI_PCLK;
//	assign TESTC = CSI_VSYNC;
//	assign TESTD = CSI_HREF;
//	assign OD = CSI_D;

	assign R = lcd_rden ? {lcd_rddat[15:11], lcd_rddat[15:13]} : 8'h00;
	assign G = lcd_rden ? {lcd_rddat[10:5], lcd_rddat[10:9]} : 8'h00;
	assign B = lcd_rden ? {lcd_rddat[4:0], lcd_rddat[4:2]} : 8'h00;
endmodule
