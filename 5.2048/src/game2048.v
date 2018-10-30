module game2048(
	input wire clk_in, rst,
	input wire btn, btn1,
	output reg [0:2] RGB_LED,
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

localparam Key_Left=4'h1, Key_Right=4'h3, Key_Up=4'h6, Key_Down=4'h2;
localparam game_init=1, game_rand=2, game_keywait=3, game_keyup=4, game_cal=5, game_move=6, game_over=3'd7;

reg[13:0] grid[15:0];
reg[15:0]  score;

///////////////////////////////////
wire clk, clklock;
ip_pll pll(
	.refclk		(clk_in),
	.reset		(~rst),
	.extlock	(clklock),
	.clk0_out	(clk)
);
///////////////////////////////////
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
///////////////////////////////////
//wire[3:0] code;
//wire keydown, scan_clk;
//keypad4x4 key(clk, rst, row, col, code, keydown, scan_clk);

reg keydown;
wire[3:0] code = Key_Down;
always @(posedge LCD_DEN)
	if(LCD_DEN)
		keydown <= btn==0;
///////////////////////////////////

wire[7:0] randq;
LFSR8_11D LFSR8_11D(clk, rst, randq);

/////////////////////////////////////////////

reg	m; // need move 2 times: 1st m=0; 2nd m=1;
reg	q; // any tile moved, will set 1(true)
reg[2:0]	f,g,h; // loop index 
wire[3:0] o1, o2; // cal index

wire[3:0] right	= 2'h3 +(g<<2)-f;
wire[3:0] left	= 1'h0 +(g<<2)+f;
wire[3:0] up 	= 1'h0 +g+(f<<2);
wire[3:0] down	= 4'hc +g-(f<<2);

reg[2:0]	key;
// keyboard
assign o1 = 
			key==0 ? right :
			key==1 ? left  :
			key==2 ? up    :
			key==3 ? down  : 1'b0;
assign o2 = 
			key==0 ? right-1 :
			key==1 ? left +1 :
			key==2 ? up   +4 :
			key==3 ? down -4 : 1'b0;
			
always @(posedge keydown or code)
	if(keydown==1)
		case(code)
		Key_Right:	key <= 0;
		Key_Left:	key <= 1;
		Key_Up:		key <= 2;
		Key_Down:	key <= 3;
		default: 	key <= 4;
		endcase

reg[3:0] game_state;
reg[4:0] grid_cnt;
// game state machine
always @(posedge clk or negedge rst)
	if(!rst) begin
		grid_cnt <= 1'b0;
		game_state <= game_init;
	end
	else if(game_state == game_init) begin
		if(grid_cnt<=4'd15) begin
			grid[grid_cnt] <= 1'b0;
			grid_cnt <= grid_cnt + 1'b1;
		end
		else begin 
			score <= 16'd0;
			grid[5] <= 4'd2;
			grid_cnt <= 4'd0;
			game_state <= game_rand;
		end
	end
	else if(game_state == game_rand) begin
		if(grid[randq[3:0]]==0) begin
			grid[randq[3:0]] <= 4'd2;
			game_state <= game_keywait;
		end
	end
	else if(game_state == game_keywait) begin
		RGB_LED<=3'b011; // red
		if(keydown==1) begin
			game_state <= game_keyup;
		end
	end
	else if(game_state == game_keyup) begin
		RGB_LED<=3'b101; // green
		if(keydown==0) begin
			q <= 1'b0;
			g <= 1'b0;
			f <= 1'b0;
			h <= 1'b0;
			m <= 1'b0; // first move
			game_state <= game_move;
		end
	end
	else if(game_state == game_cal) begin
		if(g<4) begin
			if(f<3) begin
				if(grid[o1]==grid[o2] & grid[o1]!=0) begin
					grid[o1] <= grid[o1]+grid[o1];
					grid[o2] <= 1'b0;
					score <= score + grid[o1]+grid[o1];
					q <= 1'b1;
					f <= f+2'd2;
				end
				else begin
					f <= f+2'd1;
				end
			end
			else begin
				f <= 1'b0;
				g <= g+1'd1;
			end
		end
		else begin
			g <= 1'b0;
			game_state <= game_move; // second move
		end
	end
	else if(game_state == game_move) begin
		if(g<4) begin	// 4 col or row
			if(h<2) begin // bad method
				if(f<3) begin
					if(grid[o1]==0) begin
						grid[o1] <= grid[o2];
						grid[o2] <= 1'b0;
						if(grid[o2]!=0) q <= 1'b1;
					end
					f <= f+1'b1;
				end
				else begin
					f <= 1'b0;
					h <= h+1'b1;
				end
			end
			else begin
				h <= 1'b0;
				g <= g+1'b1;
			end
		end
		else begin
			if(m == 1) begin
				if(q == 1) // moved
					game_state <= game_rand; // new loop
				else
					game_state <= game_keywait; // no move and cal
			end
			else begin
				m <= 1'b1;
				g <= 1'b0;
				f <= 1'b0;
				game_state <= game_cal;
			end
		end
	end
	else if(game_state == game_over)
		;					

// bmp from rom
wire[9:0]	rom_address;
wire[31:0] rom_q;
chrom u_chrom(
  .wclk(clk), // input clk
  .raddr(rom_address), // input [9:0] address from 0-703
  .do(rom_q) // output [31:0] dout
  );

wire data;
wire[3:0] i, ii, j, jj;
wire[13:0] number;
wire[9:0] posx, posy;

localparam X=150, Y=140;
assign ii = x/X;
assign jj = y/Y;
assign i = ii<4 ? ii : 0;
assign j = jj<4 ? jj : 0;
assign posx = X*i;
assign posy = Y*j;
assign number = grid[(j<<2)+i];

block u_block(clk, rst, rom_address, rom_q, posx, posy, x, y, number, data);

localparam 	Color = {8'hFF, 8'hFF, 8'hFF};
		
// video

always @(negedge clk)
	if(LCD_DEN) begin
		{R,G,B} <= data>0 ? Color :  12'b0;
	end 
	else {R,G,B} <= 12'b0;

endmodule
