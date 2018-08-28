//////////////////////////////////////////////////////////////////////////////////
// OV7670_Registers.v
//
// Author:			Thanh Tien Truong
//
// Description:
// ------------
//  LUT containing all the registers address and values 
//                            
//////////////////////////////////////////////////////////////////////////////////
`include "global.h"

`ifndef SCCB_V1
module OV7670_Registers (
    input clk, 
    input resend, 
    input advance, 
    output [15:0] command, 
    output finished
);

    // Internal signals
    reg [15:0] sreg;
    reg finished_temp;
    reg [7:0] address = {8{1'b0}};
    
    // Assign values to outputs
    assign command = sreg; 
    assign finished = finished_temp;
    
    // When register and value is FFFF
    // a flag is asserted indicating the configuration is finished
    always @ (sreg) begin
        if(sreg == 16'hFFFF) begin
            finished_temp <= 1;
        end
        else begin
            finished_temp <= 0;
        end
    end
    
    // Get value out of the LUT
    always @ (posedge clk) begin
        if(resend == 0) begin           // reset the configuration
            address <= {8{1'b0}};
        end
        else if(advance == 1) begin     // Get the next value
            address <= address+1;
        end

        case (address) 

	0 : sreg <= 16'hff_01;
	1 : sreg <= 16'h12_80;
	2 : sreg <= 16'hff_00;
	3 : sreg <= 16'h2c_ff;
	4 : sreg <= 16'h2e_df;
	5 : sreg <= 16'hff_01;
	6 : sreg <= 16'h3c_32;
	7 : sreg <= 16'h11_00;
	8 : sreg <= 16'h09_02;
	9 : sreg <= 16'h04_d8;
	10 : sreg <= 16'h13_e5;
	11 : sreg <= 16'h14_48;
	12 : sreg <= 16'h2c_0c;
	13 : sreg <= 16'h33_78;
	14 : sreg <= 16'h3a_33;
	15 : sreg <= 16'h3b_fb;
	16 : sreg <= 16'h3e_00;
	17 : sreg <= 16'h43_11;
	18 : sreg <= 16'h16_10;
	19 : sreg <= 16'h39_92;
	20 : sreg <= 16'h35_da;
	21 : sreg <= 16'h22_1a;
	22 : sreg <= 16'h37_c3;
	23 : sreg <= 16'h23_00;
	24 : sreg <= 16'h34_c0;
	25 : sreg <= 16'h36_1a;
	26 : sreg <= 16'h06_88;
	27 : sreg <= 16'h07_c0;
	28 : sreg <= 16'h0d_87;
	29 : sreg <= 16'h0e_41;
	30 : sreg <= 16'h4c_00;
	31 : sreg <= 16'h48_00;
	32 : sreg <= 16'h5b_00;
	33 : sreg <= 16'h42_03;
	34 : sreg <= 16'h4a_81;
	35 : sreg <= 16'h21_99;
	36 : sreg <= 16'h24_40;
	37 : sreg <= 16'h25_38;
	38 : sreg <= 16'h26_82;
	39 : sreg <= 16'h5c_00;
	40 : sreg <= 16'h63_00;
	41 : sreg <= 16'h46_22;
	42 : sreg <= 16'h0c_3c;
	43 : sreg <= 16'h61_70;
	44 : sreg <= 16'h62_80;
	45 : sreg <= 16'h7c_05;
	46 : sreg <= 16'h20_80;
	47 : sreg <= 16'h28_30;
	48 : sreg <= 16'h6c_00;
	49 : sreg <= 16'h6d_80;
	50 : sreg <= 16'h6e_00;
	51 : sreg <= 16'h70_02;
	52 : sreg <= 16'h71_94;
	53 : sreg <= 16'h73_c1;
	54 : sreg <= 16'h3d_34;
	55 : sreg <= 16'h5a_57;
	56 : sreg <= 16'h12_40;
	57 : sreg <= 16'h17_11;
	58 : sreg <= 16'h18_43;
	59 : sreg <= 16'h19_00;
	60 : sreg <= 16'h1a_4b;
	61 : sreg <= 16'h32_09;
	62 : sreg <= 16'h37_c0;
	63 : sreg <= 16'h4f_ca;
	64 : sreg <= 16'h50_a8;
	65 : sreg <= 16'h5a_23;
	66 : sreg <= 16'h6d_00;
	67 : sreg <= 16'h3d_38;
	68 : sreg <= 16'hff_00;
	69 : sreg <= 16'he5_7f;
	70 : sreg <= 16'hf9_c0;
	71 : sreg <= 16'h41_24;
	72 : sreg <= 16'he0_14;
	73 : sreg <= 16'h76_ff;
	74 : sreg <= 16'h33_a0;
	75 : sreg <= 16'h42_20;
	76 : sreg <= 16'h43_18;
	77 : sreg <= 16'h4c_00;
	78 : sreg <= 16'h87_d5;
	79 : sreg <= 16'h88_3f;
	80 : sreg <= 16'hd7_03;
	81 : sreg <= 16'hd9_10;
	82 : sreg <= 16'hd3_82;
	83 : sreg <= 16'hc8_08;
	84 : sreg <= 16'hc9_80;
	85 : sreg <= 16'h7c_00;
	86 : sreg <= 16'h7d_00;
	87 : sreg <= 16'h7c_03;
	88 : sreg <= 16'h7d_48;
	89 : sreg <= 16'h7d_48;
	90 : sreg <= 16'h7c_08;
	91 : sreg <= 16'h7d_20;
	92 : sreg <= 16'h7d_10;
	93 : sreg <= 16'h7d_0e;
	94 : sreg <= 16'h90_00;
	95 : sreg <= 16'h91_0e;
	96 : sreg <= 16'h91_1a;
	97 : sreg <= 16'h91_31;
	98 : sreg <= 16'h91_5a;
	99 : sreg <= 16'h91_69;
	100 : sreg <= 16'h91_75;
	101 : sreg <= 16'h91_7e;
	102 : sreg <= 16'h91_88;
	103 : sreg <= 16'h91_8f;
	104 : sreg <= 16'h91_96;
	105 : sreg <= 16'h91_a3;
	106 : sreg <= 16'h91_af;
	107 : sreg <= 16'h91_c4;
	108 : sreg <= 16'h91_d7;
	109 : sreg <= 16'h91_e8;
	110 : sreg <= 16'h91_20;
	111 : sreg <= 16'h92_00;
	112 : sreg <= 16'h93_06;
	113 : sreg <= 16'h93_e3;
	114 : sreg <= 16'h93_05;
	115 : sreg <= 16'h93_05;
	116 : sreg <= 16'h93_00;
	117 : sreg <= 16'h93_04;
	118 : sreg <= 16'h93_00;
	119 : sreg <= 16'h93_00;
	120 : sreg <= 16'h93_00;
	121 : sreg <= 16'h93_00;
	122 : sreg <= 16'h93_00;
	123 : sreg <= 16'h93_00;
	124 : sreg <= 16'h93_00;
	125 : sreg <= 16'h96_00;
	126 : sreg <= 16'h97_08;
	127 : sreg <= 16'h97_19;
	128 : sreg <= 16'h97_02;
	129 : sreg <= 16'h97_0c;
	130 : sreg <= 16'h97_24;
	131 : sreg <= 16'h97_30;
	132 : sreg <= 16'h97_28;
	133 : sreg <= 16'h97_26;
	134 : sreg <= 16'h97_02;
	135 : sreg <= 16'h97_98;
	136 : sreg <= 16'h97_80;
	137 : sreg <= 16'h97_00;
	138 : sreg <= 16'h97_00;
	139 : sreg <= 16'hc3_ed;
	140 : sreg <= 16'ha4_00;
	141 : sreg <= 16'ha8_00;
	142 : sreg <= 16'hc5_11;
	143 : sreg <= 16'hc6_51;
	144 : sreg <= 16'hbf_80;
	145 : sreg <= 16'hc7_10;
	146 : sreg <= 16'hb6_66;
	147 : sreg <= 16'hb8_a5;
	148 : sreg <= 16'hb7_64;
	149 : sreg <= 16'hb9_7c;
	150 : sreg <= 16'hb3_af;
	151 : sreg <= 16'hb4_97;
	152 : sreg <= 16'hb5_ff;
	153 : sreg <= 16'hb0_c5;
	154 : sreg <= 16'hb1_94;
	155 : sreg <= 16'hb2_0f;
	156 : sreg <= 16'hc4_5c;
	157 : sreg <= 16'hc0_64;
	158 : sreg <= 16'hc1_4b;
	159 : sreg <= 16'h8c_00;
	160 : sreg <= 16'h86_3d;
	161 : sreg <= 16'h50_00;
	162 : sreg <= 16'h51_c8;
	163 : sreg <= 16'h52_96;
	164 : sreg <= 16'h53_00;
	165 : sreg <= 16'h54_00;
	166 : sreg <= 16'h55_00;
	167 : sreg <= 16'h5a_c8;
	168 : sreg <= 16'h5b_96;
	169 : sreg <= 16'h5c_00;
	170 : sreg <= 16'hd3_02;
	171 : sreg <= 16'hc3_ed;
	172 : sreg <= 16'h7f_00;
	173 : sreg <= 16'hda_09;
	174 : sreg <= 16'he5_1f;
	175 : sreg <= 16'he1_67;
	176 : sreg <= 16'he0_00;
	177 : sreg <= 16'hdd_7f;
	178 : sreg <= 16'h05_00;
	179 : sreg <= 16'hff_00;
	180 : sreg <= 16'hda_09;
	181 : sreg <= 16'hd7_03;
	182 : sreg <= 16'hdf_02;
	183 : sreg <= 16'h33_a0;
	184 : sreg <= 16'h3c_00;
	185 : sreg <= 16'he1_67;
	186 : sreg <= 16'hff_01;
	187 : sreg <= 16'he0_00;
	188 : sreg <= 16'he1_00;
	189 : sreg <= 16'he5_00;
	190 : sreg <= 16'hd7_00;
	191 : sreg <= 16'hda_00;
	192 : sreg <= 16'he0_00;
	193 : sreg <= 16'hff_00;
	194 : sreg <= 16'he0_04;
	195 : sreg <= 16'h5a_2d;
	196 : sreg <= 16'h5b_2d;
	197 : sreg <= 16'h5c_00;
	198 : sreg <= 16'he0_00;
//	199 : sreg <= 16'hff_01;
//	200 : sreg <= 16'h12_42;


        default : sreg <= 16'hFF_FF;    // End configuration
        endcase  
    end
endmodule
`endif