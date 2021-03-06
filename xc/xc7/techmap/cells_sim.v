// ============================================================================
// Define FFs required by VPR
//
module CE_VCC (output VCC);
wire VCC = 1;
endmodule

module SR_GND (output GND);
wire GND = 0;
endmodule

module SYN_OBUF(input I, output O);
  assign O = I;
endmodule

module SYN_IBUF(input I, output O);
  assign O = I;
endmodule

module FDRE_ZINI (output reg Q, input C, CE, D, R);
  parameter [0:0] ZINI = 1'b0;
  parameter [0:0] IS_C_INVERTED = 1'b0;
  initial Q <= !ZINI;
  generate case (|IS_C_INVERTED)
    1'b0: always @(posedge C) if (R) Q <= 1'b0; else if (CE) Q <= D;
    1'b1: always @(negedge C) if (R) Q <= 1'b0; else if (CE) Q <= D;
  endcase endgenerate
endmodule

module FDSE_ZINI (output reg Q, input C, CE, D, S);
  parameter [0:0] ZINI = 1'b0;
  parameter [0:0] IS_C_INVERTED = 1'b0;
  initial Q <= !ZINI;
  generate case (|IS_C_INVERTED)
    1'b0: always @(posedge C) if (S) Q <= 1'b1; else if (CE) Q <= D;
    1'b1: always @(negedge C) if (S) Q <= 1'b1; else if (CE) Q <= D;
  endcase endgenerate
endmodule

module FDCE_ZINI (output reg Q, input C, CE, D, CLR);
  parameter [0:0] ZINI = 1'b0;
  parameter [0:0] IS_C_INVERTED = 1'b0;
  initial Q <= !ZINI;
  generate case (|IS_C_INVERTED)
    1'b0: always @(posedge C, posedge CLR) if (CLR) Q <= 1'b0; else if (CE) Q <= D;
    1'b1: always @(negedge C, posedge CLR) if (CLR) Q <= 1'b0; else if (CE) Q <= D;
  endcase endgenerate
endmodule

module FDPE_ZINI (output reg Q, input C, CE, D, PRE);
  parameter [0:0] ZINI = 1'b0;
  parameter [0:0] IS_C_INVERTED = 1'b0;
  initial Q <= !ZINI;
  generate case (|IS_C_INVERTED)
    1'b0: always @(posedge C, posedge PRE) if (PRE) Q <= 1'b1; else if (CE) Q <= D;
    1'b1: always @(negedge C, posedge PRE) if (PRE) Q <= 1'b1; else if (CE) Q <= D;
  endcase endgenerate
endmodule

// ============================================================================
// Carry chain primitives

module CARRY4_VPR(O0, O1, O2, O3, CO_CHAIN, CO_FABRIC0, CO_FABRIC1, CO_FABRIC2, CO_FABRIC3, CYINIT, CIN, DI0, DI1, DI2, DI3, S0, S1, S2, S3);
  parameter CYINIT_AX = 1'b0;
  parameter CYINIT_C0 = 1'b0;
  parameter CYINIT_C1 = 1'b0;

  (* DELAY_CONST_CYINIT="0.491e-9" *)
  (* DELAY_CONST_CIN="0.235e-9" *)
  (* DELAY_CONST_S0="0.223e-9" *)
  output wire O0;

  (* DELAY_CONST_CYINIT="0.613e-9" *)
  (* DELAY_CONST_CIN="0.348e-9" *)
  (* DELAY_CONST_S0="0.400e-9" *)
  (* DELAY_CONST_S1="0.205e-9" *)
  (* DELAY_CONST_DI0="0.337e-9" *)
  output wire O1;

  (* DELAY_CONST_CYINIT="0.600e-9" *)
  (* DELAY_CONST_CIN="0.256e-9" *)
  (* DELAY_CONST_S0="0.523e-9" *)
  (* DELAY_CONST_S1="0.558e-9" *)
  (* DELAY_CONST_S2="0.226e-9" *)
  (* DELAY_CONST_DI0="0.486e-9" *)
  (* DELAY_CONST_DI1="0.471e-9" *)
  output wire O2;

  (* DELAY_CONST_CYINIT="0.657e-9" *)
  (* DELAY_CONST_CIN="0.329e-9" *)
  (* DELAY_CONST_S0="0.582e-9" *)
  (* DELAY_CONST_S1="0.618e-9" *)
  (* DELAY_CONST_S2="0.330e-9" *)
  (* DELAY_CONST_S3="0.227e-9" *)
  (* DELAY_CONST_DI0="0.545e-9" *)
  (* DELAY_CONST_DI1="0.532e-9" *)
  (* DELAY_CONST_DI2="0.372e-9" *)
  output wire O3;

  (* DELAY_CONST_CYINIT="0.578e-9" *)
  (* DELAY_CONST_CIN="0.293e-9" *)
  (* DELAY_CONST_S0="0.340e-9" *)
  (* DELAY_CONST_DI0="0.329e-9" *)
  output wire CO_FABRIC0;

  (* DELAY_CONST_CYINIT="0.529e-9" *)
  (* DELAY_CONST_CIN="0.178e-9" *)
  (* DELAY_CONST_S0="0.433e-9" *)
  (* DELAY_CONST_S1="0.469e-9" *)
  (* DELAY_CONST_DI0="0.396e-9" *)
  (* DELAY_CONST_DI1="0.376e-9" *)
  output wire CO_FABRIC1;

  (* DELAY_CONST_CYINIT="0.617e-9" *)
  (* DELAY_CONST_CIN="0.250e-9" *)
  (* DELAY_CONST_S0="0.512e-9" *)
  (* DELAY_CONST_S1="0.548e-9" *)
  (* DELAY_CONST_S2="0.292e-9" *)
  (* DELAY_CONST_DI0="0.474e-9" *)
  (* DELAY_CONST_DI1="0.459e-9" *)
  (* DELAY_CONST_DI2="0.289e-9" *)
  output wire CO_FABRIC2;

  (* DELAY_CONST_CYINIT="0.580e-9" *)
  (* DELAY_CONST_CIN="0.114e-9" *)
  (* DELAY_CONST_S0="0.508e-9" *)
  (* DELAY_CONST_S1="0.528e-9" *)
  (* DELAY_CONST_S2="0.376e-9" *)
  (* DELAY_CONST_S3="0.380e-9" *)
  (* DELAY_CONST_DI0="0.456e-9" *)
  (* DELAY_CONST_DI1="0.443e-9" *)
  (* DELAY_CONST_DI2="0.324e-9" *)
  (* DELAY_CONST_DI3="0.327e-9" *)
  output wire CO_FABRIC3;

  (* DELAY_CONST_CYINIT="0.580e-9" *)
  (* DELAY_CONST_CIN="0.114e-9" *)
  (* DELAY_CONST_S0="0.508e-9" *)
  (* DELAY_CONST_S1="0.528e-9" *)
  (* DELAY_CONST_S2="0.376e-9" *)
  (* DELAY_CONST_S3="0.380e-9" *)
  (* DELAY_CONST_DI0="0.456e-9" *)
  (* DELAY_CONST_DI1="0.443e-9" *)
  (* DELAY_CONST_DI2="0.324e-9" *)
  (* DELAY_CONST_DI3="0.327e-9" *)
  output wire CO_CHAIN;

  input wire DI0, DI1, DI2, DI3;
  input wire S0, S1, S2, S3;

  input wire CYINIT;
  input wire CIN;

  wire CI0;
  wire CI1;
  wire CI2;
  wire CI3;
  wire CI4;

  assign CI0 = CYINIT_AX ? CYINIT :
               CYINIT_C1 ? 1'b1 :
               CYINIT_C0 ? 1'b0 :
               CIN;
  assign CI1 = S0 ? CI0 : DI0;
  assign CI2 = S1 ? CI1 : DI1;
  assign CI3 = S2 ? CI2 : DI2;
  assign CI4 = S3 ? CI3 : DI3;

  assign CO_FABRIC0 = CI1;
  assign CO_FABRIC1 = CI2;
  assign CO_FABRIC2 = CI3;
  assign CO_FABRIC3 = CI4;

  assign O0 = CI0 ^ S0;
  assign O1 = CI1 ^ S1;
  assign O2 = CI2 ^ S2;
  assign O3 = CI3 ^ S3;

  assign CO_CHAIN = CO_FABRIC3;
endmodule

// ============================================================================
// Distributed RAMs

module DPRAM64_for_RAM128X1D (
  output O,
  input  DI, CLK, WE, WA7,
  input [5:0] A, WA
);
  parameter [63:0] INIT = 64'h0;
  parameter IS_WCLK_INVERTED = 1'b0;
  parameter HIGH_WA7_SELECT = 1'b0;
  wire [5:0] A;
  wire [5:0] WA;
  reg [63:0] mem;
  initial mem <= INIT;
  assign O = mem[A];
  wire clk = CLK ^ IS_WCLK_INVERTED;
  always @(posedge clk) if (WE & (WA7 == HIGH_WA7_SELECT)) mem[WA] <= DI;
endmodule

module DPRAM64 (
  output O,
  input  DI, CLK, WE, WA7, WA8,
  input [5:0] A, WA
);
  parameter [63:0] INIT = 64'h0;
  parameter IS_WCLK_INVERTED = 1'b0;
  parameter WA7USED = 1'b0;
  parameter WA8USED = 1'b0;
  parameter HIGH_WA7_SELECT = 1'b0;
  parameter HIGH_WA8_SELECT = 1'b0;
  wire [5:0] A;
  wire [5:0] WA;
  reg [63:0] mem;
  initial mem <= INIT;
  assign O = mem[A];
  wire clk = CLK ^ IS_WCLK_INVERTED;

  wire WA7SELECT = !WA7USED | (WA7 == HIGH_WA7_SELECT);
  wire WA8SELECT = !WA8USED | (WA8 == HIGH_WA8_SELECT);
  wire address_selected = WA7SELECT & WA8SELECT;
  always @(posedge clk) if (WE & address_selected) mem[WA] <= DI;
endmodule

module DPRAM32 (
  output O,
  input  DI, CLK, WE,
  input [4:0] A, WA
);
  parameter [31:0] INIT_00 = 32'h0;
  parameter IS_WCLK_INVERTED = 1'b0;
  wire [4:0] A;
  wire [4:0] WA;
  reg [31:0] mem;
  initial mem <= INIT_00;
  assign O = mem[A];
  wire clk = CLK ^ IS_WCLK_INVERTED;
  always @(posedge clk) if (WE) begin
    mem[WA] <= DI;
  end
endmodule

module SPRAM32 (
  output O,
  input  DI, CLK, WE,
  input [4:0] A, WA
);
  parameter [31:0] INIT_ZERO = 32'h0;
  parameter [31:0] INIT_00 = 32'h0;
  parameter IS_WCLK_INVERTED = 1'b0;
  wire [4:0] A;
  wire [4:0] WA;
  reg [31:0] mem;
  initial mem <= INIT_00;
  assign O = mem[A];
  wire clk = CLK ^ IS_WCLK_INVERTED;
  always @(posedge clk) if (WE) begin
    mem[WA] <= DI;
  end
endmodule

module DI64_STUB (
    input DI, output DO
);
    assign DO = DI;
endmodule

// To ensure that all DRAMs are co-located within a SLICEM, this block is
// a simple passthrough black box to allow a pack pattern for dual port DRAMs.
module DRAM_2_OUTPUT_STUB(
    input SPO, DPO,
    output SPO_OUT, DPO_OUT
);
  wire SPO_OUT;
  wire DPO_OUT;
  assign SPO_OUT = SPO;
  assign DPO_OUT = DPO;
endmodule

module DRAM_4_OUTPUT_STUB(
    input DOA, DOB, DOC, DOD,
    output DOA_OUT, DOB_OUT, DOC_OUT, DOD_OUT
);
  assign DOA_OUT = DOA;
  assign DOB_OUT = DOB;
  assign DOC_OUT = DOC;
  assign DOD_OUT = DOD;
