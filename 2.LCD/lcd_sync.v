
module lcd_sync
#(
 	//display image at pos
	parameter IMG_W = 100,  //ͼƬص
	parameter IMG_H = 100,  //ͼƬص
	parameter IMG_X = 0,
	parameter IMG_Y = 0
)
(
	input wire clk,
	input wire rest_n,
	output wire lcd_clk,
	output wire lcd_pwm,
	output wire lcd_hsync, 
	output wire lcd_vsync, 
	output wire lcd_de,
	output wire [10:0] hsync_cnt,
	output wire [10:0] vsync_cnt,
	output wire img_ack,
	output wire [15:0]addr
	);
	
	`define LCD_480800
`ifdef LCD_480800
	//800*480
	localparam TFT_H = 800;  //TFTص
	localparam TFT_V = 480;  //TFTص
	
	localparam thb = 256;
	localparam th = 1056 + thb;

	localparam tvb = 45;
	localparam tv = 525 + tvb;


	//640*480
//	localparam TFT_H = 640;  //TFTص
//	localparam TFT_V = 480;  //TFTص
	
//	localparam thb = 160;
//	localparam th = 640 + thb;

//	localparam tvb = 45;
//	localparam tv = 525 + tvb;
`else
	
	localparam TFT_H = 480;  //TFTص
	localparam TFT_V = 272;  //TFTص
	
	localparam thb = 41;
	localparam th = 533 + thb;

	localparam tvb = 10;
	localparam tv = 288 + tvb;
`endif

	reg [10:0] counter_hs;
	reg [10:0] counter_vs;

	always@(posedge clk)begin
	if(rest_n == 1'b0)begin
		counter_hs <= 0;
		counter_vs <= 0;
	end
	else begin
	if(counter_hs == th	)begin
		if(counter_vs == tv)
			counter_vs <= 0;
		else
			counter_vs <= counter_vs + 1;
			counter_hs <= 0;
	end
	else
		counter_hs <= counter_hs + 1;
	end	
	end

	reg [10:0]img_hbegin = 0;   //ͼƬϽǵһصTFT
	reg [10:0]img_vbegin = 0;   //ͼƬϽǵһصTFTĳ

	assign lcd_clk = (rest_n == 1) ? clk : 1'b0;
	assign lcd_pwm = (rest_n == 1) ? 1'b1 : 1'b0;
	assign lcd_hsync = (counter_hs >= (thb+4) && counter_hs < (th-5)) ? 0 : 1;
	assign lcd_vsync = (counter_vs >= (tvb+2) && counter_vs < (tv-5)) ? 0 : 1;
	assign lcd_de = (counter_hs >= thb && counter_hs <= th && counter_vs >= tvb  && counter_vs < tv) ? 1 : 0;
 	assign hsync_cnt = counter_hs;
 	assign vsync_cnt = counter_hs;

	assign img_ack = lcd_de &&
	((counter_hs - thb) >= IMG_X && (counter_hs - thb) < (IMG_X + IMG_W)) && 
	((counter_vs - tvb) >= IMG_Y && (counter_vs - tvb) < (IMG_Y + IMG_H))?1'b1:1'b0;
	
 	reg [15:0]read_addr;             //ͼƬromַ                  
//    wire [15:0]img_data;       //ͼƬ
/*
 	img mif_img
 	(
 		.doa(img_data), 
 		.addra(addr), 
 		.clka(clk), 
 		.rsta(!rest_n) 
 	);
 	*/
 	
 	assign addr = read_addr;
 	
 	 always@(posedge clk or negedge rest_n)
     begin
         if(!rest_n)
             read_addr <= 16'd0;
         else if(img_ack)
             read_addr <= (counter_hs - IMG_X - thb) + (counter_vs - IMG_Y - tvb)*IMG_W;
         else
             read_addr <= 16'd0;  
     end
     
     
// 		reg [20:0] pixel_counter;
//always@(posedge clk)
//begin
//if(reset == 1'b0)
//	begin
//		pixel_counter <= 0;
//	end
//	else
//		begin
//			if(counter_hs >= 46 && counter_hs <= 686 && counter_vs >= 23  && counter_vs < 503)
//			begin
//				pixel_counter <= pixel_counter + 1;
//			end
//		else
//			if(counter_vs == 504)
//				pixel_counter <= 0;
//		end	
//end	 


endmodule