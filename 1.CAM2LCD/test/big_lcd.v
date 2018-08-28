module big_lcd(

input clk,
input reset,
input [15:0] lcd_readdata,
output lcd_read,

output wire [7:0] R,
output wire [7:0] G,
output wire [7:0] B,
output wire HSYNC,
output wire VSYNC,
output wire LCD_CLK

);

reg [10:0] counter_hs;
reg [10:0] counter_vs;

reg [20:0] pixel_counter;

assign LCD_CLK = (reset == 1) ? clk : 0;

always@(posedge clk)
begin
if(reset == 1'b0)
	begin
		counter_hs <= 0;
		counter_vs <= 0;
	end
	else
		begin
			if(counter_hs == 1055	)
			begin
			
				if(counter_vs == 524)
					counter_vs <= 0;
				else
					counter_vs <= counter_vs + 1;
			
				counter_hs <= 0;
			end
			else
				counter_hs <= counter_hs + 1;
		end	
end

wire data_en;

assign lcd_read = (counter_hs >= 42 && counter_hs <= 681 && counter_vs >= 23  && counter_vs < 503) ? 1 : 0;

assign data_en = (counter_hs >= 46 && counter_hs <= 686 && counter_vs >= 23  && counter_vs < 503) ? 1 : 0;

assign VSYNC = (counter_vs >= 0 && counter_vs < 10) ? 0 : 1;
assign HSYNC = (counter_hs >= 0 && counter_hs < 10) ? 0 : 1;

assign R = data_en == 1 ? {lcd_readdata[15:11], lcd_readdata[15:13]} : 8'hff;
assign G = data_en == 1 ? {lcd_readdata[10:5], lcd_readdata[10:9]} : 8'h00;
assign B = data_en == 1 ? {lcd_readdata[4:0], lcd_readdata[4:2]} : 8'h0f;


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