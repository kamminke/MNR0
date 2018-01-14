//  ***********     MNR0 (Monero Hardware Wallet)       ***************
//
//      File:       MNR0/Sources/verilog/iCE40HX4k_cb132.v
//
//      Purpose:    Target iCE40HX with 4k @ CB132 Package
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
//                          MODULE
//  -------------------------------------------------------------------

module iCE40HX4k_cb132 (

    //  --------    Bank 0  ------------------------

    inout           IOT_225                 // A1
    //inout           IOT_223,                // A2
    //inout           IOT_222,                // A3
    //inout           IOT_219,                // A4
    //inout           IOT_208,                // A5
    //inout           IOT_198_GBIN0,          // A6
    //inout           IOT_197_GBIN1,          // A7
    //inout           IOT_181,                // A10
    //inout           IOT_179,                // A11
    //inout           IOT_170,                // A12
    //
    //inout           IOT_221,                // C4
    //inout           IOT_212,                // C5
    //inout           IOT_206,                // C6
    //inout           IOT_200,                // C7
    //inout           IOT_190,                // C9
    //inout           IOT_186,                // C10
    //inout           IOT_174,                // C11
    //inout           IOT_172,                // C12
    //
    //inout           IOT_211,                // D5
    //inout           IOT_207,                // D6
    //inout           IOT_202,                // D7
    //inout           IOT_188,                // D9
    //inout           IOT_177,                // D10
    //inout           IOT_178,                // D11

    //  --------    Bank 1  ------------------------

    //inout           IOR_161,                // B14
    //
    //inout           IOR_154,                // C14
    //
    //inout           IOR_160,                // D12
    //inout           IOR_152,                // D14
    //
    //inout           IOR_146,                // E11
    //inout           IOR_147,                // E12
    //inout           IOR_148,                // E14
    //
    //inout           IOR_144,                // F11
    //inout           IOR_137,                // F12
    //inout           IOR_140_GBIN3,          // F14
    //
    //inout           IOR_136,                // G11
    //inout           IOR_129,                // G12
    //inout           IOR_141_GBIN2,          // G14
    //
    //inout           IOR_128,                // H11
    //inout           IOR_120,                // H12
    //
    //inout           IOR_119,                // J11
    //inout           IOR_118,                // J12
    //
    //inout           IOR_116,                // K11
    //inout           IOR_115,                // K12
    //inout           IOR_117,                // K14
    //
    //inout           IOR_111,                // L12
    //inout           IOR_114,                // L14
    //
    //inout           IOR_109,                // M12
    //
    //inout           IOR_112,                // N14
    //
    //inout           IOR_110,                // P14

    //  --------    Bank 2  ------------------------

    //inout           IOB_72,                 // L4
    //inout           IOB_71,                 // L5
    //inout           IOB_78,                 // L6
    //inout           IOB_87,                 // L8
    //inout           IOB_103_CBSEL0,         // L9
    //input           CRESET_B,               // L10
    //
    //inout           IOB_64,                 // M3
    //inout           IOB_63,                 // M4
    //inout           IOB_77,                 // M6
    //inout           IOB_79,                 // M7
    //inout           IOB_91,                 // M9
    //inout         CDONE,                  // M10
    //
    //inout           IOB_56,                 // P2
    //inout           IOB_59,                 // P3
    //inout           IOB_73,                 // P4
    //inout           IOB_74,                 // P5
    //inout           IOB_81_GBIN5,           // P7
    //inout           IOB_82_GBIN4,           // P8
    //inout           IOB_89,                 // P9
    //inout           IOB_104_CBSEL1,         // P10

    //  --------    Bank 3  ------------------------

    //inout           IOL_2A,                 // B1
    //
    //inout           IOL_2B,                 // C1
    //inout           IOL_4A,                 // C3
    //
    //inout           IOL_5A,                 // D1
    //inout           IOL_4B,                 // D3
    //inout           IOL_8A,                 // D4
    //
    //inout           IOL_5B,                 // E1
    //inout           IOL_8B,                 // E4
    //
    //inout           IOL_9B,                 // F3
    //inout           IOL_9A,                 // F4
    //
    //inout           IOL_13B_GBIN7,          // G1
    //inout           IOL_13A,                // G3
    //inout           IOL_10B,                // G4
    //
    //inout           IOL_14A_GBIN6,          // H1
    //inout           IOL_14B,                // H3
    //inout           IOL_10A,                // H4
    //
    //inout           IOL_12B,                // J1
    //inout           IOL_12A,                // J3
    //
    //inout           IOL_18A,                // K3
    //inout           IOL_18B,                // K4
    //
    //inout           IOL_23A,                // L1
    //
    //inout           IOL_23B,                // M1
    //
    //inout           IOL_25A,                // N1
    //
    //inout           IOL_25B,                // P1

    //  --------    Configuration   ----------------

    //inout           IOB_105_SDO,            // M11
    //
    //inout           IOB_106_SDI,            // P11
    //inout           IOB_107_SCK,            // P12
    //inout           IOB_108_SS              // P13
);

//  ------------    core instatiation   -------------------------------

MNR0_core u_mnr0_core (

    //  --------    globals     --------------------

    .clk_extclk         (clk_extclk),
    .rst_extrst_n       (rst_extrst_n)
);

endmodule