endmodule

module DRAM_8_OUTPUT_STUB(
    input DOA1, DOB1, DOC1, DOD1, DOA0, DOB0, DOC0, DOD0,
    output DOA1_OUT, DOB1_OUT, DOC1_OUT, DOD1_OUT, DOA0_OUT, DOB0_OUT, DOC0_OUT, DOD0_OUT
);
  assign DOA1_OUT = DOA1;
  assign DOB1_OUT = DOB1;
  assign DOC1_OUT = DOC1;
  assign DOD1_OUT = DOD1;
  assign DOA0_OUT = DOA0;
  assign DOB0_OUT = DOB0;
  assign DOC0_OUT = DOC0;
  assign DOD0_OUT = DOD0;
endmodule

// ============================================================================
// Block RAMs

module RAMB18E1_VPR (
	input CLKARDCLK,
	input CLKBWRCLK,
	input ENARDEN,
	input ENBWREN,
	input REGCLKARDRCLK,
	input REGCEAREGCE,
	input REGCEB,
	input REGCLKB,
	input RSTRAMARSTRAM,
	input RSTRAMB,
	input RSTREGARSTREG,
	input RSTREGB,

	input [1:0]  ADDRBTIEHIGH,
	input [13:0] ADDRBWRADDR,
	input [1:0]  ADDRATIEHIGH,
	input [13:0] ADDRARDADDR,
	input [15:0] DIADI,
	input [15:0] DIBDI,
	input [1:0] DIPADIP,
	input [1:0] DIPBDIP,
	input [3:0] WEA,
	input [7:0] WEBWE,

	output [15:0] DOADO,
	output [15:0] DOBDO,
	output [1:0] DOPADOP,
	output [1:0] DOPBDOP
);
	parameter IN_USE = 1'b0;

	parameter ZINIT_A = 18'h0;
	parameter ZINIT_B = 18'h0;

	parameter ZSRVAL_A = 18'h0;
	parameter ZSRVAL_B = 18'h0;

	parameter INITP_00 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
	parameter INITP_01 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
	parameter INITP_02 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
	parameter INITP_03 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
	parameter INITP_04 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
	parameter INITP_05 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
	parameter INITP_06 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
	parameter INITP_07 = 256'h0000000000000000000000000000000000000000000000000000000000000000;

	parameter INIT_00 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
	parameter INIT_01 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
	parameter INIT_02 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
	parameter INIT_03 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
	parameter INIT_04 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
	parameter INIT_05 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
	parameter INIT_06 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
	parameter INIT_07 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
	parameter INIT_08 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
	parameter INIT_09 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
	parameter INIT_0A = 256'h0000000000000000000000000000000000000000000000000000000000000000;
	parameter INIT_0B = 256'h0000000000000000000000000000000000000000000000000000000000000000;
	parameter INIT_0C = 256'h0000000000000000000000000000000000000000000000000000000000000000;
	parameter INIT_0D = 256'h0000000000000000000000000000000000000000000000000000000000000000;
	parameter INIT_0E = 256'h0000000000000000000000000000000000000000000000000000000000000000;
	parameter INIT_0F = 256'h0000000000000000000000000000000000000000000000000000000000000000;
	parameter INIT_10 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
	parameter INIT_11 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
	parameter INIT_12 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
	parameter INIT_13 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
	parameter INIT_14 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
	parameter INIT_15 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
	parameter INIT_16 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
	parameter INIT_17 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
	parameter INIT_18 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
	parameter INIT_19 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
	parameter INIT_1A = 256'h0000000000000000000000000000000000000000000000000000000000000000;
	parameter INIT_1B = 256'h0000000000000000000000000000000000000000000000000000000000000000;
	parameter INIT_1C = 256'h0000000000000000000000000000000000000000000000000000000000000000;
	parameter INIT_1D = 256'h0000000000000000000000000000000000000000000000000000000000000000;
	parameter INIT_1E = 256'h0000000000000000000000000000000000000000000000000000000000000000;
	parameter INIT_1F = 256'h0000000000000000000000000000000000000000000000000000000000000000;
	parameter INIT_20 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
	parameter INIT_21 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
	parameter INIT_22 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
	parameter INIT_23 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
	parameter INIT_24 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
	parameter INIT_25 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
	parameter INIT_26 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
	parameter INIT_27 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
	parameter INIT_28 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
	parameter INIT_29 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
	parameter INIT_2A = 256'h0000000000000000000000000000000000000000000000000000000000000000;
	parameter INIT_2B = 256'h0000000000000000000000000000000000000000000000000000000000000000;
	parameter INIT_2C = 256'h0000000000000000000000000000000000000000000000000000000000000000;
	parameter INIT_2D = 256'h0000000000000000000000000000000000000000000000000000000000000000;
	parameter INIT_2E = 256'h0000000000000000000000000000000000000000000000000000000000000000;
	parameter INIT_2F = 256'h0000000000000000000000000000000000000000000000000000000000000000;
	parameter INIT_30 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
	parameter INIT_31 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
	parameter INIT_32 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
	parameter INIT_33 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
	parameter INIT_34 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
	parameter INIT_35 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
	parameter INIT_36 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
	parameter INIT_37 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
	parameter INIT_38 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
	parameter INIT_39 = 256'h0000000000000000000000000000000000000000000000000000000000000000;
	parameter INIT_3A = 256'h0000000000000000000000000000000000000000000000000000000000000000;
	parameter INIT_3B = 256'h0000000000000000000000000000000000000000000000000000000000000000;
	parameter INIT_3C = 256'h0000000000000000000000000000000000000000000000000000000000000000;
	parameter INIT_3D = 256'h0000000000000000000000000000000000000000000000000000000000000000;
	parameter INIT_3E = 256'h0000000000000000000000000000000000000000000000000000000000000000;
	parameter INIT_3F = 256'h0000000000000000000000000000000000000000000000000000000000000000;

	parameter ZINV_CLKARDCLK = 1'b1;
	parameter ZINV_CLKBWRCLK = 1'b1;
	parameter ZINV_ENARDEN = 1'b1;
	parameter ZINV_ENBWREN = 1'b1;
	parameter ZINV_RSTRAMARSTRAM = 1'b1;
	parameter ZINV_RSTRAMB = 1'b1;
	parameter ZINV_RSTREGARSTREG = 1'b1;
	parameter ZINV_RSTREGB = 1'b1;
	parameter ZINV_REGCLKARDRCLK = 1'b1;
	parameter ZINV_REGCLKB = 1'b1;

	parameter DOA_REG = 1'b0;
	parameter DOB_REG = 1'b0;

	parameter integer SDP_READ_WIDTH_36 = 1'b0;
	parameter integer Y0_READ_WIDTH_A_18 = 1'b0;
	parameter integer Y1_READ_WIDTH_A_18 = 1'b0;
	parameter integer READ_WIDTH_A_9 = 1'b0;
	parameter integer READ_WIDTH_A_4 = 1'b0;
	parameter integer READ_WIDTH_A_2 = 1'b0;
	parameter integer Y0_READ_WIDTH_A_1 = 1'b0;
	parameter integer Y1_READ_WIDTH_A_1 = 1'b0;
	parameter integer READ_WIDTH_B_18 = 1'b0;
	parameter integer READ_WIDTH_B_9 = 1'b0;
	parameter integer READ_WIDTH_B_4 = 1'b0;
	parameter integer READ_WIDTH_B_2 = 1'b0;
	parameter integer READ_WIDTH_B_1 = 1'b1;

	parameter integer SDP_WRITE_WIDTH_36 = 1'b0;
	parameter integer WRITE_WIDTH_A_18 = 1'b0;
	parameter integer WRITE_WIDTH_A_9 = 1'b0;
	parameter integer WRITE_WIDTH_A_4 = 1'b0;
	parameter integer WRITE_WIDTH_A_2 = 1'b0;
	parameter integer WRITE_WIDTH_A_1 = 1'b1;
	parameter integer WRITE_WIDTH_B_18 = 1'b0;
	parameter integer WRITE_WIDTH_B_9 = 1'b0;
	parameter integer WRITE_WIDTH_B_4 = 1'b0;
	parameter integer WRITE_WIDTH_B_2 = 1'b0;
	parameter integer WRITE_WIDTH_B_1 = 1'b1;

	parameter WRITE_MODE_A_NO_CHANGE = 1'b0;
	parameter WRITE_MODE_A_READ_FIRST = 1'b0;
	parameter WRITE_MODE_B_NO_CHANGE = 1'b0;
	parameter WRITE_MODE_B_READ_FIRST = 1'b0;
endmodule

module RAMB36E1_PRIM (
        input CLKARDCLKU,           input CLKARDCLKL,
        input CLKBWRCLKU,           input CLKBWRCLKL,
        input ENARDENU,             input ENARDENL,
        input ENBWRENU,             input ENBWRENL,
        input REGCLKARDRCLKU,       input REGCLKARDRCLKL,
        input REGCEAREGCEU,         input REGCEAREGCEL,
        input REGCEBU,              input REGCEBL,
        input REGCLKBU,             input REGCLKBK,
        input RSTRAMARSTRAMU,       input RSTRAMARSTRAMLRST,
        input RSTRAMBU,             input RSTRAMBL,
        input RSTREGARSTREGU,       input RSTREGARSTREGL,
        input RSTREGBU,             input RSTREGBL,

        input [14:0] ADDRBWRADDRU,  input [15:0] ADDRBWRADDRL,
        input [14:0] ADDRARDADDRU,  input [15:0] ADDRARDADDRL,
        input [31:0] DIADI,
        input [31:0] DIBDI,
        input [3:0] DIPADIP,
        input [3:0] DIPBDIP,
        input [3:0] WEAU,           input [3:0] WEAL,
        input [7:0] WEBWEU,         input [7:0] WEBWEL,

        output [31:0] DOADO,
        output [31:0] DOBDO,
        output [3:0] DOPADOP,
        output [3:0] DOPBDOP
);
        parameter IN_USE = 1'b0;

        parameter ZINIT_A = 36'h0;
        parameter ZINIT_B = 36'h0;

        parameter ZSRVAL_A = 36'h0;
        parameter ZSRVAL_B = 36'h0;

        `define INIT_BLOCK(pre) \
        parameter ``pre``0 = 256'h0000000000000000000000000000000000000000000000000000000000000000; \
        parameter ``pre``1 = 256'h0000000000000000000000000000000000000000000000000000000000000000; \
        parameter ``pre``2 = 256'h0000000000000000000000000000000000000000000000000000000000000000; \
        parameter ``pre``3 = 256'h0000000000000000000000000000000000000000000000000000000000000000; \
        parameter ``pre``4 = 256'h0000000000000000000000000000000000000000000000000000000000000000; \
        parameter ``pre``5 = 256'h0000000000000000000000000000000000000000000000000000000000000000; \
        parameter ``pre``6 = 256'h0000000000000000000000000000000000000000000000000000000000000000; \
        parameter ``pre``7 = 256'h0000000000000000000000000000000000000000000000000000000000000000; \
        parameter ``pre``8 = 256'h0000000000000000000000000000000000000000000000000000000000000000; \
        parameter ``pre``9 = 256'h0000000000000000000000000000000000000000000000000000000000000000; \
        parameter ``pre``A = 256'h0000000000000000000000000000000000000000000000000000000000000000; \
        parameter ``pre``B = 256'h0000000000000000000000000000000000000000000000000000000000000000; \
        parameter ``pre``C = 256'h0000000000000000000000000000000000000000000000000000000000000000; \
        parameter ``pre``D = 256'h0000000000000000000000000000000000000000000000000000000000000000; \
        parameter ``pre``E = 256'h0000000000000000000000000000000000000000000000000000000000000000; \
        parameter ``pre``F = 256'h0000000000000000000000000000000000000000000000000000000000000000

        `INIT_BLOCK(INITP_0);
        `INIT_BLOCK(INIT_1);
        `INIT_BLOCK(INIT_2);
        `INIT_BLOCK(INIT_3);
        `INIT_BLOCK(INIT_4);
        `INIT_BLOCK(INIT_5);
        `INIT_BLOCK(INIT_6);
        `INIT_BLOCK(INIT_7);
        `undef INIT_BLOCK

        parameter ZINV_CLKARDCLK = 1'b1;
        parameter ZINV_CLKBWRCLK = 1'b1;
        parameter ZINV_ENARDEN = 1'b1;
        parameter ZINV_ENBWREN = 1'b1;
        parameter ZINV_RSTRAMARSTRAM = 1'b1;
        parameter ZINV_RSTRAMB = 1'b1;
        parameter ZINV_RSTREGARSTREG = 1'b1;
        parameter ZINV_RSTREGB = 1'b1;
        parameter ZINV_REGCLKARDRCLK = 1'b1;
        parameter ZINV_REGCLKB = 1'b1;

        parameter DOA_REG = 1'b0;
        parameter DOB_REG = 1'b0;

        parameter integer SDP_READ_WIDTH_72 = 1'b0;
        parameter integer READ_WIDTH_A_36 = 1'b0;
        parameter integer READ_WIDTH_A_18 = 1'b0;
        parameter integer READ_WIDTH_A_9 = 1'b0;
        parameter integer READ_WIDTH_A_4 = 1'b0;
        parameter integer READ_WIDTH_A_2 = 1'b0;
        parameter integer READ_WIDTH_A_1 = 1'b1;
        parameter integer READ_WIDTH_B_18 = 1'b0;
        parameter integer READ_WIDTH_B_9 = 1'b0;
        parameter integer READ_WIDTH_B_4 = 1'b0;
        parameter integer READ_WIDTH_B_2 = 1'b0;
        parameter integer READ_WIDTH_B_1 = 1'b1;

        parameter integer SDP_WRITE_WIDTH_72 = 1'b0;
        parameter integer WRITE_WIDTH_A_36 = 1'b0;
        parameter integer WRITE_WIDTH_A_18 = 1'b0;
        parameter integer WRITE_WIDTH_A_9 = 1'b0;
        parameter integer WRITE_WIDTH_A_4 = 1'b0;
        parameter integer WRITE_WIDTH_A_2 = 1'b0;
        parameter integer WRITE_WIDTH_A_1 = 1'b1;
        parameter integer WRITE_WIDTH_B_18 = 1'b0;
        parameter integer WRITE_WIDTH_B_9 = 1'b0;
        parameter integer WRITE_WIDTH_B_4 = 1'b0;
        parameter integer WRITE_WIDTH_B_2 = 1'b0;
        parameter integer WRITE_WIDTH_B_1 = 1'b1;

        parameter WRITE_MODE_A_NO_CHANGE = 1'b0;
        parameter WRITE_MODE_A_READ_FIRST = 1'b0;
        parameter WRITE_MODE_B_NO_CHANGE = 1'b0;
        parameter WRITE_MODE_B_READ_FIRST = 1'b0;
