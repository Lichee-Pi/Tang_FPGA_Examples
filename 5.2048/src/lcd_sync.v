module lcd_sync(
	input  wire clk,
	input  wire rst,
	output wire lcd_clk,
	output wire lcd_pwm,
	output wire lcd_hsync, 
	output wire lcd_vsync, 
	output wire	lcd_de,
	output wire [10:0] pix_x, 
	output wire [10:0] pix_y,
	output reg  [10:0] h_cnt,
	output reg  [10:0] v_cnt
);
	//800*480
	localparam thd	= 800;
	localparam thwh	= 48;
	localparam thbp	= 40;
	localparam thfp	= 40;
	localparam thb	= 88;//thwh + thbp;
	localparam th	= 928;

	localparam tvd	= 480;
	localparam tvwh	= 3;
	localparam tvbp	= 29;
	localparam tvfp	= 13;
	localparam tvb	= 32;//tvwh + tvbp;
	localparam tv	= 525;

always @(posedge clk or negedge rst)
	if(!rst) h_cnt <= 1'b0;
	else if(h_cnt == th) h_cnt <= 1'b0;
	else h_cnt <= h_cnt + 1'b1;

always @(posedge clk or negedge rst)
	if(!rst) v_cnt <= 1'b0;
	else if(v_cnt == tv) v_cnt <= 1'b0;
	else if(h_cnt == th) v_cnt <= v_cnt + 1'b1;

assign lcd_clk = (rst == 1) ? clk : 1'b0;
assign lcd_pwm = (rst == 1) ? 1'b1 : 1'b0;
assign lcd_hsync = h_cnt <= thwh ? 0 : 1;
assign lcd_vsync = v_cnt <= tvwh ? 0 : 1;
assign lcd_de = (h_cnt >= thb && h_cnt <= th && v_cnt >= tvb  && v_cnt < tv) ? 1 : 0;
assign pix_x = h_cnt - thb;
assign pix_y = v_cnt - tvb;

endmodule