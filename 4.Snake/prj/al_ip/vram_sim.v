// Verilog netlist created by TD v4.2.511
// Sat Oct 20 16:08:12 2018

`timescale 1ns / 1ps
module vram  // C:/Users/Thomas/Documents/Tang_FPGA_Examples/4.Snake/prj/al_ip/vram.v(14)
  (
  di,
  raddr,
  waddr,
  wclk,
  we,
  do
  );

  input [3:0] di;  // C:/Users/Thomas/Documents/Tang_FPGA_Examples/4.Snake/prj/al_ip/vram.v(23)
  input [7:0] raddr;  // C:/Users/Thomas/Documents/Tang_FPGA_Examples/4.Snake/prj/al_ip/vram.v(25)
  input [7:0] waddr;  // C:/Users/Thomas/Documents/Tang_FPGA_Examples/4.Snake/prj/al_ip/vram.v(24)
  input wclk;  // C:/Users/Thomas/Documents/Tang_FPGA_Examples/4.Snake/prj/al_ip/vram.v(26)
  input we;  // C:/Users/Thomas/Documents/Tang_FPGA_Examples/4.Snake/prj/al_ip/vram.v(26)
  output [3:0] do;  // C:/Users/Thomas/Documents/Tang_FPGA_Examples/4.Snake/prj/al_ip/vram.v(28)

  parameter ADDR_WIDTH_R = 8;
  parameter ADDR_WIDTH_W = 8;
  parameter DATA_DEPTH_R = 256;
  parameter DATA_DEPTH_W = 256;
  parameter DATA_WIDTH_R = 4;
  parameter DATA_WIDTH_W = 4;
  wire  \dram_do_mux_b0/B0_0 ;
  wire  \dram_do_mux_b0/B0_1 ;
  wire  \dram_do_mux_b0/B0_2 ;
  wire  \dram_do_mux_b0/B0_3 ;
  wire  \dram_do_mux_b0/B0_4 ;
  wire  \dram_do_mux_b0/B0_5 ;
  wire  \dram_do_mux_b0/B0_6 ;
  wire  \dram_do_mux_b0/B0_7 ;
  wire  \dram_do_mux_b0/B1_0 ;
  wire  \dram_do_mux_b0/B1_1 ;
  wire  \dram_do_mux_b0/B1_2 ;
  wire  \dram_do_mux_b0/B1_3 ;
  wire  \dram_do_mux_b0/B2_0 ;
  wire  \dram_do_mux_b0/B2_1 ;
  wire  \dram_do_mux_b1/B0_0 ;
  wire  \dram_do_mux_b1/B0_1 ;
  wire  \dram_do_mux_b1/B0_2 ;
  wire  \dram_do_mux_b1/B0_3 ;
  wire  \dram_do_mux_b1/B0_4 ;
  wire  \dram_do_mux_b1/B0_5 ;
  wire  \dram_do_mux_b1/B0_6 ;
  wire  \dram_do_mux_b1/B0_7 ;
  wire  \dram_do_mux_b1/B1_0 ;
  wire  \dram_do_mux_b1/B1_1 ;
  wire  \dram_do_mux_b1/B1_2 ;
  wire  \dram_do_mux_b1/B1_3 ;
  wire  \dram_do_mux_b1/B2_0 ;
  wire  \dram_do_mux_b1/B2_1 ;
  wire  \dram_do_mux_b2/B0_0 ;
  wire  \dram_do_mux_b2/B0_1 ;
  wire  \dram_do_mux_b2/B0_2 ;
  wire  \dram_do_mux_b2/B0_3 ;
  wire  \dram_do_mux_b2/B0_4 ;
  wire  \dram_do_mux_b2/B0_5 ;
  wire  \dram_do_mux_b2/B0_6 ;
  wire  \dram_do_mux_b2/B0_7 ;
  wire  \dram_do_mux_b2/B1_0 ;
  wire  \dram_do_mux_b2/B1_1 ;
  wire  \dram_do_mux_b2/B1_2 ;
  wire  \dram_do_mux_b2/B1_3 ;
  wire  \dram_do_mux_b2/B2_0 ;
  wire  \dram_do_mux_b2/B2_1 ;
  wire  \dram_do_mux_b3/B0_0 ;
  wire  \dram_do_mux_b3/B0_1 ;
  wire  \dram_do_mux_b3/B0_2 ;
  wire  \dram_do_mux_b3/B0_3 ;
  wire  \dram_do_mux_b3/B0_4 ;
  wire  \dram_do_mux_b3/B0_5 ;
  wire  \dram_do_mux_b3/B0_6 ;
  wire  \dram_do_mux_b3/B0_7 ;
  wire  \dram_do_mux_b3/B1_0 ;
  wire  \dram_do_mux_b3/B1_1 ;
  wire  \dram_do_mux_b3/B1_2 ;
  wire  \dram_do_mux_b3/B1_3 ;
  wire  \dram_do_mux_b3/B2_0 ;
  wire  \dram_do_mux_b3/B2_1 ;
  wire dram_do_i0_000;
  wire dram_do_i0_001;
  wire dram_do_i0_002;
  wire dram_do_i0_003;
  wire dram_do_i10_000;
  wire dram_do_i10_001;
  wire dram_do_i10_002;
  wire dram_do_i10_003;
  wire dram_do_i11_000;
  wire dram_do_i11_001;
  wire dram_do_i11_002;
  wire dram_do_i11_003;
  wire dram_do_i12_000;
  wire dram_do_i12_001;
  wire dram_do_i12_002;
  wire dram_do_i12_003;
  wire dram_do_i13_000;
  wire dram_do_i13_001;
  wire dram_do_i13_002;
  wire dram_do_i13_003;
  wire dram_do_i14_000;
  wire dram_do_i14_001;
  wire dram_do_i14_002;
  wire dram_do_i14_003;
  wire dram_do_i15_000;
  wire dram_do_i15_001;
  wire dram_do_i15_002;
  wire dram_do_i15_003;
  wire dram_do_i1_000;
  wire dram_do_i1_001;
  wire dram_do_i1_002;
  wire dram_do_i1_003;
  wire dram_do_i2_000;
  wire dram_do_i2_001;
  wire dram_do_i2_002;
  wire dram_do_i2_003;
  wire dram_do_i3_000;
  wire dram_do_i3_001;
  wire dram_do_i3_002;
  wire dram_do_i3_003;
  wire dram_do_i4_000;
  wire dram_do_i4_001;
  wire dram_do_i4_002;
  wire dram_do_i4_003;
  wire dram_do_i5_000;
  wire dram_do_i5_001;
  wire dram_do_i5_002;
  wire dram_do_i5_003;
  wire dram_do_i6_000;
  wire dram_do_i6_001;
  wire dram_do_i6_002;
  wire dram_do_i6_003;
  wire dram_do_i7_000;
  wire dram_do_i7_001;
  wire dram_do_i7_002;
  wire dram_do_i7_003;
  wire dram_do_i8_000;
  wire dram_do_i8_001;
  wire dram_do_i8_002;
  wire dram_do_i8_003;
  wire dram_do_i9_000;
  wire dram_do_i9_001;
  wire dram_do_i9_002;
  wire dram_do_i9_003;
  wire waddr$4$_neg;
  wire waddr$5$_neg;
  wire waddr$6$_neg;
  wire waddr$7$_neg;
  wire we_0;
  wire we_0_0;
  wire we_0_0_0;
  wire we_0_0_0_0;
  wire we_0_0_0_1;
  wire we_0_0_1;
  wire we_0_0_1_0;
  wire we_0_0_1_1;
  wire we_0_1;
  wire we_0_1_0;
  wire we_0_1_0_0;
  wire we_0_1_0_1;
  wire we_0_1_1;
  wire we_0_1_1_0;
  wire we_0_1_1_1;
  wire we_1;
  wire we_1_0;
  wire we_1_0_0;
  wire we_1_0_0_0;
  wire we_1_0_0_1;
  wire we_1_0_1;
  wire we_1_0_1_0;
  wire we_1_0_1_1;
  wire we_1_1;
  wire we_1_1_0;
  wire we_1_1_0_0;
  wire we_1_1_0_1;
  wire we_1_1_1;
  wire we_1_1_1_0;
  wire we_1_1_1_1;

  EG_PHY_CONFIG #(
    .DONE_PERSISTN("ENABLE"),
    .INIT_PERSISTN("ENABLE"),
    .JTAG_PERSISTN("DISABLE"),
    .PROGRAMN_PERSISTN("DISABLE"))
    config_inst ();
  AL_MUX \dram_do_mux_b0/al_mux_b0_0_0  (
    .i0(dram_do_i0_000),
    .i1(dram_do_i1_000),
    .sel(raddr[4]),
    .o(\dram_do_mux_b0/B0_0 ));
  AL_MUX \dram_do_mux_b0/al_mux_b0_0_1  (
    .i0(dram_do_i2_000),
    .i1(dram_do_i3_000),
    .sel(raddr[4]),
    .o(\dram_do_mux_b0/B0_1 ));
  AL_MUX \dram_do_mux_b0/al_mux_b0_0_2  (
    .i0(dram_do_i4_000),
    .i1(dram_do_i5_000),
    .sel(raddr[4]),
    .o(\dram_do_mux_b0/B0_2 ));
  AL_MUX \dram_do_mux_b0/al_mux_b0_0_3  (
    .i0(dram_do_i6_000),
    .i1(dram_do_i7_000),
    .sel(raddr[4]),
    .o(\dram_do_mux_b0/B0_3 ));
  AL_MUX \dram_do_mux_b0/al_mux_b0_0_4  (
    .i0(dram_do_i8_000),
    .i1(dram_do_i9_000),
    .sel(raddr[4]),
    .o(\dram_do_mux_b0/B0_4 ));
  AL_MUX \dram_do_mux_b0/al_mux_b0_0_5  (
    .i0(dram_do_i10_000),
    .i1(dram_do_i11_000),
    .sel(raddr[4]),
    .o(\dram_do_mux_b0/B0_5 ));
  AL_MUX \dram_do_mux_b0/al_mux_b0_0_6  (
    .i0(dram_do_i12_000),
    .i1(dram_do_i13_000),
    .sel(raddr[4]),
    .o(\dram_do_mux_b0/B0_6 ));
  AL_MUX \dram_do_mux_b0/al_mux_b0_0_7  (
    .i0(dram_do_i14_000),
    .i1(dram_do_i15_000),
    .sel(raddr[4]),
    .o(\dram_do_mux_b0/B0_7 ));
  AL_MUX \dram_do_mux_b0/al_mux_b0_1_0  (
    .i0(\dram_do_mux_b0/B0_0 ),
    .i1(\dram_do_mux_b0/B0_1 ),
    .sel(raddr[5]),
    .o(\dram_do_mux_b0/B1_0 ));
  AL_MUX \dram_do_mux_b0/al_mux_b0_1_1  (
    .i0(\dram_do_mux_b0/B0_2 ),
    .i1(\dram_do_mux_b0/B0_3 ),
    .sel(raddr[5]),
    .o(\dram_do_mux_b0/B1_1 ));
  AL_MUX \dram_do_mux_b0/al_mux_b0_1_2  (
    .i0(\dram_do_mux_b0/B0_4 ),
    .i1(\dram_do_mux_b0/B0_5 ),
    .sel(raddr[5]),
    .o(\dram_do_mux_b0/B1_2 ));
  AL_MUX \dram_do_mux_b0/al_mux_b0_1_3  (
    .i0(\dram_do_mux_b0/B0_6 ),
    .i1(\dram_do_mux_b0/B0_7 ),
    .sel(raddr[5]),
    .o(\dram_do_mux_b0/B1_3 ));
  AL_MUX \dram_do_mux_b0/al_mux_b0_2_0  (
    .i0(\dram_do_mux_b0/B1_0 ),
    .i1(\dram_do_mux_b0/B1_1 ),
    .sel(raddr[6]),
    .o(\dram_do_mux_b0/B2_0 ));
  AL_MUX \dram_do_mux_b0/al_mux_b0_2_1  (
    .i0(\dram_do_mux_b0/B1_2 ),
    .i1(\dram_do_mux_b0/B1_3 ),
    .sel(raddr[6]),
    .o(\dram_do_mux_b0/B2_1 ));
  AL_MUX \dram_do_mux_b0/al_mux_b0_3_0  (
    .i0(\dram_do_mux_b0/B2_0 ),
    .i1(\dram_do_mux_b0/B2_1 ),
    .sel(raddr[7]),
    .o(do[0]));
  AL_MUX \dram_do_mux_b1/al_mux_b0_0_0  (
    .i0(dram_do_i0_001),
    .i1(dram_do_i1_001),
    .sel(raddr[4]),
    .o(\dram_do_mux_b1/B0_0 ));
  AL_MUX \dram_do_mux_b1/al_mux_b0_0_1  (
    .i0(dram_do_i2_001),
    .i1(dram_do_i3_001),
    .sel(raddr[4]),
    .o(\dram_do_mux_b1/B0_1 ));
  AL_MUX \dram_do_mux_b1/al_mux_b0_0_2  (
    .i0(dram_do_i4_001),
    .i1(dram_do_i5_001),
    .sel(raddr[4]),
    .o(\dram_do_mux_b1/B0_2 ));
  AL_MUX \dram_do_mux_b1/al_mux_b0_0_3  (
    .i0(dram_do_i6_001),
    .i1(dram_do_i7_001),
    .sel(raddr[4]),
    .o(\dram_do_mux_b1/B0_3 ));
  AL_MUX \dram_do_mux_b1/al_mux_b0_0_4  (
    .i0(dram_do_i8_001),
    .i1(dram_do_i9_001),
    .sel(raddr[4]),
    .o(\dram_do_mux_b1/B0_4 ));
  AL_MUX \dram_do_mux_b1/al_mux_b0_0_5  (
    .i0(dram_do_i10_001),
    .i1(dram_do_i11_001),
    .sel(raddr[4]),
    .o(\dram_do_mux_b1/B0_5 ));
  AL_MUX \dram_do_mux_b1/al_mux_b0_0_6  (
    .i0(dram_do_i12_001),
    .i1(dram_do_i13_001),
    .sel(raddr[4]),
    .o(\dram_do_mux_b1/B0_6 ));
  AL_MUX \dram_do_mux_b1/al_mux_b0_0_7  (
    .i0(dram_do_i14_001),
    .i1(dram_do_i15_001),
    .sel(raddr[4]),
    .o(\dram_do_mux_b1/B0_7 ));
  AL_MUX \dram_do_mux_b1/al_mux_b0_1_0  (
    .i0(\dram_do_mux_b1/B0_0 ),
    .i1(\dram_do_mux_b1/B0_1 ),
    .sel(raddr[5]),
    .o(\dram_do_mux_b1/B1_0 ));
  AL_MUX \dram_do_mux_b1/al_mux_b0_1_1  (
    .i0(\dram_do_mux_b1/B0_2 ),
    .i1(\dram_do_mux_b1/B0_3 ),
    .sel(raddr[5]),
    .o(\dram_do_mux_b1/B1_1 ));
  AL_MUX \dram_do_mux_b1/al_mux_b0_1_2  (
    .i0(\dram_do_mux_b1/B0_4 ),
    .i1(\dram_do_mux_b1/B0_5 ),
    .sel(raddr[5]),
    .o(\dram_do_mux_b1/B1_2 ));
  AL_MUX \dram_do_mux_b1/al_mux_b0_1_3  (
    .i0(\dram_do_mux_b1/B0_6 ),
    .i1(\dram_do_mux_b1/B0_7 ),
    .sel(raddr[5]),
    .o(\dram_do_mux_b1/B1_3 ));
  AL_MUX \dram_do_mux_b1/al_mux_b0_2_0  (
    .i0(\dram_do_mux_b1/B1_0 ),
    .i1(\dram_do_mux_b1/B1_1 ),
    .sel(raddr[6]),
    .o(\dram_do_mux_b1/B2_0 ));
  AL_MUX \dram_do_mux_b1/al_mux_b0_2_1  (
    .i0(\dram_do_mux_b1/B1_2 ),
    .i1(\dram_do_mux_b1/B1_3 ),
    .sel(raddr[6]),
    .o(\dram_do_mux_b1/B2_1 ));
  AL_MUX \dram_do_mux_b1/al_mux_b0_3_0  (
    .i0(\dram_do_mux_b1/B2_0 ),
    .i1(\dram_do_mux_b1/B2_1 ),
    .sel(raddr[7]),
    .o(do[1]));
  AL_MUX \dram_do_mux_b2/al_mux_b0_0_0  (
    .i0(dram_do_i0_002),
    .i1(dram_do_i1_002),
    .sel(raddr[4]),
    .o(\dram_do_mux_b2/B0_0 ));
  AL_MUX \dram_do_mux_b2/al_mux_b0_0_1  (
    .i0(dram_do_i2_002),
    .i1(dram_do_i3_002),
    .sel(raddr[4]),
    .o(\dram_do_mux_b2/B0_1 ));
  AL_MUX \dram_do_mux_b2/al_mux_b0_0_2  (
    .i0(dram_do_i4_002),
    .i1(dram_do_i5_002),
    .sel(raddr[4]),
    .o(\dram_do_mux_b2/B0_2 ));
  AL_MUX \dram_do_mux_b2/al_mux_b0_0_3  (
    .i0(dram_do_i6_002),
    .i1(dram_do_i7_002),
    .sel(raddr[4]),
    .o(\dram_do_mux_b2/B0_3 ));
  AL_MUX \dram_do_mux_b2/al_mux_b0_0_4  (
    .i0(dram_do_i8_002),
    .i1(dram_do_i9_002),
    .sel(raddr[4]),
    .o(\dram_do_mux_b2/B0_4 ));
  AL_MUX \dram_do_mux_b2/al_mux_b0_0_5  (
    .i0(dram_do_i10_002),
    .i1(dram_do_i11_002),
    .sel(raddr[4]),
    .o(\dram_do_mux_b2/B0_5 ));
  AL_MUX \dram_do_mux_b2/al_mux_b0_0_6  (
    .i0(dram_do_i12_002),
    .i1(dram_do_i13_002),
    .sel(raddr[4]),
    .o(\dram_do_mux_b2/B0_6 ));
  AL_MUX \dram_do_mux_b2/al_mux_b0_0_7  (
    .i0(dram_do_i14_002),
    .i1(dram_do_i15_002),
    .sel(raddr[4]),
    .o(\dram_do_mux_b2/B0_7 ));
  AL_MUX \dram_do_mux_b2/al_mux_b0_1_0  (
    .i0(\dram_do_mux_b2/B0_0 ),
    .i1(\dram_do_mux_b2/B0_1 ),
    .sel(raddr[5]),
    .o(\dram_do_mux_b2/B1_0 ));
  AL_MUX \dram_do_mux_b2/al_mux_b0_1_1  (
    .i0(\dram_do_mux_b2/B0_2 ),
    .i1(\dram_do_mux_b2/B0_3 ),
    .sel(raddr[5]),
    .o(\dram_do_mux_b2/B1_1 ));
  AL_MUX \dram_do_mux_b2/al_mux_b0_1_2  (
    .i0(\dram_do_mux_b2/B0_4 ),
    .i1(\dram_do_mux_b2/B0_5 ),
    .sel(raddr[5]),
    .o(\dram_do_mux_b2/B1_2 ));
  AL_MUX \dram_do_mux_b2/al_mux_b0_1_3  (
    .i0(\dram_do_mux_b2/B0_6 ),
    .i1(\dram_do_mux_b2/B0_7 ),
    .sel(raddr[5]),
    .o(\dram_do_mux_b2/B1_3 ));
  AL_MUX \dram_do_mux_b2/al_mux_b0_2_0  (
    .i0(\dram_do_mux_b2/B1_0 ),
    .i1(\dram_do_mux_b2/B1_1 ),
    .sel(raddr[6]),
    .o(\dram_do_mux_b2/B2_0 ));
  AL_MUX \dram_do_mux_b2/al_mux_b0_2_1  (
    .i0(\dram_do_mux_b2/B1_2 ),
    .i1(\dram_do_mux_b2/B1_3 ),
    .sel(raddr[6]),
    .o(\dram_do_mux_b2/B2_1 ));
  AL_MUX \dram_do_mux_b2/al_mux_b0_3_0  (
    .i0(\dram_do_mux_b2/B2_0 ),
    .i1(\dram_do_mux_b2/B2_1 ),
    .sel(raddr[7]),
    .o(do[2]));
  AL_MUX \dram_do_mux_b3/al_mux_b0_0_0  (
    .i0(dram_do_i0_003),
    .i1(dram_do_i1_003),
    .sel(raddr[4]),
    .o(\dram_do_mux_b3/B0_0 ));
  AL_MUX \dram_do_mux_b3/al_mux_b0_0_1  (
    .i0(dram_do_i2_003),
    .i1(dram_do_i3_003),
    .sel(raddr[4]),
    .o(\dram_do_mux_b3/B0_1 ));
  AL_MUX \dram_do_mux_b3/al_mux_b0_0_2  (
    .i0(dram_do_i4_003),
    .i1(dram_do_i5_003),
    .sel(raddr[4]),
    .o(\dram_do_mux_b3/B0_2 ));
  AL_MUX \dram_do_mux_b3/al_mux_b0_0_3  (
    .i0(dram_do_i6_003),
    .i1(dram_do_i7_003),
    .sel(raddr[4]),
    .o(\dram_do_mux_b3/B0_3 ));
  AL_MUX \dram_do_mux_b3/al_mux_b0_0_4  (
    .i0(dram_do_i8_003),
    .i1(dram_do_i9_003),
    .sel(raddr[4]),
    .o(\dram_do_mux_b3/B0_4 ));
  AL_MUX \dram_do_mux_b3/al_mux_b0_0_5  (
    .i0(dram_do_i10_003),
    .i1(dram_do_i11_003),
    .sel(raddr[4]),
    .o(\dram_do_mux_b3/B0_5 ));
  AL_MUX \dram_do_mux_b3/al_mux_b0_0_6  (
    .i0(dram_do_i12_003),
    .i1(dram_do_i13_003),
    .sel(raddr[4]),
    .o(\dram_do_mux_b3/B0_6 ));
  AL_MUX \dram_do_mux_b3/al_mux_b0_0_7  (
    .i0(dram_do_i14_003),
    .i1(dram_do_i15_003),
    .sel(raddr[4]),
    .o(\dram_do_mux_b3/B0_7 ));
  AL_MUX \dram_do_mux_b3/al_mux_b0_1_0  (
    .i0(\dram_do_mux_b3/B0_0 ),
    .i1(\dram_do_mux_b3/B0_1 ),
    .sel(raddr[5]),
    .o(\dram_do_mux_b3/B1_0 ));
  AL_MUX \dram_do_mux_b3/al_mux_b0_1_1  (
    .i0(\dram_do_mux_b3/B0_2 ),
    .i1(\dram_do_mux_b3/B0_3 ),
    .sel(raddr[5]),
    .o(\dram_do_mux_b3/B1_1 ));
  AL_MUX \dram_do_mux_b3/al_mux_b0_1_2  (
    .i0(\dram_do_mux_b3/B0_4 ),
    .i1(\dram_do_mux_b3/B0_5 ),
    .sel(raddr[5]),
    .o(\dram_do_mux_b3/B1_2 ));
  AL_MUX \dram_do_mux_b3/al_mux_b0_1_3  (
    .i0(\dram_do_mux_b3/B0_6 ),
    .i1(\dram_do_mux_b3/B0_7 ),
    .sel(raddr[5]),
    .o(\dram_do_mux_b3/B1_3 ));
  AL_MUX \dram_do_mux_b3/al_mux_b0_2_0  (
    .i0(\dram_do_mux_b3/B1_0 ),
    .i1(\dram_do_mux_b3/B1_1 ),
    .sel(raddr[6]),
    .o(\dram_do_mux_b3/B2_0 ));
  AL_MUX \dram_do_mux_b3/al_mux_b0_2_1  (
    .i0(\dram_do_mux_b3/B1_2 ),
    .i1(\dram_do_mux_b3/B1_3 ),
    .sel(raddr[6]),
    .o(\dram_do_mux_b3/B2_1 ));
  AL_MUX \dram_do_mux_b3/al_mux_b0_3_0  (
    .i0(\dram_do_mux_b3/B2_0 ),
    .i1(\dram_do_mux_b3/B2_1 ),
    .sel(raddr[7]),
    .o(do[3]));
  EG_LOGIC_DRAM16X4 dram_r0_c0 (
    .di(di),
    .raddr(raddr[3:0]),
    .waddr(waddr[3:0]),
    .wclk(wclk),
    .we(we_0_0_0_0),
    .do({dram_do_i0_003,dram_do_i0_002,dram_do_i0_001,dram_do_i0_000}));
  EG_LOGIC_DRAM16X4 dram_r10_c0 (
    .di(di),
    .raddr(raddr[3:0]),
    .waddr(waddr[3:0]),
    .wclk(wclk),
    .we(we_1_0_1_0),
    .do({dram_do_i10_003,dram_do_i10_002,dram_do_i10_001,dram_do_i10_000}));
  EG_LOGIC_DRAM16X4 dram_r11_c0 (
    .di(di),
    .raddr(raddr[3:0]),
    .waddr(waddr[3:0]),
    .wclk(wclk),
    .we(we_1_0_1_1),
    .do({dram_do_i11_003,dram_do_i11_002,dram_do_i11_001,dram_do_i11_000}));
  EG_LOGIC_DRAM16X4 dram_r12_c0 (
    .di(di),
    .raddr(raddr[3:0]),
    .waddr(waddr[3:0]),
    .wclk(wclk),
    .we(we_1_1_0_0),
    .do({dram_do_i12_003,dram_do_i12_002,dram_do_i12_001,dram_do_i12_000}));
  EG_LOGIC_DRAM16X4 dram_r13_c0 (
    .di(di),
    .raddr(raddr[3:0]),
    .waddr(waddr[3:0]),
    .wclk(wclk),
    .we(we_1_1_0_1),
    .do({dram_do_i13_003,dram_do_i13_002,dram_do_i13_001,dram_do_i13_000}));
  EG_LOGIC_DRAM16X4 dram_r14_c0 (
    .di(di),
    .raddr(raddr[3:0]),
    .waddr(waddr[3:0]),
    .wclk(wclk),
    .we(we_1_1_1_0),
    .do({dram_do_i14_003,dram_do_i14_002,dram_do_i14_001,dram_do_i14_000}));
  EG_LOGIC_DRAM16X4 dram_r15_c0 (
    .di(di),
    .raddr(raddr[3:0]),
    .waddr(waddr[3:0]),
    .wclk(wclk),
    .we(we_1_1_1_1),
    .do({dram_do_i15_003,dram_do_i15_002,dram_do_i15_001,dram_do_i15_000}));
  EG_LOGIC_DRAM16X4 dram_r1_c0 (
    .di(di),
    .raddr(raddr[3:0]),
    .waddr(waddr[3:0]),
    .wclk(wclk),
    .we(we_0_0_0_1),
    .do({dram_do_i1_003,dram_do_i1_002,dram_do_i1_001,dram_do_i1_000}));
  EG_LOGIC_DRAM16X4 dram_r2_c0 (
    .di(di),
    .raddr(raddr[3:0]),
    .waddr(waddr[3:0]),
    .wclk(wclk),
    .we(we_0_0_1_0),
    .do({dram_do_i2_003,dram_do_i2_002,dram_do_i2_001,dram_do_i2_000}));
  EG_LOGIC_DRAM16X4 dram_r3_c0 (
    .di(di),
    .raddr(raddr[3:0]),
    .waddr(waddr[3:0]),
    .wclk(wclk),
    .we(we_0_0_1_1),
    .do({dram_do_i3_003,dram_do_i3_002,dram_do_i3_001,dram_do_i3_000}));
  EG_LOGIC_DRAM16X4 dram_r4_c0 (
    .di(di),
    .raddr(raddr[3:0]),
    .waddr(waddr[3:0]),
    .wclk(wclk),
    .we(we_0_1_0_0),
    .do({dram_do_i4_003,dram_do_i4_002,dram_do_i4_001,dram_do_i4_000}));
  EG_LOGIC_DRAM16X4 dram_r5_c0 (
    .di(di),
    .raddr(raddr[3:0]),
    .waddr(waddr[3:0]),
    .wclk(wclk),
    .we(we_0_1_0_1),
    .do({dram_do_i5_003,dram_do_i5_002,dram_do_i5_001,dram_do_i5_000}));
  EG_LOGIC_DRAM16X4 dram_r6_c0 (
    .di(di),
    .raddr(raddr[3:0]),
    .waddr(waddr[3:0]),
    .wclk(wclk),
    .we(we_0_1_1_0),
    .do({dram_do_i6_003,dram_do_i6_002,dram_do_i6_001,dram_do_i6_000}));
  EG_LOGIC_DRAM16X4 dram_r7_c0 (
    .di(di),
    .raddr(raddr[3:0]),
    .waddr(waddr[3:0]),
    .wclk(wclk),
    .we(we_0_1_1_1),
    .do({dram_do_i7_003,dram_do_i7_002,dram_do_i7_001,dram_do_i7_000}));
  EG_LOGIC_DRAM16X4 dram_r8_c0 (
    .di(di),
    .raddr(raddr[3:0]),
    .waddr(waddr[3:0]),
    .wclk(wclk),
    .we(we_1_0_0_0),
    .do({dram_do_i8_003,dram_do_i8_002,dram_do_i8_001,dram_do_i8_000}));
  EG_LOGIC_DRAM16X4 dram_r9_c0 (
    .di(di),
    .raddr(raddr[3:0]),
    .waddr(waddr[3:0]),
    .wclk(wclk),
    .we(we_1_0_0_1),
    .do({dram_do_i9_003,dram_do_i9_002,dram_do_i9_001,dram_do_i9_000}));
  not \waddr[4]_inv  (waddr$4$_neg, waddr[4]);
  not \waddr[5]_inv  (waddr$5$_neg, waddr[5]);
  not \waddr[6]_inv  (waddr$6$_neg, waddr[6]);
  not \waddr[7]_inv  (waddr$7$_neg, waddr[7]);
  and we_0_0_0_0i (we_0_0_0_0, we_0_0_0, waddr$4$_neg);
  and we_0_0_0_1i (we_0_0_0_1, we_0_0_0, waddr[4]);
  and we_0_0_0i (we_0_0_0, we_0_0, waddr$5$_neg);
  and we_0_0_1_0i (we_0_0_1_0, we_0_0_1, waddr$4$_neg);
  and we_0_0_1_1i (we_0_0_1_1, we_0_0_1, waddr[4]);
  and we_0_0_1i (we_0_0_1, we_0_0, waddr[5]);
  and we_0_0i (we_0_0, we_0, waddr$6$_neg);
  and we_0_1_0_0i (we_0_1_0_0, we_0_1_0, waddr$4$_neg);
  and we_0_1_0_1i (we_0_1_0_1, we_0_1_0, waddr[4]);
  and we_0_1_0i (we_0_1_0, we_0_1, waddr$5$_neg);
  and we_0_1_1_0i (we_0_1_1_0, we_0_1_1, waddr$4$_neg);
  and we_0_1_1_1i (we_0_1_1_1, we_0_1_1, waddr[4]);
  and we_0_1_1i (we_0_1_1, we_0_1, waddr[5]);
  and we_0_1i (we_0_1, we_0, waddr[6]);
  and we_0i (we_0, we, waddr$7$_neg);
  and we_1_0_0_0i (we_1_0_0_0, we_1_0_0, waddr$4$_neg);
  and we_1_0_0_1i (we_1_0_0_1, we_1_0_0, waddr[4]);
  and we_1_0_0i (we_1_0_0, we_1_0, waddr$5$_neg);
  and we_1_0_1_0i (we_1_0_1_0, we_1_0_1, waddr$4$_neg);
  and we_1_0_1_1i (we_1_0_1_1, we_1_0_1, waddr[4]);
  and we_1_0_1i (we_1_0_1, we_1_0, waddr[5]);
  and we_1_0i (we_1_0, we_1, waddr$6$_neg);
  and we_1_1_0_0i (we_1_1_0_0, we_1_1_0, waddr$4$_neg);
  and we_1_1_0_1i (we_1_1_0_1, we_1_1_0, waddr[4]);
  and we_1_1_0i (we_1_1_0, we_1_1, waddr$5$_neg);
  and we_1_1_1_0i (we_1_1_1_0, we_1_1_1, waddr$4$_neg);
  and we_1_1_1_1i (we_1_1_1_1, we_1_1_1, waddr[4]);
  and we_1_1_1i (we_1_1_1, we_1_1, waddr[5]);
  and we_1_1i (we_1_1, we_1, waddr[6]);
  and we_1i (we_1, we, waddr[7]);

endmodule 

module AL_MUX
  (
  input i0,
  input i1,
  input sel,
  output o
  );

  wire not_sel, sel_i0, sel_i1;
  not u0 (not_sel, sel);
  and u1 (sel_i1, sel, i1);
  and u2 (sel_i0, not_sel, i0);
  or u3 (o, sel_i1, sel_i0);

endmodule

