module snake #(parameter Row = 5'd25, Col=5'd15, Speed = 8'b111)
(
	input wire clk, rst,
	// Keyboard
	input wire[3:0] code,
	input wire keydown,
	// LCD 800*480
	input wire[10:0] x, y,
	input wire frame_sync0, frame_sync1,
	// Graphic pixel(x,y)
	output wire[1:0] pixel,
	// GAME Score
	output reg[11:0] score, hi_score
);

localparam Right = 2'd0, Left = 2'd1, Up = 2'd2, Down = 2'd3;
localparam None = 2'd0, Body=2'd1, Brick=2'd2, Apple=2'd3;
localparam Key_Left=4'h2, Key_Right=4'h4, Key_Down=4'h3, Key_Up=4'h7;

// data and video buffer
reg vwren;
reg[8:0] raddr, waddr;
reg[3:0] vdata;
wire[3:0]vout;
vram vram(
	.do		(vout),
	.di		(vdata),
	.raddr	(raddr),
	.waddr	(waddr),
	.wclk	(clk),
	.we		(vwren)
);
assign pixel[1:0] = vout[1:0];

// random generater
wire[7:0] randq;
wire[4:0] rand_x = randq[3:0]+randq[6:4]; // 16+8=24
wire[4:0] rand_y = randq[7:4]-1; // 16-1=15
LFSR8_11D LFSR8_11D(
	.clk	(clk), 
	.rst	(rst), 
	.LFSR	(randq)
);

// game infinite state machine
reg[1:0] head_dir;
reg[4:0] head_pos_x, head_pos_y;
reg[4:0] tail_pos_x, tail_pos_y;
reg[4:0] appl_pos_x, appl_pos_y;
reg[5:0] speed_cnt;

reg[3:0]	ram_state;
localparam	ram_clr=0, ram_gen_apple=1, ram_set_apple=2, ram_set_head=3,
			ram_logic=4, ram_check=5, ram_clr_tail=6, ram_start=7;

