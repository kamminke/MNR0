//  ***********     MNR0 (Monero Hardware Wallet)       ***************
//
//      File:       MNR0/Sources/verilog/MNR0_cpu.v
//
//      Purpose:    Main file for a small controller core
//
//  ************    IEEE Std 1364-2001 (Verilog HDL)    ***************
//
//  Copyright (c) 2017 by kamminke <kamminke@posteo.ee>
//  All rights reserved.
//
//  Redistribution and use in souce and binary form, with or without
//  modification, are permitted provided that the following conditions are met:
//
//  * Redistributions of souce code must retain the above copyright notice, this
//    list of conditions and the following disclaimer.
//
//  * Redistributions of binary form must reproduce the above copyright notice,
//    this list of conditions and the following disclaimer in the documentation
//    and/or other materials provided with the distribution.
//
//  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
//  AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
//  IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PRUPOSE ARE
//  DISCLAINED. IN  NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE LIABLE
//  FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
//  DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SBSTITUTE GOODS OR
//  SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER
//  CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY,
//  OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE
//  OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.

//  -------------------------------------------------------------------
//                          CONFIGURATION
//  -------------------------------------------------------------------

//  ----------------    Configuration Switches  -----------------------

//  `define             WB_B4_COMP      1   // Wishbone Rev.B4 compatible
//  `ifdef WB_B4_COMP
//      `define         WB_B3_COMP      1   // Wishbone Rev.B3 compatible
//  `endif //WB_B4_COMP
//
//  `define             WB_B3_COMP      1   // Wishbone Rev.B3 compatible
//  `ifdef WB_B3_COMP
//      `define         WB_TAGS         1   // enable Rev.B3 tag lines
//      `define         WB_BURST        1   // enable Rev.B3 burst lines
//  `endif //WB_B3_COMP
//
//  `define             WB_B2_COMP      1   // Wishbone Rev.B2 compatible
//  `define             WB_B1_COMP      1   // * do not use anymore *

//  ----------------    Platform Switches   ---------------------------

//  `define             CODINGSTYLE_FPGA 1  // less global signal usage

//  ----------------    Debug Switches      ---------------------------

//  `define             TALKATIVE_MNR0  1   // be more talkative

//  -------------------------------------------------------------------
//                      DESCRIPTION
//  -------------------------------------------------------------------

//  This cute small CPU core is used for protocoll handling only.
//
//  SECURITY ADVICE:
//      DO NOT USE THIS CORE FOR COMPUTING ANY CRYPTOGRAPHY!
//
//  Any cryptograhpy is vulnerable on CPUs by power-analysis, because
//  every instruction takes a unique quantity of power. Executed branches
//  are very easy recognizable while taking much more power than other
//  instructions or not executed branches. Reasons are at least branch
//  predictions, pipeline flushes etc.

//  Attackes - which know the cryptographic algorithm - can simply count
//  clock cycles between branch peaks to know the next branch was taken
//  or not.

`include "timescale.v"

module MNR0_cpu # (
    parameter           p_adr = 10,         // number of Address lines
                        p_tga = 1,          // number of Address Tag lines
                        p_dat = 32,         // number of Data lines
                        p_tgd = 1,          // number of Data Tag lines
                        p_tag = 1,          // number of old-style Tag lines
                        p_sel = p_dat / 8,  // number of Data Select lines
                        p_tgc = 1)          // number of Cycle Tag lines

(   //  --------    Wishbone Bus Interface  --------

    output [p_adr-1:0]  o_wbm_adr,          // ADR_O()
`ifdef WB_B3_COMP
`ifdef WB_TAGS
    output [p_tga-1:0]  o_wbm_tga,          // TGA_O()
`endif //WB_TAGS
`endif //WB_B3_COMP
    input [p_dat-1:0]   i_wbm_dat_s2m,      // DAT_I()
    output [p_dat-1:0]  o_wbm_dat_m2s,      // DAT_O()
`ifdef WB_B3_COMP
`ifdef WB_TAGS
    input [p_tgd-1:0]   i_wbm_tgd_s2m,      // TGD_I()
    output [p_tgd-1:0]  o_wbm_tgd_m2s,      // TGD_O()
`endif //WB_TAGS
`else
    input [p_tgd-1:0]   i_wbm_tagn_s2m,     // TAGN_I()
    output [p_tgd-1:0]  o_wbm_tagn_m2s,     // TAGN_O()
`endif //WB_B3_COMP
    output [p_sel-1:0]  o_wbm_sel,          // SEL_O()

    output              o_wbm_we,           // WE_O
    output              o_wbm_stb,          // STB_O
    output              o_wbm_cyc,          // CYC_O
`ifdef WB_B3_COMP
`ifdef WB_TAGS
    output [p_tgc-1:0]  o_wbm_tgc,          // TGC_O()
`endif //WB_TAGS
`ifdef WB_BURST
    output [2:0]        o_wbm_cti,          // CTI_O()
    output [1:0]        o_wbm_bte,          // BTE_O()
`endif //WB_BURST
    output              o_wbm_lock,         // LOCK_O
`endif //WB_B3_COMP

`ifdef WB_B4_COMP
    input               i_wbm_stall,        // STALL_I
`endif //WB_B4_COMP
    input               i_wbm_ack,          // ACK_I
    input               i_wbm_err,          // ERR_I
    input               i_wbm_rty,          // RTY_I

    input               clk_wbm,            // CLK_I()
    input               rst_wbm);           // RST_I()

//  ------------    instantiation       -------------------------------

//rv32e_core # (
//) u_rv32e (
//);

endmodule
