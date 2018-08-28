/******************************************************************************
Copyright 2017 Gnarly Grey LLC

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
******************************************************************************/

module top 
(
 	input wire CLK_IN,		//24M
 	input wire RST_N,
 	
  output          xclk,
  input           pclk,
  input           vsync,
  input           href,
  input  [7:0]    pdata,
  output          cam_reset_n,
  output          cam_pwrdn,
  
  output          sioc,
  inout           siod

  );

  wire            clk_24m /* synthesis syn_keep=1 */;
  
  reg    [17:0]   pixel_cnt;
  reg             pixel_wr_disable;
  wire            cam_config_done;
  
  wire   [16:0]   mem_rd_addr;
  wire   [7:0]    mem_rd_data;
  wire            reset_n = 1'b1;
  
  //considering two bytes per pixel, taking only one byte out of two by having condition (pixel_cnt[0] == 1'b0)
  wire            pixel_wr = q_href && (!pixel_wr_disable) && (pixel_cnt[0]==0);
  wire            xclk_in;  
  
  reg    [7:0]    q_pdata;
  reg             q_vsync, q_href;
  reg    [15:0]   pix_per_line;
  
  always @(posedge pclk)
    begin
      q_pdata <= pdata;
      q_vsync <= vsync;
      q_href  <= href & (pix_per_line < (320*2));  
    end

  assign          xclk = clk_24m;

  always @ (posedge pclk)
    begin
      pix_per_line <= href ? pix_per_line+1 : 0;
    end

  //Manage address for writing in DPRAM through pixel counter
  always @ (posedge pclk)
    begin
      if (!reset_n)
        begin
          pixel_cnt    <= 18'h00000;
        end
      else
      if (q_vsync)
        begin
          pixel_cnt    <= 18'h00000;
        end
      else
      if (q_href) 
        begin
          pixel_cnt    <= (pixel_cnt<(320*400*2))    ?  pixel_cnt + 18'h00001 : pixel_cnt;
        end
      else
        begin
          pixel_cnt <= pixel_cnt;     
        end  
    end  
      
/*
  //Disable pixel data write from next frame if SPI transfer has been initiated
  always @ (posedge pclk)
    begin
      if (q_vsync)
        pixel_wr_disable <= !ssel;
      else
        pixel_wr_disable <= pixel_wr_disable;
    end
*/

  OV7670_Controller u_OV7670_Controller(
    .clk             (clk_24m),          // 24Mhz clock signal
    .resend          (1'b0),             // Reset signal
    .config_finished (cam_config_done),  // Flag to indicate that the configuration is finished
    .sioc            (sioc),             // SCCB interface - clock signal
    .siod            (siod),             // SCCB interface - data signal
    .reset           (cam_reset_n),      // RESET signal for OV7670
    .pwdn            (cam_pwrdn)         // PWDN signal for OV7670
  );  
  
endmodule  