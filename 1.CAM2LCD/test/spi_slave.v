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

module spi_slave (
  input           clk,
  input           reset_n,
  
  input           sclk,
  input           mosi,
  input           ssel,
  output          miso,
  
  output [16:0]   mem_addr,
  input  [7:0]    mem_data  
  );
  
  
  reg    [1:0]    sclk_reg;
  reg    [1:0]    mosi_reg;
  reg    [2:0]    bit_cnt;
  wire   [7:0]    data_to_send;
  reg    [7:0]    data_to_send_buf;
  reg    [7:0]    data_received;
  reg             byte_received;
  reg             addr_data_flag;
  
  reg    [16:0]   rd_addr_reg;
  
  wire            sclk_rising_edge = (sclk_reg == 2'b01);
  wire            sclk_falling_edge = (sclk_reg == 2'b10);
  wire            mosi_data = mosi_reg[1];
  
  assign          miso = data_to_send_buf[7];
  assign          mem_addr = rd_addr_reg;
  
  always @ (posedge clk or negedge reset_n)
    begin
      if (!reset_n)
        sclk_reg <= 2'b00;
      else
      if (ssel)
        sclk_reg <= 2'b00;
      else
        sclk_reg <= {sclk_reg[0], sclk};      
    end
  
  always @ (posedge clk or negedge reset_n)
    begin
      if (!reset_n)
        mosi_reg <= 2'b00;
      else
      if (ssel)
        mosi_reg <= 2'b00;
      else
        mosi_reg <= {mosi_reg[0], mosi};      
    end
  
  always @ (posedge clk or negedge reset_n)
    begin
      if (!reset_n)
        begin
          bit_cnt <= 3'h0;
          data_received <= 8'h00;
        end
      else
      if (ssel)
        begin
          bit_cnt <= 3'h0;
          data_received <= 8'h00;        
        end
      else
      if (sclk_rising_edge)
        begin
          bit_cnt <= bit_cnt + 3'h1;
          data_received <= {data_received[6:0], mosi_data};
        end
      else
        begin
          bit_cnt <= bit_cnt;
          data_received <= data_received;
        end        
    end
    
  always @ (posedge clk or negedge reset_n)  
    begin
      if (!reset_n)
        byte_received <= 1'b0;
      else
      if ((!ssel) && sclk_rising_edge && (bit_cnt == 3'h7)) 
        byte_received <= 1'b1;
      else
        byte_received <= 1'b0;      
    end
    
  always @ (posedge clk or negedge reset_n)
    begin
      if (!reset_n)
        data_to_send_buf <= 8'h00;
      else
      if (ssel)
        data_to_send_buf <= 8'h00;
      else
      if ((bit_cnt == 3'h0) && sclk_falling_edge)
        data_to_send_buf <= data_to_send;
      else
      if (sclk_falling_edge)
        data_to_send_buf <= {data_to_send_buf[6:0], 1'b0};
      else
        data_to_send_buf <= data_to_send_buf;      
    end    
  
  always @ (posedge clk or negedge reset_n)
    begin
      if (!reset_n)
        addr_data_flag <= 1'b0;
      else
      if (ssel)
        addr_data_flag <= 1'b0;
      else
      if ((!ssel) && byte_received)
        addr_data_flag <= 1'b1;
      else
        addr_data_flag <= addr_data_flag;      
    end
  
  always @ (posedge clk or negedge reset_n)
    begin
      if (!reset_n)
        rd_addr_reg <= 17'h00000;
      else
      if ((!addr_data_flag) && byte_received)     
        rd_addr_reg <= {9'h000, data_received};
      else
      if (addr_data_flag && byte_received)
        rd_addr_reg <= rd_addr_reg + 17'h00001;
      else
        rd_addr_reg <= rd_addr_reg;      
    end  

  assign          data_to_send = mem_data;
  
endmodule  