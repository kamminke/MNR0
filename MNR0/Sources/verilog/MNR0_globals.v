//  ***********     MNR0 (Monero Hardware Wallet)       ***************
//
//      File:       MNR0/Sources/verilog/MNR0_globals.v
//
//      Purpose:    Generate global (chip) signals, Clock and Reset
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
//                          DESCRIPTION
//  -------------------------------------------------------------------

//  SECURITY ADVICE:
//      THIS PHASE-LOCKED LOOP (PLL) IS A SECURITY FEATURE - USE IT!
//
//  As long as the PLL is not locked, the internal Reset is active.
//  Please check the reset assignment from lock.
//
//  This means, as soon as the chip is under attack by clock-glitching,
//  the PLL lost her locked state and the internal Reset gets active.
//  No unsecure / undefined state for internal registers anymore.

`include "timescale.v"

module MNR0_globals (

    input               clk_extclk,         // external clock
    input               rst_extrst_n,       // external low-active reset
    output              clk_intclk,         // internal clock
    output              rst_intrst);        // internal high-active reset

//  ------------    PLL instantiation   -------------------------------

    wire                w_lock;             // pll lock output

SB_PLL40_CORE # (
    .FEEDBACK_PATH      ("SIMPLE"),
    .PLLOUT_SELECT      ("GENCLK"),
    .DIVR               (4'b0000),
    .DIVF               (7'b100_1111),
    .DIVQ               (3'b000),
    .FILTER_RANGE       (3'b001)
) u_pll (
    .LOCK               (w_lock),
    .RESETB             (rst_extrst_n),
    .BYPASS             (1'b0),
    .REFERENCECLK       (clk_extclk),
    .PLLOUTCORE         (clk_intclk)
);

//  ------------    Output matching     -------------------------------

    assign rst_intrst = ~w_lock;            // reset whole chip

endmodule