endmodule

// ============================================================================
// SRLs

// SRLC32E_VPR
module SRLC32E_VPR
(
input CLK, CE, D,
input [4:0] A,
output Q, Q31
);
  parameter [64:0] INIT = 64'd0;
  parameter [0:0] IS_CLK_INVERTED = 1'b0;

  reg [31:0] r;
  integer i;

  initial for (i=0; i<32; i=i+1)
    r[i] <= INIT[2*i];

  assign Q31 = r[31];
  assign Q = r[A];

  generate begin
    if (IS_CLK_INVERTED) begin
      always @(negedge CLK) if (CE) r <= { r[30:0], D };
    end else begin
      always @(posedge CLK) if (CE) r <= { r[30:0], D };
    end
  end endgenerate

endmodule

// SRLC16E_VPR
module SRLC16E_VPR
(
input CLK, CE, D,
input A0, A1, A2, A3,
output Q, Q15
);
  parameter [15:0] INIT = 16'd0;
  parameter [0:0] IS_CLK_INVERTED = 1'b0;

  reg [15:0] r = INIT;

  assign Q15 = r[15];
  assign Q = r[{A3,A2,A1,A0}];

  generate
    if (IS_CLK_INVERTED) begin
      always @(negedge CLK) if (CE) r <= { r[14:0], D };
    end else begin
      always @(posedge CLK) if (CE) r <= { r[14:0], D };
    end
  endgenerate

endmodule

// ============================================================================
// IO

module IBUF_VPR (
	input I,
	output O
);

  parameter [0:0] LVCMOS12_LVCMOS15_LVCMOS18_IN = 1'b0;
  parameter [0:0] LVCMOS12_LVCMOS15_LVCMOS18_LVCMOS25_LVCMOS33_LVTTL_SLEW_FAST = 1'b0;
  parameter [0:0] LVCMOS12_LVCMOS15_LVCMOS18_LVCMOS25_LVCMOS33_LVTTL_SSTL135_SSTL15_IN_ONLY = 1'b0;
  parameter [0:0] LVCMOS12_LVCMOS15_LVCMOS18_SSTL135_SSTL15_STEPDOWN = 1'b0;
  parameter [0:0] LVCMOS25_LVCMOS33_LVTTL_IN = 1'b0;
  parameter [0:0] SSTL135_SSTL15_IN = 1'b0;

  parameter [0:0] IN_TERM_UNTUNED_SPLIT_40 = 1'b0;
  parameter [0:0] IN_TERM_UNTUNED_SPLIT_50 = 1'b0;
  parameter [0:0] IN_TERM_UNTUNED_SPLIT_60 = 1'b0;

  parameter [0:0] IBUF_LOW_PWR = 1'b0;

  parameter [0:0] PULLTYPE_PULLUP = 1'b0;
  parameter [0:0] PULLTYPE_PULLDOWN = 1'b0;
  parameter [0:0] PULLTYPE_NONE = 1'b0;
  parameter [0:0] PULLTYPE_KEEPER = 1'b0;

  parameter PULLTYPE = "";

  parameter IOSTANDARD = "";

  assign O = I;

endmodule

