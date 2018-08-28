// Verilog netlist created by TD v4.2.217
// Fri Aug 10 17:39:33 2018

`timescale 1ns / 1ps
module ip_pll  // H:/Work/FPGA/AnLogic/LicheeTang/demo/test_lcd_camera/test_camera/project/al_ip/ip_pll.v(24)
  (
  refclk,
  clk0_out,
  clk1_out,
  clk2_out
  );

  input refclk;  // H:/Work/FPGA/AnLogic/LicheeTang/demo/test_lcd_camera/test_camera/project/al_ip/ip_pll.v(29)
  output clk0_out;  // H:/Work/FPGA/AnLogic/LicheeTang/demo/test_lcd_camera/test_camera/project/al_ip/ip_pll.v(30)
  output clk1_out;  // H:/Work/FPGA/AnLogic/LicheeTang/demo/test_lcd_camera/test_camera/project/al_ip/ip_pll.v(31)
  output clk2_out;  // H:/Work/FPGA/AnLogic/LicheeTang/demo/test_lcd_camera/test_camera/project/al_ip/ip_pll.v(32)

  wire clk0_buf;  // H:/Work/FPGA/AnLogic/LicheeTang/demo/test_lcd_camera/test_camera/project/al_ip/ip_pll.v(34)

  EG_PHY_GCLK bufg_feedback (
    .clki(clk0_buf),
    .clko(clk0_out));  // H:/Work/FPGA/AnLogic/LicheeTang/demo/test_lcd_camera/test_camera/project/al_ip/ip_pll.v(36)
  EG_PHY_CONFIG #(
    .DONE_PERSISTN("ENABLE"),
    .INIT_PERSISTN("ENABLE"),
    .JTAG_PERSISTN("DISABLE"),
    .PROGRAMN_PERSISTN("DISABLE"))
    config_inst ();
  EG_PHY_PLL #(
    .CLKC0_CPHASE(14),
    .CLKC0_DIV(14),
    .CLKC0_DIV2_ENABLE("DISABLE"),
    .CLKC0_ENABLE("ENABLE"),
    .CLKC0_FPHASE(0),
    .CLKC1_CPHASE(39),
    .CLKC1_DIV(39),
    .CLKC1_DIV2_ENABLE("DISABLE"),
    .CLKC1_ENABLE("ENABLE"),
    .CLKC1_FPHASE(0),
    .CLKC2_CPHASE(117),
    .CLKC2_DIV(117),
    .CLKC2_DIV2_ENABLE("DISABLE"),
    .CLKC2_ENABLE("ENABLE"),
    .CLKC2_FPHASE(0),
    .CLKC3_CPHASE(1),
    .CLKC3_DIV(1),
    .CLKC3_DIV2_ENABLE("DISABLE"),
    .CLKC3_ENABLE("DISABLE"),
    .CLKC3_FPHASE(0),
    .CLKC4_CPHASE(1),
    .CLKC4_DIV(1),
    .CLKC4_DIV2_ENABLE("DISABLE"),
    .CLKC4_ENABLE("DISABLE"),
    .CLKC4_FPHASE(0),
    .DERIVE_PLL_CLOCKS("DISABLE"),
    .DPHASE_SOURCE("DISABLE"),
    .DYNCFG("DISABLE"),
    .FBCLK_DIV(7),
    .FEEDBK_MODE("NORMAL"),
    .FEEDBK_PATH("CLKC0_EXT"),
    .FIN("24.000"),
    .FREQ_LOCK_ACCURACY(2),
    .GEN_BASIC_CLOCK("DISABLE"),
    .GMC_GAIN(6),
    .GMC_TEST(14),
    .ICP_CURRENT(3),
    .IF_ESCLKSTSW("DISABLE"),
    .INTFB_WAKE("DISABLE"),
    .KVCO(6),
    .LPF_CAPACITOR(3),
    .LPF_RESISTOR(2),
    .NORESET("DISABLE"),
    .ODIV_MUXC0("DIV"),
    .ODIV_MUXC1("DIV"),
    .ODIV_MUXC2("DIV"),
    .ODIV_MUXC3("DIV"),
    .ODIV_MUXC4("DIV"),
    .PLLC2RST_ENA("DISABLE"),
    .PLLC34RST_ENA("DISABLE"),
    .PLLMRST_ENA("DISABLE"),
    .PLLRST_ENA("DISABLE"),
    .PLL_LOCK_MODE(0),
    .PREDIV_MUXC0("VCO"),
    .PREDIV_MUXC1("VCO"),
    .PREDIV_MUXC2("VCO"),
    .PREDIV_MUXC3("VCO"),
    .PREDIV_MUXC4("VCO"),
    .REFCLK_DIV(5),
    .REFCLK_SEL("INTERNAL"),
    .STDBY_ENABLE("DISABLE"),
    .STDBY_VCO_ENA("DISABLE"),
    .SYNC_ENABLE("DISABLE"),
    .VCO_NORESET("DISABLE"))
    pll_inst (
    .daddr(6'b000000),
    .dclk(1'b0),
    .dcs(1'b0),
    .di(8'b00000000),
    .dwe(1'b0),
    .fbclk(clk0_out),
    .psclk(1'b0),
    .psclksel(3'b000),
    .psdown(1'b0),
    .psstep(1'b0),
    .refclk(refclk),
    .reset(1'b0),
    .stdby(1'b0),
    .clkc({open_n47,open_n48,clk2_out,clk1_out,clk0_buf}));  // H:/Work/FPGA/AnLogic/LicheeTang/demo/test_lcd_camera/test_camera/project/al_ip/ip_pll.v(83)

endmodule 

