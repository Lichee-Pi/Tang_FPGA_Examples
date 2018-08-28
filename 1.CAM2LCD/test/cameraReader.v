module cameraReader
#(
parameter x_size = 800,
parameter y_size = 480
)
(
	input clk_in,
	input reset_n,
	
	output xclk,
	
	input pclk,
	input [7:0] data,
	input vsync,
	input hsync,
	
	output reg [15:0] data_out = 0,
	output wire wrreq,
	output wire wrclk
);

reg [19:0] pixel_counter = 0;

assign xclk = reset_n == 1 ? clk_in : 0;

reg vsync_passed = 0;
reg write_pixel = 0;

reg wrclk1 = 0;

//2·ÖÆµ
always@(posedge pclk)
	wrclk1 <= ~wrclk1;

always@(negedge wrclk1)
begin
	if(hsync == 1)
		write_pixel <= 1;
	else
		write_pixel <= 0;
end

reg [7:0] subpixel;
reg [15:0] current_pixel;

always@(posedge wrreq )
begin
	data_out <= current_pixel;
end

always@(posedge pclk)
begin
	if(reset_n == 0)
		begin
			pixel_counter <= 0;
			vsync_passed <= 0;
		end
	else
		begin
			if(vsync == 1)
			begin
				pixel_counter <= 0;
				vsync_passed <= 1;
			end
			else
				if(hsync == 1 && vsync_passed == 1)
				begin
					if(pixel_counter[0] == 0)
					begin
						pixel_counter <= pixel_counter + 1;
						subpixel <= data;
					end
					else
					begin
						current_pixel <= { subpixel, data};
						pixel_counter <= pixel_counter + 1;
					end
				end
				else
				begin
				if(write_pixel == 1)
					pixel_counter <= pixel_counter + 1;
				else
					pixel_counter <= 0;
				end
		end
end

assign wrreq = write_pixel == 1 && pixel_counter > 2 ? wrclk1 : 0;

assign wrclk = wrclk1;

endmodule