module OBUFT_VPR (
	input  I,
    input  T,
	output O
);

  parameter [0:0] LVCMOS12_DRIVE_I12 = 1'b0;
  parameter [0:0] LVCMOS12_DRIVE_I4 = 1'b0;
  parameter [0:0] LVCMOS12_LVCMOS15_LVCMOS18_LVCMOS25_LVCMOS33_LVTTL_SLEW_FAST = 1'b0;
  parameter [0:0] LVCMOS12_LVCMOS15_LVCMOS18_LVCMOS25_LVCMOS33_LVTTL_SSTL135_SSTL15_SLEW_SLOW = 1'b0;
  parameter [0:0] LVCMOS12_LVCMOS15_LVCMOS18_SSTL135_SSTL15_STEPDOWN = 1'b0;
  parameter [0:0] LVCMOS12_LVCMOS25_DRIVE_I8 = 1'b0;
  parameter [0:0] LVCMOS15_DRIVE_I12 = 1'b0;
  parameter [0:0] LVCMOS15_DRIVE_I8 = 1'b0;
  parameter [0:0] LVCMOS15_LVCMOS18_LVCMOS25_DRIVE_I4 = 1'b0;
  parameter [0:0] LVCMOS15_SSTL15_DRIVE_I16_I_FIXED = 1'b0;
  parameter [0:0] LVCMOS18_DRIVE_I12_I8 = 1'b0;
  parameter [0:0] LVCMOS18_DRIVE_I16 = 1'b0;
  parameter [0:0] LVCMOS18_DRIVE_I24 = 1'b0;
  parameter [0:0] LVCMOS25_DRIVE_I12 = 1'b0;
  parameter [0:0] LVCMOS25_DRIVE_I16 = 1'b0;
  parameter [0:0] LVCMOS33_DRIVE_I16 = 1'b0;
  parameter [0:0] LVCMOS33_LVTTL_DRIVE_I12_I16 = 1'b0;
  parameter [0:0] LVCMOS33_LVTTL_DRIVE_I12_I8 = 1'b0;
  parameter [0:0] LVCMOS33_LVTTL_DRIVE_I4 = 1'b0;
  parameter [0:0] LVTTL_DRIVE_I24 = 1'b0;
  parameter [0:0] SSTL135_DRIVE_I_FIXED = 1'b0;
  parameter [0:0] SSTL135_SSTL15_SLEW_FAST = 1'b0;

  parameter [0:0] PULLTYPE_PULLUP = 1'b0;
  parameter [0:0] PULLTYPE_PULLDOWN = 1'b0;
  parameter [0:0] PULLTYPE_NONE = 1'b0;
  parameter [0:0] PULLTYPE_KEEPER = 1'b0;

  parameter PULLTYPE = "";

  parameter IOSTANDARD = "";
  parameter DRIVE = 0;
  parameter SLEW = "";

  assign O = (T == 1'b0) ? I : 1'bz;

endmodule


module IOBUF_VPR (
    input  I,
    input  T,
    output O,
    input  IOPAD_$inp,
    output IOPAD_$out
);

  parameter [0:0] LVCMOS12_DRIVE_I12 = 1'b0;
  parameter [0:0] LVCMOS12_DRIVE_I4 = 1'b0;
  parameter [0:0] LVCMOS12_LVCMOS15_LVCMOS18_IN = 1'b0;
  parameter [0:0] LVCMOS12_LVCMOS15_LVCMOS18_LVCMOS25_LVCMOS33_LVTTL_SLEW_FAST = 1'b0;
  parameter [0:0] LVCMOS12_LVCMOS15_LVCMOS18_LVCMOS25_LVCMOS33_LVTTL_SSTL135_SSTL15_SLEW_SLOW = 1'b0;
  parameter [0:0] LVCMOS12_LVCMOS15_LVCMOS18_SSTL135_SSTL15_STEPDOWN = 1'b0;
  parameter [0:0] LVCMOS12_LVCMOS25_DRIVE_I8 = 1'b0;
  parameter [0:0] LVCMOS15_DRIVE_I12 = 1'b0;
  parameter [0:0] LVCMOS15_DRIVE_I8 = 1'b0;
  parameter [0:0] LVCMOS15_LVCMOS18_LVCMOS25_DRIVE_I4 = 1'b0;
  parameter [0:0] LVCMOS15_SSTL15_DRIVE_I16_I_FIXED = 1'b0;
  parameter [0:0] LVCMOS18_DRIVE_I12_I8 = 1'b0;
  parameter [0:0] LVCMOS18_DRIVE_I16 = 1'b0;
  parameter [0:0] LVCMOS18_DRIVE_I24 = 1'b0;
  parameter [0:0] LVCMOS25_DRIVE_I12 = 1'b0;
  parameter [0:0] LVCMOS25_DRIVE_I16 = 1'b0;
  parameter [0:0] LVCMOS25_LVCMOS33_LVTTL_IN = 1'b0;
  parameter [0:0] LVCMOS33_DRIVE_I16 = 1'b0;
  parameter [0:0] LVCMOS33_LVTTL_DRIVE_I12_I16 = 1'b0;
  parameter [0:0] LVCMOS33_LVTTL_DRIVE_I12_I8 = 1'b0;
  parameter [0:0] LVCMOS33_LVTTL_DRIVE_I4 = 1'b0;
  parameter [0:0] LVTTL_DRIVE_I24 = 1'b0;
  parameter [0:0] SSTL135_DRIVE_I_FIXED = 1'b0;
  parameter [0:0] SSTL135_SSTL15_IN = 1'b0;
  parameter [0:0] SSTL135_SSTL15_SLEW_FAST = 1'b0;

  parameter [0:0] IN_TERM_UNTUNED_SPLIT_40 = 1'b0;
  parameter [0:0] IN_TERM_UNTUNED_SPLIT_50 = 1'b0;
  parameter [0:0] IN_TERM_UNTUNED_SPLIT_60 = 1'b0;

  parameter [0:0] IBUF_LOW_PWR = 1'b0;

  parameter [0:0] PULLTYPE_PULLUP = 1'b0;
  parameter [0:0] PULLTYPE_PULLDOWN = 1'b0;
  parameter [0:0] PULLTYPE_NONE = 1'b0;
  parameter [0:0] PULLTYPE_KEEPER = 1'b0;

  parameter PULLTYPE = "";

  parameter IOSTANDARD = "";
  parameter DRIVE = 0;
  parameter SLEW = "";

  assign O = IOPAD_$inp;
  assign IOPAD_$out = (T == 1'b0) ? I : 1'bz;

endmodule


module OBUFTDS_M_VPR (
    input  I,
    input  T,
    output O,
    output OB
);

  parameter [0:0] LVCMOS12_LVCMOS15_LVCMOS18_LVCMOS25_LVCMOS33_LVTTL_SSTL135_SSTL15_SLEW_SLOW = 1'b0;
  parameter [0:0] LVCMOS12_LVCMOS15_LVCMOS18_SSTL135_SSTL15_STEPDOWN = 1'b0;
  parameter [0:0] LVCMOS15_SSTL15_DRIVE_I16_I_FIXED = 1'b0;
  parameter [0:0] SSTL135_DRIVE_I_FIXED = 1'b0;
  parameter [0:0] SSTL135_SSTL15_SLEW_FAST = 1'b0;

  parameter [0:0] IN_TERM_UNTUNED_SPLIT_40 = 1'b0;
  parameter [0:0] IN_TERM_UNTUNED_SPLIT_50 = 1'b0;
  parameter [0:0] IN_TERM_UNTUNED_SPLIT_60 = 1'b0;

  parameter [0:0] PULLTYPE_PULLUP = 1'b0;
  parameter [0:0] PULLTYPE_PULLDOWN = 1'b0;
  parameter [0:0] PULLTYPE_NONE = 1'b0;
  parameter [0:0] PULLTYPE_KEEPER = 1'b0;

  parameter PULLTYPE = "";

  parameter IOSTANDARD = "";
  parameter SLEW = "";

  assign O  = (T == 1'b0) ?  I : 1'bz;
  assign OB = (T == 1'b0) ? !I : 1'bz;

endmodule

module OBUFTDS_S_VPR (
    input  IB,
    output OB
);

  parameter [0:0] LVCMOS12_LVCMOS15_LVCMOS18_LVCMOS25_LVCMOS33_LVTTL_SSTL135_SSTL15_SLEW_SLOW = 1'b0;
  parameter [0:0] LVCMOS12_LVCMOS15_LVCMOS18_SSTL135_SSTL15_STEPDOWN = 1'b0;
  parameter [0:0] LVCMOS15_SSTL15_DRIVE_I16_I_FIXED = 1'b0;
  parameter [0:0] SSTL135_DRIVE_I_FIXED = 1'b0;
  parameter [0:0] SSTL135_SSTL15_SLEW_FAST = 1'b0;

  parameter [0:0] IN_TERM_UNTUNED_SPLIT_40 = 1'b0;
  parameter [0:0] IN_TERM_UNTUNED_SPLIT_50 = 1'b0;
  parameter [0:0] IN_TERM_UNTUNED_SPLIT_60 = 1'b0;

  parameter [0:0] PULLTYPE_PULLUP = 1'b0;
  parameter [0:0] PULLTYPE_PULLDOWN = 1'b0;
  parameter [0:0] PULLTYPE_NONE = 1'b0;
  parameter [0:0] PULLTYPE_KEEPER = 1'b0;

  parameter PULLTYPE = "";

  parameter IOSTANDARD = "";
  parameter SLEW = "";

  assign OB = IB;

endmodule


module IOBUFDS_M_VPR (
    input  I,
    input  T,
    output O,
    input  IOPAD_$inp,
    output IOPAD_$out,
    input  IB,
    output OB
);

  parameter [0:0] LVCMOS12_LVCMOS15_LVCMOS18_LVCMOS25_LVCMOS33_LVTTL_SSTL135_SSTL15_SLEW_SLOW = 1'b0;
  parameter [0:0] LVCMOS12_LVCMOS15_LVCMOS18_SSTL135_SSTL15_STEPDOWN = 1'b0;
  parameter [0:0] LVCMOS15_SSTL15_DRIVE_I16_I_FIXED = 1'b0;
  parameter [0:0] SSTL135_DRIVE_I_FIXED = 1'b0;
  parameter [0:0] SSTL135_SSTL15_IN_DIFF = 1'b0;
  parameter [0:0] SSTL135_SSTL15_SLEW_FAST = 1'b0;

  parameter [0:0] IN_TERM_UNTUNED_SPLIT_40 = 1'b0;
  parameter [0:0] IN_TERM_UNTUNED_SPLIT_50 = 1'b0;
  parameter [0:0] IN_TERM_UNTUNED_SPLIT_60 = 1'b0;

  parameter [0:0] PULLTYPE_PULLUP = 1'b0;
  parameter [0:0] PULLTYPE_PULLDOWN = 1'b0;
  parameter [0:0] PULLTYPE_NONE = 1'b0;
  parameter [0:0] PULLTYPE_KEEPER = 1'b0;

  parameter PULLTYPE = "";

  parameter IOSTANDARD = "";
  parameter SLEW = "";

  reg O;
  always @(*) case ({IB, IOPAD_$inp})
  2'b00: O <= 1'bX;
  2'b01: O <= 1'b1;
  2'b10: O <= 1'b0;
  2'b11: O <= 1'bX;
  endcase

  assign IOPAD_$out = (T == 1'b0) ?  I : 1'bz;
  assign OB         = (T == 1'b0) ? !I : 1'bz;

endmodule

module IOBUFDS_S_VPR (
    input  IB,
    output OB,
    input  IOPAD_$inp,
    output IOPAD_$out
);

  parameter [0:0] LVCMOS12_LVCMOS15_LVCMOS18_LVCMOS25_LVCMOS33_LVTTL_SSTL135_SSTL15_SLEW_SLOW = 1'b0;
  parameter [0:0] LVCMOS12_LVCMOS15_LVCMOS18_SSTL135_SSTL15_STEPDOWN = 1'b0;
  parameter [0:0] LVCMOS15_SSTL15_DRIVE_I16_I_FIXED = 1'b0;
  parameter [0:0] SSTL135_DRIVE_I_FIXED = 1'b0;
  parameter [0:0] SSTL135_SSTL15_IN_DIFF = 1'b0;
  parameter [0:0] SSTL135_SSTL15_SLEW_FAST = 1'b0;

  parameter [0:0] IN_TERM_UNTUNED_SPLIT_40 = 1'b0;
  parameter [0:0] IN_TERM_UNTUNED_SPLIT_50 = 1'b0;
  parameter [0:0] IN_TERM_UNTUNED_SPLIT_60 = 1'b0;

  parameter [0:0] PULLTYPE_PULLUP = 1'b0;
  parameter [0:0] PULLTYPE_PULLDOWN = 1'b0;
  parameter [0:0] PULLTYPE_NONE = 1'b0;
  parameter [0:0] PULLTYPE_KEEPER = 1'b0;

  parameter PULLTYPE = "";

  parameter IOSTANDARD = "";
  parameter SLEW = "";

  assign IOPAD_$out = IB;
  assign OB = IOPAD_$inp;

endmodule

(* whitebox *)
module T_INV (
    input  TI,
    output TO
);

  assign TO = ~TI;

endmodule

// ============================================================================
// I/OSERDES

module OSERDESE2_VPR (
  input CLK,
  input CLKDIV,
  input D1,
  input D2,
  input D3,
  input D4,
  input D5,
  input D6,
  input D7,
  input D8,
  input OCE,
  input RST,
  input T1,
  input T2,
  input T3,
  input T4,
  input TCE,
  output OFB,
  output OQ,
  output TFB,
  output TQ
);

  parameter [0:0] SERDES_MODE_SLAVE = 1'b0;

  parameter [0:0] TRISTATE_WIDTH_W4 = 1'b0;

  parameter [0:0] DATA_RATE_OQ_DDR = 1'b0;
  parameter [0:0] DATA_RATE_OQ_SDR = 1'b0;
  parameter [0:0] DATA_RATE_TQ_BUF = 1'b0;
  parameter [0:0] DATA_RATE_TQ_DDR = 1'b0;
  parameter [0:0] DATA_RATE_TQ_SDR = 1'b0;

  parameter [0:0] DATA_WIDTH_DDR_W6_8 = 1'b0;
  parameter [0:0] DATA_WIDTH_SDR_W2_4_5_6 = 1'b0;

  parameter [0:0] DATA_WIDTH_W2 = 1'b0;
  parameter [0:0] DATA_WIDTH_W3 = 1'b0;
  parameter [0:0] DATA_WIDTH_W4 = 1'b0;
  parameter [0:0] DATA_WIDTH_W5 = 1'b0;
  parameter [0:0] DATA_WIDTH_W6 = 1'b0;
  parameter [0:0] DATA_WIDTH_W7 = 1'b0;
  parameter [0:0] DATA_WIDTH_W8 = 1'b0;

  // Inverter parameters
  parameter [0:0] IS_CLKDIV_INVERTED = 1'b0;
  parameter [0:0] IS_D1_INVERTED = 1'b0;
  parameter [0:0] IS_D2_INVERTED = 1'b0;
  parameter [0:0] IS_D3_INVERTED = 1'b0;
  parameter [0:0] IS_D4_INVERTED = 1'b0;
  parameter [0:0] IS_D5_INVERTED = 1'b0;
  parameter [0:0] IS_D6_INVERTED = 1'b0;
  parameter [0:0] IS_D7_INVERTED = 1'b0;
  parameter [0:0] IS_D8_INVERTED = 1'b0;

  parameter [0:0] ZINV_CLK = 1'b0;
  parameter [0:0] ZINV_T1 = 1'b0;
  parameter [0:0] ZINV_T2 = 1'b0;
  parameter [0:0] ZINV_T3 = 1'b0;
  parameter [0:0] ZINV_T4 = 1'b0;

  parameter [0:0] ZINIT_OQ = 1'b0;
  parameter [0:0] ZINIT_TQ = 1'b0;
  parameter [0:0] ZSRVAL_OQ = 1'b0;
  parameter [0:0] ZSRVAL_TQ = 1'b0;
endmodule

module ISERDESE2_IDELAY_VPR (
  input  BITSLIP,
  input  CE1,
  input  CE2,
  input  CLK,
  input  CLKB,
  input  CLKDIV,
  input  RST,
  input  DDLY,
  output Q1,
  output Q2,
  output Q3,
  output Q4,
  output Q5,
  output Q6,
  output Q7,
  output Q8
  );

  parameter [0:0] MEMORY_DDR3_4     = 1'b0;
  parameter [0:0] MEMORY_DDR_4      = 1'b0;
  parameter [0:0] MEMORY_QDR_4      = 1'b0;

  parameter [0:0] NETWORKING_SDR_2  = 1'b0;
  parameter [0:0] NETWORKING_SDR_3  = 1'b0;
  parameter [0:0] NETWORKING_SDR_4  = 1'b0;
  parameter [0:0] NETWORKING_SDR_5  = 1'b0;
  parameter [0:0] NETWORKING_SDR_6  = 1'b0;
  parameter [0:0] NETWORKING_SDR_7  = 1'b0;
  parameter [0:0] NETWORKING_SDR_8  = 1'b0;

  parameter [0:0] NETWORKING_DDR_4  = 1'b0;
  parameter [0:0] NETWORKING_DDR_6  = 1'b0;
  parameter [0:0] NETWORKING_DDR_8  = 1'b0;
  parameter [0:0] NETWORKING_DDR_10 = 1'b0;
  parameter [0:0] NETWORKING_DDR_14 = 1'b0;

  parameter [0:0] OVERSAMPLE_DDR_4  = 1'b0;

  parameter [0:0] NUM_CE_N1 = 1'b0;
  parameter [0:0] NUM_CE_N2 = 1'b1;

  parameter [0:0] IOBDELAY_IFD = 1'b0;
  parameter [0:0] IOBDELAY_IBUF = 1'b0;

  parameter [0:0] ZINIT_Q1 = 1'b0;
  parameter [0:0] ZINIT_Q2 = 1'b0;
  parameter [0:0] ZINIT_Q3 = 1'b0;
  parameter [0:0] ZINIT_Q4 = 1'b0;

  parameter [0:0] ZSRVAL_Q1 = 1'b0;
  parameter [0:0] ZSRVAL_Q2 = 1'b0;
  parameter [0:0] ZSRVAL_Q3 = 1'b0;
  parameter [0:0] ZSRVAL_Q4 = 1'b0;

  parameter [0:0] ZINV_D = 1'b0;
  parameter [0:0] ZINV_C = 1'b0;

endmodule

module ISERDESE2_NO_IDELAY_VPR (
  input  BITSLIP,
  input  CE1,
  input  CE2,
  input  CLK,
  input  CLKB,
  input  CLKDIV,
  input  RST,
  input  D,
  output Q1,
  output Q2,
  output Q3,
  output Q4,
  output Q5,
  output Q6,
  output Q7,
  output Q8
  );

  parameter [0:0] MEMORY_DDR3_4     = 1'b0;
  parameter [0:0] MEMORY_DDR_4      = 1'b0;
  parameter [0:0] MEMORY_QDR_4      = 1'b0;

  parameter [0:0] NETWORKING_SDR_2  = 1'b0;
  parameter [0:0] NETWORKING_SDR_3  = 1'b0;
  parameter [0:0] NETWORKING_SDR_4  = 1'b0;
  parameter [0:0] NETWORKING_SDR_5  = 1'b0;
  parameter [0:0] NETWORKING_SDR_6  = 1'b0;
  parameter [0:0] NETWORKING_SDR_7  = 1'b0;
  parameter [0:0] NETWORKING_SDR_8  = 1'b0;

  parameter [0:0] NETWORKING_DDR_4  = 1'b0;
  parameter [0:0] NETWORKING_DDR_6  = 1'b0;
  parameter [0:0] NETWORKING_DDR_8  = 1'b0;
  parameter [0:0] NETWORKING_DDR_10 = 1'b0;
  parameter [0:0] NETWORKING_DDR_14 = 1'b0;

  parameter [0:0] OVERSAMPLE_DDR_4  = 1'b0;

  parameter [0:0] NUM_CE_N1 = 1'b0;
  parameter [0:0] NUM_CE_N2 = 1'b1;

  parameter [0:0] IOBDELAY_IFD = 1'b0;
  parameter [0:0] IOBDELAY_IBUF = 1'b0;

  parameter [0:0] ZINIT_Q1 = 1'b0;
  parameter [0:0] ZINIT_Q2 = 1'b0;
  parameter [0:0] ZINIT_Q3 = 1'b0;
  parameter [0:0] ZINIT_Q4 = 1'b0;

  parameter [0:0] ZSRVAL_Q1 = 1'b0;
  parameter [0:0] ZSRVAL_Q2 = 1'b0;
  parameter [0:0] ZSRVAL_Q3 = 1'b0;
  parameter [0:0] ZSRVAL_Q4 = 1'b0;

  parameter [0:0] ZINV_D = 1'b0;
  parameter [0:0] ZINV_C = 1'b0;

endmodule

// ============================================================================
// IDDR/ODDR

(* blackbox *)
module IDDR_VPR (
  input  CK,
  input  CKB,
  input  CE,
  input  SR,
  input  D,
  output Q1,
  output Q2
);

  parameter [0:0] ZINV_D = 1'b1;
  parameter [0:0] ZINV_C = 1'b1;

  parameter [0:0] SRTYPE_SYNC = 1'b0;

  parameter [0:0] SAME_EDGE     = 1'b1;
  parameter [0:0] OPPOSITE_EDGE = 1'b0;

  parameter [0:0] ZINIT_Q1   = 1'b0;
  parameter [0:0] ZINIT_Q2   = 1'b0;
  parameter [0:0] ZINIT_Q3   = 1'b0;
  parameter [0:0] ZINIT_Q4   = 1'b0;
  parameter [0:0] ZSRVAL_Q12 = 1'b0;
  parameter [0:0] ZSRVAL_Q34 = 1'b0;

endmodule

(* blackbox *)
module ODDR_VPR (
  input  CK,
  input  CE,
  input  SR,
  input  D1,
  input  D2,
  output Q
);

  parameter [0:0] ZINV_CLK = 1'b1;
  parameter [0:0] ZINV_D1  = 1'b1;
  parameter [0:0] ZINV_D2  = 1'b1;
  parameter [0:0] INV_D1   = 1'b0;
  parameter [0:0] INV_D2   = 1'b0;

  parameter [0:0] SRTYPE_SYNC = 1'b0;
  parameter [0:0] SAME_EDGE   = 1'b1;

  parameter [0:0] ZINIT_Q  = 1'b1;
  parameter [0:0] ZSRVAL_Q = 1'b1;

endmodule

// ============================================================================
// IDELAYE2

module IDELAYE2_VPR (
  input C,
  input CE,
  input CINVCTRL,
  input CNTVALUEIN0,
  input CNTVALUEIN1,
  input CNTVALUEIN2,
  input CNTVALUEIN3,
  input CNTVALUEIN4,
  input DATAIN,
  input IDATAIN,
  input INC,
  input LD,
  input LDPIPEEN,
  input REGRST,

  output CNTVALUEOUT0,
  output CNTVALUEOUT1,
  output CNTVALUEOUT2,
  output CNTVALUEOUT3,
  output CNTVALUEOUT4,
  output DATAOUT
  );

  parameter [0:0] IN_USE = 1'b0;

  parameter [4:0] IDELAY_VALUE = 5'b00000;
  parameter [4:0] ZIDELAY_VALUE = 5'b11111;

  parameter [0:0] PIPE_SEL = 1'b0;
  parameter [0:0] CINVCTRL_SEL = 1'b0;
  parameter [0:0] DELAY_SRC_DATAIN = 1'b0;
  parameter [0:0] DELAY_SRC_IDATAIN = 1'b0;
  parameter [0:0] HIGH_PERFORMANCE_MODE = 1'b0;

  parameter [0:0] DELAY_TYPE_FIXED = 1'b0;
  parameter [0:0] DELAY_TYPE_VAR_LOAD = 1'b0;
  parameter [0:0] DELAY_TYPE_VARIABLE = 1'b0;

  parameter [0:0] IS_DATAIN_INVERTED = 1'b0;
  parameter [0:0] IS_IDATAIN_INVERTED = 1'b0;

endmodule

// ============================================================================
// Clock Buffers

// BUFGCTRL_VPR
module BUFGCTRL_VPR
(
output O,
input I0, input I1,
input S0, input S1,
input CE0, input CE1,
input IGNORE0, input IGNORE1
);

  parameter [0:0] INIT_OUT = 1'b0;
  parameter [0:0] ZPRESELECT_I0 = 1'b0;
  parameter [0:0] ZPRESELECT_I1 = 1'b0;
  parameter [0:0] ZINV_CE0 = 1'b0;
  parameter [0:0] ZINV_CE1 = 1'b0;
  parameter [0:0] ZINV_S0 = 1'b0;
  parameter [0:0] ZINV_S1 = 1'b0;
  parameter [0:0] IS_IGNORE0_INVERTED = 1'b0;
  parameter [0:0] IS_IGNORE1_INVERTED = 1'b0;

  wire I0_internal = ((CE0 ^ !ZINV_CE0) ? I0 : INIT_OUT);
  wire I1_internal = ((CE1 ^ !ZINV_CE1) ? I1 : INIT_OUT);
  wire S0_true = (S0 ^ !ZINV_S0);
  wire S1_true = (S1 ^ !ZINV_S1);

  assign O = S0_true ? I0_internal : (S1_true ? I1_internal : INIT_OUT);

endmodule

// BUFHCE_VPR
module BUFHCE_VPR
(
output O,
input I,
input CE
);

  parameter [0:0] INIT_OUT = 1'b0;
  parameter CE_TYPE = "SYNC";
  parameter [0:0] ZINV_CE = 1'b0;

  wire I = ((CE ^ !ZINV_CE) ? I : INIT_OUT);

  assign O = I;

endmodule

// ============================================================================
// CMT

// PLLE2_ADV_VPR
(* blackbox *)
module PLLE2_ADV_VPR
(
input         CLKFBIN,
input         CLKIN1,
input         CLKIN2,
input         CLKINSEL,

output        CLKFBOUT,
output        CLKOUT0,
output        CLKOUT1,
output        CLKOUT2,
output        CLKOUT3,
output        CLKOUT4,
output        CLKOUT5,

input         PWRDWN,
input         RST,
output        LOCKED,

input         DCLK,
input         DEN,
input         DWE,
output        DRDY,
input  [ 6:0] DADDR,
input  [15:0] DI,
output [15:0] DO
);

  parameter [0:0] INV_CLKINSEL = 1'd0;
  parameter [0:0] ZINV_PWRDWN = 1'd0;
  parameter [0:0] ZINV_RST = 1'd1;

  parameter [0:0] STARTUP_WAIT = 1'd0;

  // Tables
  parameter [9:0] TABLE = 10'd0;
  parameter [39:0] LKTABLE = 40'd0;
  parameter [15:0] POWER_REG = 16'd0;
  parameter [11:0] FILTREG1_RESERVED = 12'd0;
  parameter [9:0] FILTREG2_RESERVED = 10'd0;
  parameter [5:0] LOCKREG1_RESERVED = 6'd0;
  parameter [0:0] LOCKREG2_RESERVED = 1'b0;
  parameter [0:0] LOCKREG3_RESERVED = 1'b0;

  // DIVCLK
  parameter [5:0] DIVCLK_DIVCLK_HIGH_TIME = 6'd0;
  parameter [5:0] DIVCLK_DIVCLK_LOW_TIME = 6'd0;
  parameter [0:0] DIVCLK_DIVCLK_NO_COUNT = 1'b1;
  parameter [0:0] DIVCLK_DIVCLK_EDGE = 1'b0;

  // CLKFBOUT
  parameter [5:0] CLKFBOUT_CLKOUT1_HIGH_TIME = 6'd0;
  parameter [5:0] CLKFBOUT_CLKOUT1_LOW_TIME = 6'd0;
  parameter [0:0] CLKFBOUT_CLKOUT1_OUTPUT_ENABLE = 1'b0;
  parameter [2:0] CLKFBOUT_CLKOUT1_PHASE_MUX = 3'd0;
  parameter [5:0] CLKFBOUT_CLKOUT2_DELAY_TIME = 6'd0;
  parameter [0:0] CLKFBOUT_CLKOUT2_EDGE = 1'b0;
  parameter [2:0] CLKFBOUT_CLKOUT2_FRAC = 3'd0;
  parameter [0:0] CLKFBOUT_CLKOUT2_FRAC_EN = 1'b0;
  parameter [0:0] CLKFBOUT_CLKOUT2_FRAC_WF_R = 1'b0;
  parameter [0:0] CLKFBOUT_CLKOUT2_NO_COUNT = 1'b1;

  // CLKOUT0
  parameter [5:0] CLKOUT0_CLKOUT1_HIGH_TIME = 6'd0;
  parameter [5:0] CLKOUT0_CLKOUT1_LOW_TIME = 6'd0;
  parameter [0:0] CLKOUT0_CLKOUT1_OUTPUT_ENABLE = 1'b0;
  parameter [2:0] CLKOUT0_CLKOUT1_PHASE_MUX = 3'd0;
  parameter [5:0] CLKOUT0_CLKOUT2_DELAY_TIME = 6'd0;
  parameter [0:0] CLKOUT0_CLKOUT2_EDGE = 1'b0;
  parameter [2:0] CLKOUT0_CLKOUT2_FRAC = 3'd0;
  parameter [0:0] CLKOUT0_CLKOUT2_FRAC_EN = 1'b0;
  parameter [0:0] CLKOUT0_CLKOUT2_FRAC_WF_R = 1'b0;
  parameter [0:0] CLKOUT0_CLKOUT2_NO_COUNT = 1'b1;

  // CLKOUT1
  parameter [5:0] CLKOUT1_CLKOUT1_HIGH_TIME = 6'd0;
  parameter [5:0] CLKOUT1_CLKOUT1_LOW_TIME = 6'd0;
  parameter [0:0] CLKOUT1_CLKOUT1_OUTPUT_ENABLE = 1'b0;
  parameter [2:0] CLKOUT1_CLKOUT1_PHASE_MUX = 3'd0;
  parameter [5:0] CLKOUT1_CLKOUT2_DELAY_TIME = 6'd0;
  parameter [0:0] CLKOUT1_CLKOUT2_EDGE = 1'b0;
  parameter [2:0] CLKOUT1_CLKOUT2_FRAC = 3'd0;
  parameter [0:0] CLKOUT1_CLKOUT2_FRAC_EN = 1'b0;
  parameter [0:0] CLKOUT1_CLKOUT2_FRAC_WF_R = 1'b0;
  parameter [0:0] CLKOUT1_CLKOUT2_NO_COUNT = 1'b1;

  // CLKOUT2
  parameter [5:0] CLKOUT2_CLKOUT1_HIGH_TIME = 6'd0;
  parameter [5:0] CLKOUT2_CLKOUT1_LOW_TIME = 6'd0;
  parameter [0:0] CLKOUT2_CLKOUT1_OUTPUT_ENABLE = 1'b0;
  parameter [2:0] CLKOUT2_CLKOUT1_PHASE_MUX = 3'd0;
  parameter [5:0] CLKOUT2_CLKOUT2_DELAY_TIME = 6'd0;
  parameter [0:0] CLKOUT2_CLKOUT2_EDGE = 1'b0;
  parameter [2:0] CLKOUT2_CLKOUT2_FRAC = 3'd0;
  parameter [0:0] CLKOUT2_CLKOUT2_FRAC_EN = 1'b0;
  parameter [0:0] CLKOUT2_CLKOUT2_FRAC_WF_R = 1'b0;
  parameter [0:0] CLKOUT2_CLKOUT2_NO_COUNT = 1'b1;

  // CLKOUT3
  parameter [5:0] CLKOUT3_CLKOUT1_HIGH_TIME = 6'd0;
  parameter [5:0] CLKOUT3_CLKOUT1_LOW_TIME = 6'd0;
  parameter [0:0] CLKOUT3_CLKOUT1_OUTPUT_ENABLE = 1'b0;
  parameter [2:0] CLKOUT3_CLKOUT1_PHASE_MUX = 3'd0;
  parameter [5:0] CLKOUT3_CLKOUT2_DELAY_TIME = 6'd0;
  parameter [0:0] CLKOUT3_CLKOUT2_EDGE = 1'b0;
  parameter [2:0] CLKOUT3_CLKOUT2_FRAC = 3'd0;
  parameter [0:0] CLKOUT3_CLKOUT2_FRAC_EN = 1'b0;
  parameter [0:0] CLKOUT3_CLKOUT2_FRAC_WF_R = 1'b0;
  parameter [0:0] CLKOUT3_CLKOUT2_NO_COUNT = 1'b1;

  // CLKOUT4
  parameter [5:0] CLKOUT4_CLKOUT1_HIGH_TIME = 6'd0;
  parameter [5:0] CLKOUT4_CLKOUT1_LOW_TIME = 6'd0;
  parameter [0:0] CLKOUT4_CLKOUT1_OUTPUT_ENABLE = 1'b0;
  parameter [2:0] CLKOUT4_CLKOUT1_PHASE_MUX = 3'd0;
  parameter [5:0] CLKOUT4_CLKOUT2_DELAY_TIME = 6'd0;
  parameter [0:0] CLKOUT4_CLKOUT2_EDGE = 1'b0;
  parameter [2:0] CLKOUT4_CLKOUT2_FRAC = 3'd0;
  parameter [0:0] CLKOUT4_CLKOUT2_FRAC_EN = 1'b0;
  parameter [0:0] CLKOUT4_CLKOUT2_FRAC_WF_R = 1'b0;
  parameter [0:0] CLKOUT4_CLKOUT2_NO_COUNT = 1'b1;

  // CLKOUT5
  parameter [5:0] CLKOUT5_CLKOUT1_HIGH_TIME = 6'd0;
  parameter [5:0] CLKOUT5_CLKOUT1_LOW_TIME = 6'd0;
  parameter [0:0] CLKOUT5_CLKOUT1_OUTPUT_ENABLE = 1'b0;
  parameter [2:0] CLKOUT5_CLKOUT1_PHASE_MUX = 3'd0;
  parameter [5:0] CLKOUT5_CLKOUT2_DELAY_TIME = 6'd0;
  parameter [0:0] CLKOUT5_CLKOUT2_EDGE = 1'b0;
  parameter [2:0] CLKOUT5_CLKOUT2_FRAC = 3'd0;
  parameter [0:0] CLKOUT5_CLKOUT2_FRAC_EN = 1'b0;
  parameter [0:0] CLKOUT5_CLKOUT2_FRAC_WF_R = 1'b0;
  parameter [0:0] CLKOUT5_CLKOUT2_NO_COUNT = 1'b1;


  // TODO: Compensation parameters

  // TODO: How to simulate a PLL in verilog (i.e. the VCO) ???

endmodule

// ============================================================================
// The Zynq PS7

(* blackbox *)
module PS7_VPR (
  input  [ 3: 0] DDRARB,
  input          DMA0ACLK,
  input          DMA0DAREADY,
  output [ 1: 0] DMA0DATYPE,
  output         DMA0DAVALID,
  input          DMA0DRLAST,
  output         DMA0DRREADY,
  input  [ 1: 0] DMA0DRTYPE,
  input          DMA0DRVALID,
  output         DMA0RSTN,
  input          DMA1ACLK,
  input          DMA1DAREADY,
  output [ 1: 0] DMA1DATYPE,
  output         DMA1DAVALID,
  input          DMA1DRLAST,
  output         DMA1DRREADY,
  input  [ 1: 0] DMA1DRTYPE,
  input          DMA1DRVALID,
  output         DMA1RSTN,
  input          DMA2ACLK,
  input          DMA2DAREADY,
  output [ 1: 0] DMA2DATYPE,
  output         DMA2DAVALID,
  input          DMA2DRLAST,
  output         DMA2DRREADY,
  input  [ 1: 0] DMA2DRTYPE,
  input          DMA2DRVALID,
  output         DMA2RSTN,
  input          DMA3ACLK,
  input          DMA3DAREADY,
  output [ 1: 0] DMA3DATYPE,
  output         DMA3DAVALID,
  input          DMA3DRLAST,
  output         DMA3DRREADY,
  input  [ 1: 0] DMA3DRTYPE,
  input          DMA3DRVALID,
  output         DMA3RSTN,
  input          EMIOCAN0PHYRX,
  output         EMIOCAN0PHYTX,
  input          EMIOCAN1PHYRX,
  output         EMIOCAN1PHYTX,
  input          EMIOENET0EXTINTIN,
  input          EMIOENET0GMIICOL,
  input          EMIOENET0GMIICRS,
  input          EMIOENET0GMIIRXCLK,
  input  [ 7: 0] EMIOENET0GMIIRXD,
  input          EMIOENET0GMIIRXDV,
  input          EMIOENET0GMIIRXER,
  input          EMIOENET0GMIITXCLK,
  output [ 7: 0] EMIOENET0GMIITXD,
  output         EMIOENET0GMIITXEN,
  output         EMIOENET0GMIITXER,
  input          EMIOENET0MDIOI,
  output         EMIOENET0MDIOMDC,
  output         EMIOENET0MDIOO,
  output         EMIOENET0MDIOTN,
  output         EMIOENET0PTPDELAYREQRX,
  output         EMIOENET0PTPDELAYREQTX,
  output         EMIOENET0PTPPDELAYREQRX,
  output         EMIOENET0PTPPDELAYREQTX,
  output         EMIOENET0PTPPDELAYRESPRX,
  output         EMIOENET0PTPPDELAYRESPTX,
  output         EMIOENET0PTPSYNCFRAMERX,
  output         EMIOENET0PTPSYNCFRAMETX,
  output         EMIOENET0SOFRX,
  output         EMIOENET0SOFTX,
  input          EMIOENET1EXTINTIN,
  input          EMIOENET1GMIICOL,
  input          EMIOENET1GMIICRS,
  input          EMIOENET1GMIIRXCLK,
  input  [ 7: 0] EMIOENET1GMIIRXD,
  input          EMIOENET1GMIIRXDV,
  input          EMIOENET1GMIIRXER,
  input          EMIOENET1GMIITXCLK,
  output [ 7: 0] EMIOENET1GMIITXD,
  output         EMIOENET1GMIITXEN,
  output         EMIOENET1GMIITXER,
  input          EMIOENET1MDIOI,
  output         EMIOENET1MDIOMDC,
  output         EMIOENET1MDIOO,
  output         EMIOENET1MDIOTN,
  output         EMIOENET1PTPDELAYREQRX,
  output         EMIOENET1PTPDELAYREQTX,
  output         EMIOENET1PTPPDELAYREQRX,
  output         EMIOENET1PTPPDELAYREQTX,
  output         EMIOENET1PTPPDELAYRESPRX,
  output         EMIOENET1PTPPDELAYRESPTX,
  output         EMIOENET1PTPSYNCFRAMERX,
  output         EMIOENET1PTPSYNCFRAMETX,
  output         EMIOENET1SOFRX,
  output         EMIOENET1SOFTX,
  input  [63: 0] EMIOGPIOI,
  output [63: 0] EMIOGPIOO,
  output [63: 0] EMIOGPIOTN,
  input          EMIOI2C0SCLI,
  output         EMIOI2C0SCLO,
  output         EMIOI2C0SCLTN,
  input          EMIOI2C0SDAI,
  output         EMIOI2C0SDAO,
  output         EMIOI2C0SDATN,
  input          EMIOI2C1SCLI,
  output         EMIOI2C1SCLO,
  output         EMIOI2C1SCLTN,
  input          EMIOI2C1SDAI,
  output         EMIOI2C1SDAO,
  output         EMIOI2C1SDATN,
  input          EMIOPJTAGTCK,
  input          EMIOPJTAGTDI,
  output         EMIOPJTAGTDO,
  output         EMIOPJTAGTDTN,
  input          EMIOPJTAGTMS,
  output         EMIOSDIO0BUSPOW,
  output [ 2: 0] EMIOSDIO0BUSVOLT,
  input          EMIOSDIO0CDN,
  output         EMIOSDIO0CLK,
  input          EMIOSDIO0CLKFB,
  input          EMIOSDIO0CMDI,
  output         EMIOSDIO0CMDO,
  output         EMIOSDIO0CMDTN,
  input  [ 3: 0] EMIOSDIO0DATAI,
  output [ 3: 0] EMIOSDIO0DATAO,
  output [ 3: 0] EMIOSDIO0DATATN,
  output         EMIOSDIO0LED,
  input          EMIOSDIO0WP,
  output         EMIOSDIO1BUSPOW,
  output [ 2: 0] EMIOSDIO1BUSVOLT,
  input          EMIOSDIO1CDN,
  output         EMIOSDIO1CLK,
  input          EMIOSDIO1CLKFB,
  input          EMIOSDIO1CMDI,
  output         EMIOSDIO1CMDO,
  output         EMIOSDIO1CMDTN,
  input  [ 3: 0] EMIOSDIO1DATAI,
  output [ 3: 0] EMIOSDIO1DATAO,
  output [ 3: 0] EMIOSDIO1DATATN,
  output         EMIOSDIO1LED,
  input          EMIOSDIO1WP,
  input          EMIOSPI0MI,
  output         EMIOSPI0MO,
  output         EMIOSPI0MOTN,
  input          EMIOSPI0SCLKI,
  output         EMIOSPI0SCLKO,
  output         EMIOSPI0SCLKTN,
  input          EMIOSPI0SI,
  output         EMIOSPI0SO,
  input          EMIOSPI0SSIN,
  output         EMIOSPI0SSNTN,
  output [ 2: 0] EMIOSPI0SSON,
  output         EMIOSPI0STN,
  input          EMIOSPI1MI,
  output         EMIOSPI1MO,
  output         EMIOSPI1MOTN,
  input          EMIOSPI1SCLKI,
  output         EMIOSPI1SCLKO,
  output         EMIOSPI1SCLKTN,
  input          EMIOSPI1SI,
  output         EMIOSPI1SO,
  input          EMIOSPI1SSIN,
  output         EMIOSPI1SSNTN,
  output [ 2: 0] EMIOSPI1SSON,
  output         EMIOSPI1STN,
  input          EMIOSRAMINTIN,
  input          EMIOTRACECLK,
  output         EMIOTRACECTL,
  output [31: 0] EMIOTRACEDATA,
  input  [ 2: 0] EMIOTTC0CLKI,
  output [ 2: 0] EMIOTTC0WAVEO,
  input  [ 2: 0] EMIOTTC1CLKI,
  output [ 2: 0] EMIOTTC1WAVEO,
  input          EMIOUART0CTSN,
  input          EMIOUART0DCDN,
  input          EMIOUART0DSRN,
  output         EMIOUART0DTRN,
  input          EMIOUART0RIN,
  output         EMIOUART0RTSN,
  input          EMIOUART0RX,
  output         EMIOUART0TX,
  input          EMIOUART1CTSN,
  input          EMIOUART1DCDN,
  input          EMIOUART1DSRN,
  output         EMIOUART1DTRN,
  input          EMIOUART1RIN,
  output         EMIOUART1RTSN,
  input          EMIOUART1RX,
  output         EMIOUART1TX,
  output [ 1: 0] EMIOUSB0PORTINDCTL,
  input          EMIOUSB0VBUSPWRFAULT,
  output         EMIOUSB0VBUSPWRSELECT,
  output [ 1: 0] EMIOUSB1PORTINDCTL,
  input          EMIOUSB1VBUSPWRFAULT,
  output         EMIOUSB1VBUSPWRSELECT,
  input          EMIOWDTCLKI,
  output         EMIOWDTRSTO,
  input          EVENTEVENTI,
  output         EVENTEVENTO,
  output [ 1: 0] EVENTSTANDBYWFE,
  output [ 1: 0] EVENTSTANDBYWFI,
  output [ 3: 0] FCLKCLK,
  input  [ 3: 0] FCLKCLKTRIGN,
  output [ 3: 0] FCLKRESETN,
  input          FPGAIDLEN,
  input  [ 3: 0] FTMDTRACEINATID,
  input          FTMDTRACEINCLOCK,
  input  [31: 0] FTMDTRACEINDATA,
  input          FTMDTRACEINVALID,
  input  [31: 0] FTMTF2PDEBUG,
  input  [ 3: 0] FTMTF2PTRIG,
  output [ 3: 0] FTMTF2PTRIGACK,
  output [31: 0] FTMTP2FDEBUG,
  output [ 3: 0] FTMTP2FTRIG,
  input  [ 3: 0] FTMTP2FTRIGACK,
  input  [19: 0] IRQF2P,
  output [28: 0] IRQP2F,
  input          MAXIGP0ACLK,
  output [31: 0] MAXIGP0ARADDR,
  output [ 1: 0] MAXIGP0ARBURST,
  output [ 3: 0] MAXIGP0ARCACHE,
  output         MAXIGP0ARESETN,
  output [11: 0] MAXIGP0ARID,
  output [ 3: 0] MAXIGP0ARLEN,
  output [ 1: 0] MAXIGP0ARLOCK,
  output [ 2: 0] MAXIGP0ARPROT,
  output [ 3: 0] MAXIGP0ARQOS,
  input          MAXIGP0ARREADY,
  output [ 1: 0] MAXIGP0ARSIZE,
  output         MAXIGP0ARVALID,
  output [31: 0] MAXIGP0AWADDR,
  output [ 1: 0] MAXIGP0AWBURST,
  output [ 3: 0] MAXIGP0AWCACHE,
  output [11: 0] MAXIGP0AWID,
  output [ 3: 0] MAXIGP0AWLEN,
  output [ 1: 0] MAXIGP0AWLOCK,
  output [ 2: 0] MAXIGP0AWPROT,
  output [ 3: 0] MAXIGP0AWQOS,
  input          MAXIGP0AWREADY,
  output [ 1: 0] MAXIGP0AWSIZE,
  output         MAXIGP0AWVALID,
  input  [11: 0] MAXIGP0BID,
  output         MAXIGP0BREADY,
  input  [ 1: 0] MAXIGP0BRESP,
  input          MAXIGP0BVALID,
  input  [31: 0] MAXIGP0RDATA,
  input  [11: 0] MAXIGP0RID,
  input          MAXIGP0RLAST,
  output         MAXIGP0RREADY,
  input  [ 1: 0] MAXIGP0RRESP,
  input          MAXIGP0RVALID,
  output [31: 0] MAXIGP0WDATA,
  output [11: 0] MAXIGP0WID,
  output         MAXIGP0WLAST,
  input          MAXIGP0WREADY,
  output [ 3: 0] MAXIGP0WSTRB,
  output         MAXIGP0WVALID,
  input          MAXIGP1ACLK,
  output [31: 0] MAXIGP1ARADDR,
  output [ 1: 0] MAXIGP1ARBURST,
  output [ 3: 0] MAXIGP1ARCACHE,
  output         MAXIGP1ARESETN,
  output [11: 0] MAXIGP1ARID,
  output [ 3: 0] MAXIGP1ARLEN,
  output [ 1: 0] MAXIGP1ARLOCK,
  output [ 2: 0] MAXIGP1ARPROT,
  output [ 3: 0] MAXIGP1ARQOS,
  input          MAXIGP1ARREADY,
  output [ 1: 0] MAXIGP1ARSIZE,
  output         MAXIGP1ARVALID,
  output [31: 0] MAXIGP1AWADDR,
  output [ 1: 0] MAXIGP1AWBURST,
  output [ 3: 0] MAXIGP1AWCACHE,
  output [11: 0] MAXIGP1AWID,
  output [ 3: 0] MAXIGP1AWLEN,
  output [ 1: 0] MAXIGP1AWLOCK,
  output [ 2: 0] MAXIGP1AWPROT,
  output [ 3: 0] MAXIGP1AWQOS,
  input          MAXIGP1AWREADY,
  output [ 1: 0] MAXIGP1AWSIZE,
  output         MAXIGP1AWVALID,
  input  [11: 0] MAXIGP1BID,
  output         MAXIGP1BREADY,
  input  [ 1: 0] MAXIGP1BRESP,
  input          MAXIGP1BVALID,
  input  [31: 0] MAXIGP1RDATA,
  input  [11: 0] MAXIGP1RID,
  input          MAXIGP1RLAST,
  output         MAXIGP1RREADY,
  input  [ 1: 0] MAXIGP1RRESP,
  input          MAXIGP1RVALID,
  output [31: 0] MAXIGP1WDATA,
  output [11: 0] MAXIGP1WID,
  output         MAXIGP1WLAST,
  input          MAXIGP1WREADY,
  output [ 3: 0] MAXIGP1WSTRB,
  output         MAXIGP1WVALID,
  input          SAXIACPACLK,
  input  [31: 0] SAXIACPARADDR,
  input  [ 1: 0] SAXIACPARBURST,
  input  [ 3: 0] SAXIACPARCACHE,
  output         SAXIACPARESETN,
  input  [ 2: 0] SAXIACPARID,
  input  [ 3: 0] SAXIACPARLEN,
  input  [ 1: 0] SAXIACPARLOCK,
  input  [ 2: 0] SAXIACPARPROT,
  input  [ 3: 0] SAXIACPARQOS,
  output         SAXIACPARREADY,
  input  [ 1: 0] SAXIACPARSIZE,
  input  [ 4: 0] SAXIACPARUSER,
  input          SAXIACPARVALID,
  input  [31: 0] SAXIACPAWADDR,
  input  [ 1: 0] SAXIACPAWBURST,
  input  [ 3: 0] SAXIACPAWCACHE,
  input  [ 2: 0] SAXIACPAWID,
  input  [ 3: 0] SAXIACPAWLEN,
  input  [ 1: 0] SAXIACPAWLOCK,
  input  [ 2: 0] SAXIACPAWPROT,
  input  [ 3: 0] SAXIACPAWQOS,
  output         SAXIACPAWREADY,
  input  [ 1: 0] SAXIACPAWSIZE,
  input  [ 4: 0] SAXIACPAWUSER,
  input          SAXIACPAWVALID,
  output [ 2: 0] SAXIACPBID,
  input          SAXIACPBREADY,
  output [ 1: 0] SAXIACPBRESP,
  output         SAXIACPBVALID,
  output [63: 0] SAXIACPRDATA,
  output [ 2: 0] SAXIACPRID,
  output         SAXIACPRLAST,
  input          SAXIACPRREADY,
  output [ 1: 0] SAXIACPRRESP,
  output         SAXIACPRVALID,
  input  [63: 0] SAXIACPWDATA,
  input  [ 2: 0] SAXIACPWID,
  input          SAXIACPWLAST,
  output         SAXIACPWREADY,
  input  [ 7: 0] SAXIACPWSTRB,
  input          SAXIACPWVALID,
  input          SAXIGP0ACLK,
  input  [31: 0] SAXIGP0ARADDR,
  input  [ 1: 0] SAXIGP0ARBURST,
  input  [ 3: 0] SAXIGP0ARCACHE,
  output         SAXIGP0ARESETN,
  input  [ 5: 0] SAXIGP0ARID,
  input  [ 3: 0] SAXIGP0ARLEN,
  input  [ 1: 0] SAXIGP0ARLOCK,
  input  [ 2: 0] SAXIGP0ARPROT,
  input  [ 3: 0] SAXIGP0ARQOS,
  output         SAXIGP0ARREADY,
  input  [ 1: 0] SAXIGP0ARSIZE,
  input          SAXIGP0ARVALID,
  input  [31: 0] SAXIGP0AWADDR,
  input  [ 1: 0] SAXIGP0AWBURST,
  input  [ 3: 0] SAXIGP0AWCACHE,
  input  [ 5: 0] SAXIGP0AWID,
  input  [ 3: 0] SAXIGP0AWLEN,
  input  [ 1: 0] SAXIGP0AWLOCK,
  input  [ 2: 0] SAXIGP0AWPROT,
  input  [ 3: 0] SAXIGP0AWQOS,
  output         SAXIGP0AWREADY,
  input  [ 1: 0] SAXIGP0AWSIZE,
  input          SAXIGP0AWVALID,
  output [ 5: 0] SAXIGP0BID,
  input          SAXIGP0BREADY,
  output [ 1: 0] SAXIGP0BRESP,
  output         SAXIGP0BVALID,
  output [31: 0] SAXIGP0RDATA,
  output [ 5: 0] SAXIGP0RID,
  output         SAXIGP0RLAST,
  input          SAXIGP0RREADY,
  output [ 1: 0] SAXIGP0RRESP,
  output         SAXIGP0RVALID,
  input  [31: 0] SAXIGP0WDATA,
  input  [ 5: 0] SAXIGP0WID,
  input          SAXIGP0WLAST,
  output         SAXIGP0WREADY,
  input  [ 3: 0] SAXIGP0WSTRB,
  input          SAXIGP0WVALID,
  input          SAXIGP1ACLK,
  input  [31: 0] SAXIGP1ARADDR,
  input  [ 1: 0] SAXIGP1ARBURST,
  input  [ 3: 0] SAXIGP1ARCACHE,
  output         SAXIGP1ARESETN,
  input  [ 5: 0] SAXIGP1ARID,
  input  [ 3: 0] SAXIGP1ARLEN,
  input  [ 1: 0] SAXIGP1ARLOCK,
  input  [ 2: 0] SAXIGP1ARPROT,
  input  [ 3: 0] SAXIGP1ARQOS,
  output         SAXIGP1ARREADY,
  input  [ 1: 0] SAXIGP1ARSIZE,
  input          SAXIGP1ARVALID,
  input  [31: 0] SAXIGP1AWADDR,
  input  [ 1: 0] SAXIGP1AWBURST,
  input  [ 3: 0] SAXIGP1AWCACHE,
  input  [ 5: 0] SAXIGP1AWID,
  input  [ 3: 0] SAXIGP1AWLEN,
  input  [ 1: 0] SAXIGP1AWLOCK,
  input  [ 2: 0] SAXIGP1AWPROT,
  input  [ 3: 0] SAXIGP1AWQOS,
  output         SAXIGP1AWREADY,
  input  [ 1: 0] SAXIGP1AWSIZE,
  input          SAXIGP1AWVALID,
  output [ 5: 0] SAXIGP1BID,
  input          SAXIGP1BREADY,
  output [ 1: 0] SAXIGP1BRESP,
  output         SAXIGP1BVALID,
  output [31: 0] SAXIGP1RDATA,
  output [ 5: 0] SAXIGP1RID,
  output         SAXIGP1RLAST,
  input          SAXIGP1RREADY,
  output [ 1: 0] SAXIGP1RRESP,
  output         SAXIGP1RVALID,
  input  [31: 0] SAXIGP1WDATA,
  input  [ 5: 0] SAXIGP1WID,
  input          SAXIGP1WLAST,
  output         SAXIGP1WREADY,
  input  [ 3: 0] SAXIGP1WSTRB,
  input          SAXIGP1WVALID,
  input          SAXIHP0ACLK,
  input  [31: 0] SAXIHP0ARADDR,
  input  [ 1: 0] SAXIHP0ARBURST,
  input  [ 3: 0] SAXIHP0ARCACHE,
  output         SAXIHP0ARESETN,
  input  [ 5: 0] SAXIHP0ARID,
  input  [ 3: 0] SAXIHP0ARLEN,
  input  [ 1: 0] SAXIHP0ARLOCK,
  input  [ 2: 0] SAXIHP0ARPROT,
  input  [ 3: 0] SAXIHP0ARQOS,
  output         SAXIHP0ARREADY,
  input  [ 1: 0] SAXIHP0ARSIZE,
  input          SAXIHP0ARVALID,
  input  [31: 0] SAXIHP0AWADDR,
  input  [ 1: 0] SAXIHP0AWBURST,
  input  [ 3: 0] SAXIHP0AWCACHE,
  input  [ 5: 0] SAXIHP0AWID,
  input  [ 3: 0] SAXIHP0AWLEN,
  input  [ 1: 0] SAXIHP0AWLOCK,
  input  [ 2: 0] SAXIHP0AWPROT,
  input  [ 3: 0] SAXIHP0AWQOS,
  output         SAXIHP0AWREADY,
  input  [ 1: 0] SAXIHP0AWSIZE,
  input          SAXIHP0AWVALID,
  output [ 5: 0] SAXIHP0BID,
  input          SAXIHP0BREADY,
  output [ 1: 0] SAXIHP0BRESP,
  output         SAXIHP0BVALID,
  output [ 2: 0] SAXIHP0RACOUNT,
  output [ 7: 0] SAXIHP0RCOUNT,
  output [63: 0] SAXIHP0RDATA,
  input          SAXIHP0RDISSUECAP1EN,
  output [ 5: 0] SAXIHP0RID,
  output         SAXIHP0RLAST,
  input          SAXIHP0RREADY,
  output [ 1: 0] SAXIHP0RRESP,
  output         SAXIHP0RVALID,
  output [ 5: 0] SAXIHP0WACOUNT,
  output [ 7: 0] SAXIHP0WCOUNT,
  input  [63: 0] SAXIHP0WDATA,
  input  [ 5: 0] SAXIHP0WID,
  input          SAXIHP0WLAST,
  output         SAXIHP0WREADY,
  input          SAXIHP0WRISSUECAP1EN,
  input  [ 7: 0] SAXIHP0WSTRB,
  input          SAXIHP0WVALID,
  input          SAXIHP1ACLK,
  input  [31: 0] SAXIHP1ARADDR,
  input  [ 1: 0] SAXIHP1ARBURST,
  input  [ 3: 0] SAXIHP1ARCACHE,
  output         SAXIHP1ARESETN,
  input  [ 5: 0] SAXIHP1ARID,
  input  [ 3: 0] SAXIHP1ARLEN,
  input  [ 1: 0] SAXIHP1ARLOCK,
  input  [ 2: 0] SAXIHP1ARPROT,
  input  [ 3: 0] SAXIHP1ARQOS,
  output         SAXIHP1ARREADY,
  input  [ 1: 0] SAXIHP1ARSIZE,
  input          SAXIHP1ARVALID,
  input  [31: 0] SAXIHP1AWADDR,
  input  [ 1: 0] SAXIHP1AWBURST,
  input  [ 3: 0] SAXIHP1AWCACHE,
  input  [ 5: 0] SAXIHP1AWID,
  input  [ 3: 0] SAXIHP1AWLEN,
  input  [ 1: 0] SAXIHP1AWLOCK,
  input  [ 2: 0] SAXIHP1AWPROT,
  input  [ 3: 0] SAXIHP1AWQOS,
  output         SAXIHP1AWREADY,
  input  [ 1: 0] SAXIHP1AWSIZE,
  input          SAXIHP1AWVALID,
  output [ 5: 0] SAXIHP1BID,
  input          SAXIHP1BREADY,
  output [ 1: 0] SAXIHP1BRESP,
  output         SAXIHP1BVALID,
  output [ 2: 0] SAXIHP1RACOUNT,
  output [ 7: 0] SAXIHP1RCOUNT,
  output [63: 0] SAXIHP1RDATA,
  input          SAXIHP1RDISSUECAP1EN,
  output [ 5: 0] SAXIHP1RID,
  output         SAXIHP1RLAST,
  input          SAXIHP1RREADY,
  output [ 1: 0] SAXIHP1RRESP,
  output         SAXIHP1RVALID,
  output [ 5: 0] SAXIHP1WACOUNT,
  output [ 7: 0] SAXIHP1WCOUNT,
  input  [63: 0] SAXIHP1WDATA,
  input  [ 5: 0] SAXIHP1WID,
  input          SAXIHP1WLAST,
  output         SAXIHP1WREADY,
  input          SAXIHP1WRISSUECAP1EN,
  input  [ 7: 0] SAXIHP1WSTRB,
  input          SAXIHP1WVALID,
  input          SAXIHP2ACLK,
  input  [31: 0] SAXIHP2ARADDR,
  input  [ 1: 0] SAXIHP2ARBURST,
  input  [ 3: 0] SAXIHP2ARCACHE,
  output         SAXIHP2ARESETN,
  input  [ 5: 0] SAXIHP2ARID,
  input  [ 3: 0] SAXIHP2ARLEN,
  input  [ 1: 0] SAXIHP2ARLOCK,
  input  [ 2: 0] SAXIHP2ARPROT,
  input  [ 3: 0] SAXIHP2ARQOS,
  output         SAXIHP2ARREADY,
  input  [ 1: 0] SAXIHP2ARSIZE,
  input          SAXIHP2ARVALID,
  input  [31: 0] SAXIHP2AWADDR,
  input  [ 1: 0] SAXIHP2AWBURST,
  input  [ 3: 0] SAXIHP2AWCACHE,
  input  [ 5: 0] SAXIHP2AWID,
  input  [ 3: 0] SAXIHP2AWLEN,
  input  [ 1: 0] SAXIHP2AWLOCK,
  input  [ 2: 0] SAXIHP2AWPROT,
  input  [ 3: 0] SAXIHP2AWQOS,
  output         SAXIHP2AWREADY,
  input  [ 1: 0] SAXIHP2AWSIZE,
  input          SAXIHP2AWVALID,
  output [ 5: 0] SAXIHP2BID,
  input          SAXIHP2BREADY,
  output [ 1: 0] SAXIHP2BRESP,
  output         SAXIHP2BVALID,
  output [ 2: 0] SAXIHP2RACOUNT,
  output [ 7: 0] SAXIHP2RCOUNT,
  output [63: 0] SAXIHP2RDATA,
  input          SAXIHP2RDISSUECAP1EN,
  output [ 5: 0] SAXIHP2RID,
  output         SAXIHP2RLAST,
  input          SAXIHP2RREADY,
  output [ 1: 0] SAXIHP2RRESP,
  output         SAXIHP2RVALID,
  output [ 5: 0] SAXIHP2WACOUNT,
  output [ 7: 0] SAXIHP2WCOUNT,
  input  [63: 0] SAXIHP2WDATA,
  input  [ 5: 0] SAXIHP2WID,
  input          SAXIHP2WLAST,
  output         SAXIHP2WREADY,
  input          SAXIHP2WRISSUECAP1EN,
  input  [ 7: 0] SAXIHP2WSTRB,
  input          SAXIHP2WVALID,
  input          SAXIHP3ACLK,
  input  [31: 0] SAXIHP3ARADDR,
  input  [ 1: 0] SAXIHP3ARBURST,
  input  [ 3: 0] SAXIHP3ARCACHE,
  output         SAXIHP3ARESETN,
  input  [ 5: 0] SAXIHP3ARID,
  input  [ 3: 0] SAXIHP3ARLEN,
  input  [ 1: 0] SAXIHP3ARLOCK,
  input  [ 2: 0] SAXIHP3ARPROT,
  input  [ 3: 0] SAXIHP3ARQOS,
  output         SAXIHP3ARREADY,
  input  [ 1: 0] SAXIHP3ARSIZE,
  input          SAXIHP3ARVALID,
  input  [31: 0] SAXIHP3AWADDR,
  input  [ 1: 0] SAXIHP3AWBURST,
  input  [ 3: 0] SAXIHP3AWCACHE,
  input  [ 5: 0] SAXIHP3AWID,
  input  [ 3: 0] SAXIHP3AWLEN,
  input  [ 1: 0] SAXIHP3AWLOCK,
  input  [ 2: 0] SAXIHP3AWPROT,
  input  [ 3: 0] SAXIHP3AWQOS,
  output         SAXIHP3AWREADY,
  input  [ 1: 0] SAXIHP3AWSIZE,
  input          SAXIHP3AWVALID,
  output [ 5: 0] SAXIHP3BID,
  input          SAXIHP3BREADY,
  output [ 1: 0] SAXIHP3BRESP,
  output         SAXIHP3BVALID,
  output [ 2: 0] SAXIHP3RACOUNT,
  output [ 7: 0] SAXIHP3RCOUNT,
  output [63: 0] SAXIHP3RDATA,
  input          SAXIHP3RDISSUECAP1EN,
  output [ 5: 0] SAXIHP3RID,
  output         SAXIHP3RLAST,
  input          SAXIHP3RREADY,
  output [ 1: 0] SAXIHP3RRESP,
  output         SAXIHP3RVALID,
  output [ 5: 0] SAXIHP3WACOUNT,
  output [ 7: 0] SAXIHP3WCOUNT,
  input  [63: 0] SAXIHP3WDATA,
  input  [ 5: 0] SAXIHP3WID,
  input          SAXIHP3WLAST,
  output         SAXIHP3WREADY,
  input          SAXIHP3WRISSUECAP1EN,
  input  [ 7: 0] SAXIHP3WSTRB,
  input          SAXIHP3WVALID
);

endmodule

