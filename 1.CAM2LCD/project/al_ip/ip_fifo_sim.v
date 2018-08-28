// Verilog netlist created by TD v4.2.217
// Wed Jul 25 09:49:21 2018

`timescale 1ns / 1ps
module img_fifo  // H:/Work/FPGA/AnLogic/LicheeTang/demo/test_lcd_camera/test_camera/al_ip/ip_fifo.v(14)
  (
  clkr,
  clkw,
  di,
  re,
  rst,
  we,
  do,
  empty_flag,
  full_flag
  );

  input clkr;  // H:/Work/FPGA/AnLogic/LicheeTang/demo/test_lcd_camera/test_camera/al_ip/ip_fifo.v(25)
  input clkw;  // H:/Work/FPGA/AnLogic/LicheeTang/demo/test_lcd_camera/test_camera/al_ip/ip_fifo.v(24)
  input [7:0] di;  // H:/Work/FPGA/AnLogic/LicheeTang/demo/test_lcd_camera/test_camera/al_ip/ip_fifo.v(23)
  input re;  // H:/Work/FPGA/AnLogic/LicheeTang/demo/test_lcd_camera/test_camera/al_ip/ip_fifo.v(25)
  input rst;  // H:/Work/FPGA/AnLogic/LicheeTang/demo/test_lcd_camera/test_camera/al_ip/ip_fifo.v(22)
  input we;  // H:/Work/FPGA/AnLogic/LicheeTang/demo/test_lcd_camera/test_camera/al_ip/ip_fifo.v(24)
  output [15:0] do;  // H:/Work/FPGA/AnLogic/LicheeTang/demo/test_lcd_camera/test_camera/al_ip/ip_fifo.v(27)
  output empty_flag;  // H:/Work/FPGA/AnLogic/LicheeTang/demo/test_lcd_camera/test_camera/al_ip/ip_fifo.v(28)
  output full_flag;  // H:/Work/FPGA/AnLogic/LicheeTang/demo/test_lcd_camera/test_camera/al_ip/ip_fifo.v(29)

  wire empty_flag_neg;
  wire full_flag_neg;

  EG_PHY_CONFIG #(
    .DONE_PERSISTN("ENABLE"),
    .INIT_PERSISTN("ENABLE"),
    .JTAG_PERSISTN("DISABLE"),
    .PROGRAMN_PERSISTN("DISABLE"))
    config_inst ();
  not empty_flag_inv (empty_flag_neg, empty_flag);
  not full_flag_inv (full_flag_neg, full_flag);
  EG_PHY_FIFO #(
    .AE(32'b00000000000000000000000000001101),
    .AEP1(32'b00000000000000000000000000001111),
    .AF(32'b00000000000000000001111111111010),
    .AFM1(32'b00000000000000000001111111111001),
    .ASYNC_RESET_RELEASE("SYNC"),
    .DATA_WIDTH_A("1"),
    .DATA_WIDTH_B("2"),
    .E(32'b00000000000000000000000000000001),
    .EP1(32'b00000000000000000000000000000011),
    .F(32'b00000000000000000010000000000000),
    .FM1(32'b00000000000000000001111111111111),
    .GSR("DISABLE"),
    .MODE("FIFO8K"),
    .REGMODE_A("NOREG"),
    .REGMODE_B("NOREG"),
    .RESETMODE("ASYNC"))
    logic_fifo_0 (
    .clkr(clkr),
    .clkw(clkw),
    .csr({2'b11,empty_flag_neg}),
    .csw({2'b11,full_flag_neg}),
    .dia({open_n47,open_n48,open_n49,open_n50,open_n51,open_n52,open_n53,di[0],open_n54}),
    .orea(1'b0),
    .oreb(1'b0),
    .re(re),
    .rprst(rst),
    .rst(rst),
    .we(we),
    .dob({open_n75,open_n76,open_n77,open_n78,open_n79,open_n80,open_n81,do[0],do[8]}),
    .empty_flag(empty_flag),
    .full_flag(full_flag));
  EG_PHY_FIFO #(
    .AE(32'b00000000000000000000000000001101),
    .AEP1(32'b00000000000000000000000000001111),
    .AF(32'b00000000000000000001111111111010),
    .AFM1(32'b00000000000000000001111111111001),
    .ASYNC_RESET_RELEASE("SYNC"),
    .DATA_WIDTH_A("1"),
    .DATA_WIDTH_B("2"),
    .E(32'b00000000000000000000000000000001),
    .EP1(32'b00000000000000000000000000000011),
    .F(32'b00000000000000000010000000000000),
    .FM1(32'b00000000000000000001111111111111),
    .GSR("DISABLE"),
    .MODE("FIFO8K"),
    .REGMODE_A("NOREG"),
    .REGMODE_B("NOREG"),
    .RESETMODE("ASYNC"))
    logic_fifo_1 (
    .clkr(clkr),
    .clkw(clkw),
    .csr({2'b11,empty_flag_neg}),
    .csw({2'b11,full_flag_neg}),
    .dia({open_n82,open_n83,open_n84,open_n85,open_n86,open_n87,open_n88,di[1],open_n89}),
    .orea(1'b0),
    .oreb(1'b0),
    .re(re),
    .rprst(rst),
    .rst(rst),
    .we(we),
    .dob({open_n110,open_n111,open_n112,open_n113,open_n114,open_n115,open_n116,do[1],do[9]}));
  EG_PHY_FIFO #(
    .AE(32'b00000000000000000000000000001101),
    .AEP1(32'b00000000000000000000000000001111),
    .AF(32'b00000000000000000001111111111010),
    .AFM1(32'b00000000000000000001111111111001),
    .ASYNC_RESET_RELEASE("SYNC"),
    .DATA_WIDTH_A("1"),
    .DATA_WIDTH_B("2"),
    .E(32'b00000000000000000000000000000001),
    .EP1(32'b00000000000000000000000000000011),
    .F(32'b00000000000000000010000000000000),
    .FM1(32'b00000000000000000001111111111111),
    .GSR("DISABLE"),
    .MODE("FIFO8K"),
    .REGMODE_A("NOREG"),
    .REGMODE_B("NOREG"),
    .RESETMODE("ASYNC"))
    logic_fifo_2 (
    .clkr(clkr),
    .clkw(clkw),
    .csr({2'b11,empty_flag_neg}),
    .csw({2'b11,full_flag_neg}),
    .dia({open_n119,open_n120,open_n121,open_n122,open_n123,open_n124,open_n125,di[2],open_n126}),
    .orea(1'b0),
    .oreb(1'b0),
    .re(re),
    .rprst(rst),
    .rst(rst),
    .we(we),
    .dob({open_n147,open_n148,open_n149,open_n150,open_n151,open_n152,open_n153,do[2],do[10]}));
  EG_PHY_FIFO #(
    .AE(32'b00000000000000000000000000001101),
    .AEP1(32'b00000000000000000000000000001111),
    .AF(32'b00000000000000000001111111111010),
    .AFM1(32'b00000000000000000001111111111001),
    .ASYNC_RESET_RELEASE("SYNC"),
    .DATA_WIDTH_A("1"),
    .DATA_WIDTH_B("2"),
    .E(32'b00000000000000000000000000000001),
    .EP1(32'b00000000000000000000000000000011),
    .F(32'b00000000000000000010000000000000),
    .FM1(32'b00000000000000000001111111111111),
    .GSR("DISABLE"),
    .MODE("FIFO8K"),
    .REGMODE_A("NOREG"),
    .REGMODE_B("NOREG"),
    .RESETMODE("ASYNC"))
    logic_fifo_3 (
    .clkr(clkr),
    .clkw(clkw),
    .csr({2'b11,empty_flag_neg}),
    .csw({2'b11,full_flag_neg}),
    .dia({open_n156,open_n157,open_n158,open_n159,open_n160,open_n161,open_n162,di[3],open_n163}),
    .orea(1'b0),
    .oreb(1'b0),
    .re(re),
    .rprst(rst),
    .rst(rst),
    .we(we),
    .dob({open_n184,open_n185,open_n186,open_n187,open_n188,open_n189,open_n190,do[3],do[11]}));
  EG_PHY_FIFO #(
    .AE(32'b00000000000000000000000000001101),
    .AEP1(32'b00000000000000000000000000001111),
    .AF(32'b00000000000000000001111111111010),
    .AFM1(32'b00000000000000000001111111111001),
    .ASYNC_RESET_RELEASE("SYNC"),
    .DATA_WIDTH_A("1"),
    .DATA_WIDTH_B("2"),
    .E(32'b00000000000000000000000000000001),
    .EP1(32'b00000000000000000000000000000011),
    .F(32'b00000000000000000010000000000000),
    .FM1(32'b00000000000000000001111111111111),
    .GSR("DISABLE"),
    .MODE("FIFO8K"),
    .REGMODE_A("NOREG"),
    .REGMODE_B("NOREG"),
    .RESETMODE("ASYNC"))
    logic_fifo_4 (
    .clkr(clkr),
    .clkw(clkw),
    .csr({2'b11,empty_flag_neg}),
    .csw({2'b11,full_flag_neg}),
    .dia({open_n193,open_n194,open_n195,open_n196,open_n197,open_n198,open_n199,di[4],open_n200}),
    .orea(1'b0),
    .oreb(1'b0),
    .re(re),
    .rprst(rst),
    .rst(rst),
    .we(we),
    .dob({open_n221,open_n222,open_n223,open_n224,open_n225,open_n226,open_n227,do[4],do[12]}));
  EG_PHY_FIFO #(
    .AE(32'b00000000000000000000000000001101),
    .AEP1(32'b00000000000000000000000000001111),
    .AF(32'b00000000000000000001111111111010),
    .AFM1(32'b00000000000000000001111111111001),
    .ASYNC_RESET_RELEASE("SYNC"),
    .DATA_WIDTH_A("1"),
    .DATA_WIDTH_B("2"),
    .E(32'b00000000000000000000000000000001),
    .EP1(32'b00000000000000000000000000000011),
    .F(32'b00000000000000000010000000000000),
    .FM1(32'b00000000000000000001111111111111),
    .GSR("DISABLE"),
    .MODE("FIFO8K"),
    .REGMODE_A("NOREG"),
    .REGMODE_B("NOREG"),
    .RESETMODE("ASYNC"))
    logic_fifo_5 (
    .clkr(clkr),
    .clkw(clkw),
    .csr({2'b11,empty_flag_neg}),
    .csw({2'b11,full_flag_neg}),
    .dia({open_n230,open_n231,open_n232,open_n233,open_n234,open_n235,open_n236,di[5],open_n237}),
    .orea(1'b0),
    .oreb(1'b0),
    .re(re),
    .rprst(rst),
    .rst(rst),
    .we(we),
    .dob({open_n258,open_n259,open_n260,open_n261,open_n262,open_n263,open_n264,do[5],do[13]}));
  EG_PHY_FIFO #(
    .AE(32'b00000000000000000000000000001101),
    .AEP1(32'b00000000000000000000000000001111),
    .AF(32'b00000000000000000001111111111010),
    .AFM1(32'b00000000000000000001111111111001),
    .ASYNC_RESET_RELEASE("SYNC"),
    .DATA_WIDTH_A("1"),
    .DATA_WIDTH_B("2"),
    .E(32'b00000000000000000000000000000001),
    .EP1(32'b00000000000000000000000000000011),
    .F(32'b00000000000000000010000000000000),
    .FM1(32'b00000000000000000001111111111111),
    .GSR("DISABLE"),
    .MODE("FIFO8K"),
    .REGMODE_A("NOREG"),
    .REGMODE_B("NOREG"),
    .RESETMODE("ASYNC"))
    logic_fifo_6 (
    .clkr(clkr),
    .clkw(clkw),
    .csr({2'b11,empty_flag_neg}),
    .csw({2'b11,full_flag_neg}),
    .dia({open_n267,open_n268,open_n269,open_n270,open_n271,open_n272,open_n273,di[6],open_n274}),
    .orea(1'b0),
    .oreb(1'b0),
    .re(re),
    .rprst(rst),
    .rst(rst),
    .we(we),
    .dob({open_n295,open_n296,open_n297,open_n298,open_n299,open_n300,open_n301,do[6],do[14]}));
  EG_PHY_FIFO #(
    .AE(32'b00000000000000000000000000001101),
    .AEP1(32'b00000000000000000000000000001111),
    .AF(32'b00000000000000000001111111111010),
    .AFM1(32'b00000000000000000001111111111001),
    .ASYNC_RESET_RELEASE("SYNC"),
    .DATA_WIDTH_A("1"),
    .DATA_WIDTH_B("2"),
    .E(32'b00000000000000000000000000000001),
    .EP1(32'b00000000000000000000000000000011),
    .F(32'b00000000000000000010000000000000),
    .FM1(32'b00000000000000000001111111111111),
    .GSR("DISABLE"),
    .MODE("FIFO8K"),
    .REGMODE_A("NOREG"),
    .REGMODE_B("NOREG"),
    .RESETMODE("ASYNC"))
    logic_fifo_7 (
    .clkr(clkr),
    .clkw(clkw),
    .csr({2'b11,empty_flag_neg}),
    .csw({2'b11,full_flag_neg}),
    .dia({open_n304,open_n305,open_n306,open_n307,open_n308,open_n309,open_n310,di[7],open_n311}),
    .orea(1'b0),
    .oreb(1'b0),
    .re(re),
    .rprst(rst),
    .rst(rst),
    .we(we),
    .dob({open_n332,open_n333,open_n334,open_n335,open_n336,open_n337,open_n338,do[7],do[15]}));

endmodule 

