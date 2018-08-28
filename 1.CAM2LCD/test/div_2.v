module div_2 (q,clk,reset); //   输出q，输入时钟CLK，同步复位信号RESET.
    output q;
    input reset;
    input clk;
    reg q;
    always @ (posedge clk or posedge reset)
    if (reset==0)
      q<=1'b0; // 复位置零
      else
      q<=~q; // 否则q信号翻转
endmodule