always @(posedge clk or negedge rst)
	if(!rst) begin
		hi_score <= 1'b0;
		{appl_pos_x, appl_pos_y} <= {5'd10, 5'd10};
		{tail_pos_x, tail_pos_y} <= {5'd10, 5'd2};
		ram_state <= ram_start;
	end
	else if(ram_state==ram_start) begin	// reset screen
		speed_cnt <= 1'b0;
		score <= 1'b0;
		vdata <= {Right, None};
		waddr <= 8'd0;
		raddr <= 8'd0;
		vwren <= 1'b1;
		ram_state <= ram_clr;
	end
	else if(ram_state==ram_clr) begin	// reset screen
		if(waddr < Row*Col )
			waddr <= waddr + 1'b1; // clear video ram
		else ram_state <= ram_set_apple;
	end
	else if(ram_state==ram_gen_apple) begin	// generate apple position, random
		if(vout[1:0] != Body && vout[1:0] != Apple)
			ram_state<=ram_set_apple; // apple postion is ok, goto next state
		else begin
			raddr <= Row*rand_y + rand_x;
			{appl_pos_x, appl_pos_y} <= {rand_x, rand_y}; // gen apple again 
		end
	end
	else if(ram_state==ram_set_apple) begin	// cell <= apple 
		vdata[1:0] <= Apple;
		waddr <= Row*appl_pos_y + appl_pos_x;
		vwren <= 1'b1;
		ram_state<=ram_set_head;
	end
	else if(ram_state==ram_set_head) begin	// cell <= head
		vdata <= {head_dir, Body};
		waddr <= Row*head_pos_y + head_pos_x;
		vwren <= 1'b1;
		ram_state<=ram_logic;
	end
	else if(ram_state==ram_logic) begin
		vwren <= 1'b0;		// read ram
		if(speed_cnt==Speed) begin	// snake move a grid, need check collision
			speed_cnt<=1'b0;
			ram_state <= ram_check;
			raddr <= Row*head_pos_y + head_pos_x;
		end
		else if(frame_sync0)		// new frame start
			ram_state <= ram_set_head;	// save head turn direct
		else if(frame_sync1)		// new frame begin, start snake speed count
			speed_cnt <= speed_cnt+1'b1;
		if(x[9:5]<Row)
			raddr <= Row*y[9:5] + x[9:5];	// read cell(32*32 pixel) for graphic render
	end
	else if(ram_state==ram_check) begin	// head check // vram read latecy 5 clk
		if(vout[1:0] == Apple) begin // if head type is apple, than generate new apple
			score <= score + 1'b1;
			hi_score = (score >= hi_score) ? score+1'b1 : hi_score;
			ram_state <= ram_gen_apple;
			raddr <= Row*rand_y + rand_x;
			{appl_pos_x, appl_pos_y} <= {rand_x, rand_y};
		end
		else if(vout[1:0] == None) begin// head type none, clean tail
			ram_state <= ram_clr_tail;
			raddr <= Row*tail_pos_y + tail_pos_x;
		end
		else if(vout[1:0] == Body) begin// game over, restart
			{tail_pos_x, tail_pos_y} <= {head_pos_x, head_pos_y};
			ram_state <= ram_start;
		end
	end
	else if(ram_state==ram_clr_tail) begin	// clear tail // vram read latecy 5 clk
		vwren <= 1'b1; // write
		vdata <= {Right, None}; // clean
		waddr <= Row*tail_pos_y + tail_pos_x;
		//move(vout[3:2], tail_pos_x, tail_pos_y);	// task not ok at anlogic chip
		case(vout[3:2]) //tail dir
			Right:	tail_pos_x <= tail_pos_x<Row-1 ? tail_pos_x + 1'b1 : 5'd00;
			Left:	tail_pos_x <= tail_pos_x>5'd00 ? tail_pos_x - 1'b1 : Row-1;
			Up:		tail_pos_y <= tail_pos_y>5'd00 ? tail_pos_y - 1'b1 : Col-1;
			Down:	tail_pos_y <= tail_pos_y<Col-1 ? tail_pos_y + 1'b1 : 5'd00;
			default:;
		endcase
		ram_state <= ram_set_apple;
	end
	

wire clk_move= speed_cnt==Speed;

// go ahead, move head position, before check collision one clock
always @(posedge clk_move or negedge rst)
	if(!rst)
		{head_pos_x, head_pos_y} <= {5'd10, 5'd2};
	else
		//move(head_dir, head_pos_x, head_pos_y);	// task not ok at anlogic chip
	case(head_dir) // dir
		Right:	head_pos_x <= head_pos_x<Row-1 ? head_pos_x + 1'b1 : 5'd00;
		Left:	head_pos_x <= head_pos_x>5'd00 ? head_pos_x - 1'b1 : Row-1;
		Up:		head_pos_y <= head_pos_y>5'd00 ? head_pos_y - 1'b1 : Col-1;
		Down:	head_pos_y <= head_pos_y<Col-1 ? head_pos_y + 1'b1 : 5'd00;
	endcase

// keyboard process
always @(keydown or negedge rst)
	if(!rst)
		head_dir <= Left;
	else
	if(keydown)
		case(code)
			Key_Right:	head_dir<= head_dir!=Left ? Right: head_dir;
			Key_Left: 	head_dir<= head_dir!=Right? Left : head_dir;
			Key_Up:		head_dir<= head_dir!=Down ? Up   : head_dir;
			Key_Down:	head_dir<= head_dir!=Up	  ? Down : head_dir;
		endcase

/* // anlogic task does not work, why?
task move;
	input wire[1:0] dir;
	inout reg[4:0] px, py;
	case(dir) // dir
		Right:	px <= px<Row-1 ? px + 1'b1 : 5'd00;
		Left:	px <= px>5'd00 ? px - 1'b1 : Row-1;
		Up:		py <= py>5'd00 ? py - 1'b1 : Col-1;
		Down:	py <= py<Col-1 ? py + 1'b1 : 5'd00;
	endcase
endtask
*/

endmodule
