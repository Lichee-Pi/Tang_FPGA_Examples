
module data_out
	(	
		input wire clk_lcd, 
		output wire [7:0] R,
		output wire [7:0] G,
		output wire [7:0] B,
		input  wire den,
		input  wire [10:0] hsync,
		input  wire [10:0] vsync
	);

	reg [7:0] r_R;
	reg [7:0] r_G;
	reg [7:0] r_B;

  parameter HSYNC_BLANK_WIDTH = 256; // thb
  parameter HSYNC_WIDTH = 1056 + HSYNC_BLANK_WIDTH;     // th

  parameter VSYNC_BLANK_WIDTH = 45;	//tvb
  parameter VSYNC_WIDTH = 525 + VSYNC_BLANK_WIDTH;		//tv

reg scan_dir;
reg [31:0]timecnt;

always@(posedge clk_lcd)
begin
	timecnt<=timecnt+1'b1;
	if(timecnt==32'd33_000_000)
	begin
		timecnt<=32'h0;
		scan_dir = ~scan_dir;
	end
	
	if (den) 
		begin 
			if(scan_dir==1)
			begin
				if (vsync<(160+VSYNC_BLANK_WIDTH)) 
					begin 
						r_R<=8'hff; 
						r_B<=8'h00; 
						r_G<=8'h00; 
					end 
				else if (vsync<(320+VSYNC_BLANK_WIDTH)) 
					begin 
						r_R<=8'h00; 
						r_B<=8'hff; 
						r_G<=8'h00; 
					end
				else if (vsync<VSYNC_WIDTH) 
					begin 
						r_R<=8'h00; 
						r_B<=8'h00; 
						r_G<=8'hff; 
					end
			end
			else
			begin
				if (hsync<(266+HSYNC_BLANK_WIDTH)) 
					begin 
						r_R<=8'hff; 
						r_B<=8'h00; 
						r_G<=8'h00; 
					end 
				else if (hsync<(532+HSYNC_BLANK_WIDTH)) 
					begin 
						r_R<=8'h00; 
						r_B<=8'hff; 
						r_G<=8'h00; 
					end 
				else if (hsync<HSYNC_WIDTH) 
					begin 
						r_R<=8'h00; 
						r_B<=8'h00; 
						r_G<=8'hff; 
					end
				end
		end
	else 
		begin 
			r_R<=8'h00; 
			r_B<=8'h00; 
			r_G<=8'h00;
		end
end

	assign R = r_R;
	assign G = r_G;
	assign B = r_B;

endmodule
