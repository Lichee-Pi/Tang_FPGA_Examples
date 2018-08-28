module cameraReader
(
	input clk,
	input reset_n,
	
	output csi_xclk,
	
	input csi_pclk,
	input [7:0] csi_data,
	input csi_vsync,
	input csi_hsync,
	
	output reg [15:0] data_out = 0,
	output wire wrreq,
	output wire wrclk,
	output reg [19:0]wraddr
);

reg [19:0] pixel_counter = 0;

assign csi_xclk = (reset_n == 1) ? clk : 0;

reg vsync_passed = 0;
reg write_pixel = 0;

reg wrclk1 = 0;

always@(posedge csi_pclk)
wrclk1 <= ~wrclk1;

always@(negedge wrclk1)
begin
	if(csi_hsync == 1)
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

always@(posedge csi_pclk)
begin
	if(reset_n == 0)
		begin
			pixel_counter <= 0;
			vsync_passed <= 0;
		end
	else
		begin
			if(csi_vsync == 1)
			begin
				pixel_counter <= 0;
				vsync_passed <= 1;
				wraddr <= 0;
			end
			else
				if(csi_hsync == 1 && vsync_passed == 1)
				begin
					if(pixel_counter[0] == 0)
					begin
						pixel_counter <= pixel_counter + 1;
						subpixel <= csi_data;
					end
					else
					begin
//						current_pixel <= { subpixel, csi_data};
						current_pixel <= { csi_data, subpixel};
						pixel_counter <= pixel_counter + 1;
						wraddr <= wraddr + 1;
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

assign wrreq = (write_pixel == 1) && pixel_counter > 2 ? wrclk1 : 0;
assign wrclk = ~csi_pclk;

endmodule
