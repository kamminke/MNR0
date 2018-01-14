//  ***********     MNR0 (Monero Hardware Wallet)       ***************
//
//      File:       MNR0/Sources/verilog/iCE40LP8k_cm81.v
//
//      Purpose:    Target iCE40LP with 8k @ CM81 Package
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

module iCE40LP8k_cm81 (

    //  --------    Bank 0  ------------------------

    inout           IOT_224,                // A1
    inout           IOT_221,                // A2
    inout           IOT_217,                // A3
    inout           IOT_208,                // A4
    inout           IOT_185,                // A6
    inout           IOT_177,                // A7
    inout           IOT_174,                // A8
    //
    inout           IOT_218,                // B3
    inout           IOT_211,                // B4
    inout           IOT_188,                // B5
    inout           IOT_183,                // B6
    inout           IOT_180,                // B7
    inout           IOT_170,                // B8
    //
    inout           IOT_198_GBIN0,          // C4
    inout           IOT_197_GBIN1,          // C5
    //
    inout           IOT_212,                // D5
    //
    inout           IOT_214,                // E5

    //  --------    Bank 1  ------------------------

    inout           IOR_116,                // A9
    //
    inout           IOR_120,                // B9
    //
    inout           IOR_148,                // C9
    //
    inout           IOR_115,                // D6
    inout           IOR_117,                // D7
    inout           IOR_141_GBIN2,          // D8
    inout           IOR_119,                // D9
    //
    inout           IOR_118,                // E7
    inout           IOR_140_GBIN3,          // E8
    //
    inout           IOR_113,                // F8
    //
    inout           IOR_114,                // G8
    inout           IOR_112,                // G9
    //
    inout           IOR_111,                // H9
    //
    inout           IOR_109,                // J8
    inout           IOR_110,                // J9

    //  --------    Bank 2  ------------------------

    //inout         CDONE,                  // E6
    //
    inout           IOB_81_GBIN5,           // G4
    inout           IOB_103_CBSEL0,         // G5
    //
    inout           IOB_54,                 // H1
    inout           IOB_82_GBIN4,           // H4
    inout           IOB_104_CBSEL1,         // H5
    inout           CRESET_B,               // H6
    //
    inout           IOB_55,                 // J1
    inout           IOB_56,                 // J2
    inout           IOB_57,                 // J3
    inout           IOB_70,                 // J4
    
    //  --------    Bank 3  ------------------------

    inout           IOL_3A,                 // B1
    inout           IOL_2B,                 // B2
    //
    inout           IOL_3B,                 // C1
    inout           IOL_2A,                 // C2
    inout           IOL_7B,                 // C3
    //
    inout           IOL_10A,                // D1
    inout           IOL_7A,                 // D2
    inout           IOL_13B_GBIN7,          // D3
    //
    inout           IOL_10B,                // E1
    inout           IOL_13A,                // E2
    inout           IOL_14A_GBIN6,          // E3
    inout           IOL_14B,                // E4
    //
    inout           IOL_22A,                // F1
    inout           IOL_22B,                // F3
    //
    inout           IOL_24B,                // G1
    inout           IOL_26A,                // G2
    inout           IOL_24A,                // G3
    //
    inout           IOL_26B,                // H2

    //  --------    Configuration   ----------------

    inout           IOB_108_SS,             // F7
    //
    inout           IOB_105_SDO,            // G6
    inout           IOB_107_SCK,            // G7
    //
    inout               IOB_106_SDI         // H7
);

//  ------------    core instatiation   -------------------------------

MNR0_core u_mnr0_core (

    //  --------    globals     --------------------

    .clk_extclk         (clk_extclk),
    .rst_extrst_n       (rst_extrst_n)
);

endmodule
