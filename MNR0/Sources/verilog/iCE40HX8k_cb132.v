//  ***********     MNR0 (Monero Hardware Wallet)       ***************
//
//      File:       MNR0/Sources/verilog/iCE40HX8k_cb132.v
//
//      Purpose:    Target iCE40HX with 8k @ CB132 Package
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

module iCE40HX8k_cb132 (

    //  --------    Bank 0  ------------------------

    inout               IOT_225,            // A1
    inout               IOT_223,            // A2
    inout               IOT_222,            // A3
    inout               IOT_219,            // A4
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

    inout           IOR_161,                // B14
    //
    inout           IOR_154,                // C14
    //
    inout           IOR_160,                // D12
    inout           IOR_152,                // D14
    //
    inout           IOR_146,                // E11
    inout           IOR_147,                // E12
    inout           IOR_148,                // E14
    //
    inout           IOR_144,                // F11
    inout           IOR_137,                // F12
    //inout           IOR_140_GBIN3,          // F14
    //
    inout           IOR_136,                // G11
    inout           IOR_129,                // G12
    //inout           IOR_141_GBIN2,          // G14
    //
    inout           IOR_128,                // H11
    inout           IOR_120,                // H12
    //
    inout           IOR_119,                // J11
    inout           IOR_118,                // J12
    //
    inout           IOR_116,                // K11
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

//  ------------    Bank 0  -------------------------------------------

    wire                clk_extclk;         // external clock

SB_IO #(
    .PIN_TYPE           (6'b 10_1001),
    .PULLUP             (1'b0)
) u_extclk (
    .PACKAGE_PIN        (IOT_225),          // !!
    .OUTPUT_ENABLE      (1'b0),
    .D_OUT_0            (1'b0),
    .D_IN_0             (clk_extclk)
);

    wire                rst_extrst_n;       // external low-active reset

SB_IO #(
    .PIN_TYPE           (6'b 10_1001),
    .PULLUP             (1'b0)
) u_extrst_n (
    .PACKAGE_PIN        (IOT_223),          // !!
    .OUTPUT_ENABLE      (1'b0),
    .D_OUT_0            (1'b0),
    .D_IN_0             (rst_extrst_n)
);

    localparam          c_ubtn = 2;         // number of user buttons

    wire [c_ubtn-1:0]   w_btn_back;         // button feedback signal
    wire [c_ubtn-1:0]   w_btn_enable;       // button enable signal

SB_IO #(
    .PIN_TYPE           (6'b 10_1001),
    .PULLUP             (1'b1)
) u_btn_0 (
    .PACKAGE_PIN        (IOT_222),          // !!
    .OUTPUT_ENABLE      (w_btn_enable[0]),
    .D_OUT_0            (1'b1),
    .D_IN_0             (w_btn_back[0])
);

SB_IO #(
    .PIN_TYPE           (6'b 10_1001),
    .PULLUP             (1'b1)
) u_btn_1 (
    .PACKAGE_PIN        (IOT_219),          // !!
    .OUTPUT_ENABLE      (w_btn_enable[1]),
    .D_OUT_0            (1'b1),
    .D_IN_0             (w_btn_back[1])
);

//  ------------    Bank 1  -------------------------------------------

    localparam          c_data = 16;        // ftdi data width, could be 16 or 32

    wire [c_data-1:0]   w_ftdi_data_in;     // data bus in
    wire [c_data-1:0]   w_ftdi_data_out;    // data bus out
    wire [c_data-1:0]   w_ftdi_data_enable; // data bus enable

SB_IO #(
    .PIN_TYPE           (6'b 10_1001),
    .PULLUP             (1'b1)
) u_fdti_data_0 (
    .PACKAGE_PIN        (IOR_161),          // !!
    .OUTPUT_ENABLE      (w_ftdi_data_enable[0]),
    .D_OUT_0            (w_ftdi_data_out[0]),
    .D_IN_0             (w_ftdi_data_in[0])
);

SB_IO #(
    .PIN_TYPE           (6'b 10_1001),
    .PULLUP             (1'b1)
) u_fdti_data_1 (
    .PACKAGE_PIN        (IOR_154),          // !!
    .OUTPUT_ENABLE      (w_ftdi_data_enable[1]),
    .D_OUT_0            (w_ftdi_data_out[1]),
    .D_IN_0             (w_ftdi_data_in[1])
);

SB_IO #(
    .PIN_TYPE           (6'b 10_1001),
    .PULLUP             (1'b1)
) u_fdti_data_2 (
    .PACKAGE_PIN        (IOR_160),          // !!
    .OUTPUT_ENABLE      (w_ftdi_data_enable[2]),
    .D_OUT_0            (w_ftdi_data_out[2]),
    .D_IN_0             (w_ftdi_data_in[2])
);

SB_IO #(
    .PIN_TYPE           (6'b 10_1001),
    .PULLUP             (1'b1)
) u_fdti_data_3 (
    .PACKAGE_PIN        (IOR_152),          // !!
    .OUTPUT_ENABLE      (w_ftdi_data_enable[3]),
    .D_OUT_0            (w_ftdi_data_out[3]),
    .D_IN_0             (w_ftdi_data_in[3])
);

SB_IO #(
    .PIN_TYPE           (6'b 10_1001),
    .PULLUP             (1'b1)
) u_fdti_data_4 (
    .PACKAGE_PIN        (IOR_146),          // !!
    .OUTPUT_ENABLE      (w_ftdi_data_enable[4]),
    .D_OUT_0            (w_ftdi_data_out[4]),
    .D_IN_0             (w_ftdi_data_in[4])
);

SB_IO #(
    .PIN_TYPE           (6'b 10_1001),
    .PULLUP             (1'b1)
) u_fdti_data_5 (
    .PACKAGE_PIN        (IOR_147),          // !!
    .OUTPUT_ENABLE      (w_ftdi_data_enable[5]),
    .D_OUT_0            (w_ftdi_data_out[5]),
    .D_IN_0             (w_ftdi_data_in[5])
);

SB_IO #(
    .PIN_TYPE           (6'b 10_1001),
    .PULLUP             (1'b1)
) u_fdti_data_6 (
    .PACKAGE_PIN        (IOR_148),          // !!
    .OUTPUT_ENABLE      (w_ftdi_data_enable[6]),
    .D_OUT_0            (w_ftdi_data_out[6]),
    .D_IN_0             (w_ftdi_data_in[6])
);

SB_IO #(
    .PIN_TYPE           (6'b 10_1001),
    .PULLUP             (1'b1)
) u_fdti_data_7 (
    .PACKAGE_PIN        (IOR_144),          // !!
    .OUTPUT_ENABLE      (w_ftdi_data_enable[7]),
    .D_OUT_0            (w_ftdi_data_out[7]),
    .D_IN_0             (w_ftdi_data_in[7])
);

SB_IO #(
    .PIN_TYPE           (6'b 10_1001),
    .PULLUP             (1'b1)
) u_fdti_data_8 (
    .PACKAGE_PIN        (IOR_137),          // !!
    .OUTPUT_ENABLE      (w_ftdi_data_enable[8]),
    .D_OUT_0            (w_ftdi_data_out[8]),
    .D_IN_0             (w_ftdi_data_in[8])
);

SB_IO #(
    .PIN_TYPE           (6'b 10_1001),
    .PULLUP             (1'b1)
) u_fdti_data_9 (
    .PACKAGE_PIN        (IOR_136),          // !!
    .OUTPUT_ENABLE      (w_ftdi_data_enable[9]),
    .D_OUT_0            (w_ftdi_data_out[9]),
    .D_IN_0             (w_ftdi_data_in[9])
);

SB_IO #(
    .PIN_TYPE           (6'b 10_1001),
    .PULLUP             (1'b1)
) u_fdti_data_10 (
    .PACKAGE_PIN        (IOR_129),          // !!
    .OUTPUT_ENABLE      (w_ftdi_data_enable[10]),
    .D_OUT_0            (w_ftdi_data_out[10]),
    .D_IN_0             (w_ftdi_data_in[10])
);

SB_IO #(
    .PIN_TYPE           (6'b 10_1001),
    .PULLUP             (1'b1)
) u_fdti_data_11 (
    .PACKAGE_PIN        (IOR_128),          // !!
    .OUTPUT_ENABLE      (w_ftdi_data_enable[11]),
    .D_OUT_0            (w_ftdi_data_out[11]),
    .D_IN_0             (w_ftdi_data_in[11])
);

SB_IO #(
    .PIN_TYPE           (6'b 10_1001),
    .PULLUP             (1'b1)
) u_fdti_data_12 (
    .PACKAGE_PIN        (IOR_120),          // !!
    .OUTPUT_ENABLE      (w_ftdi_data_enable[12]),
    .D_OUT_0            (w_ftdi_data_out[12]),
    .D_IN_0             (w_ftdi_data_in[12])
);

SB_IO #(
    .PIN_TYPE           (6'b 10_1001),
    .PULLUP             (1'b1)
) u_fdti_data_13 (
    .PACKAGE_PIN        (IOR_119),          // !!
    .OUTPUT_ENABLE      (w_ftdi_data_enable[13]),
    .D_OUT_0            (w_ftdi_data_out[13]),
    .D_IN_0             (w_ftdi_data_in[13])
);

SB_IO #(
    .PIN_TYPE           (6'b 10_1001),
    .PULLUP             (1'b1)
) u_fdti_data_14 (
    .PACKAGE_PIN        (IOR_118),          // !!
    .OUTPUT_ENABLE      (w_ftdi_data_enable[14]),
    .D_OUT_0            (w_ftdi_data_out[14]),
    .D_IN_0             (w_ftdi_data_in[14])
);

SB_IO #(
    .PIN_TYPE           (6'b 10_1001),
    .PULLUP             (1'b1)
) u_fdti_data_15 (
    .PACKAGE_PIN        (IOR_116),          // !!
    .OUTPUT_ENABLE      (w_ftdi_data_enable[15]),
    .D_OUT_0            (w_ftdi_data_out[15]),
    .D_IN_0             (w_ftdi_data_in[15])
);

    localparam          c_be = c_data / 8;  // ftdi be width, just one bit per byte

    wire [c_be-1:0]     w_ftdi_be_in;       // byte enable in
    wire [c_be-1:0]     w_ftdi_be_out;      // byte enable out
    wire [c_be-1:0]     w_ftdi_be_enable;   // byte enable enable

    wire [1:0]          w_ftdi_gpio_in;     // general purpose io in
    wire [1:0]          w_ftdi_gpio_out;    // general purpose io out
    wire [1:0]          w_ftdi_gpio_enable; // general purpose io enable
    wire                w_ftdi_txe_n;       // transmit fifo emtpy (low-active)
    wire                w_ftdi_rxf_n;       // receive fifo full (low-active)
    wire                w_ftdi_wr_n;        // write enable (low-active)
    wire                w_ftdi_rd_n;        // read enable (low-active)
    wire                w_ftdi_oe_n;        // output enable (low-active)
    wire                w_ftdi_reset_n;     // reset (low-active)

    wire                w_store_mosi;       // spi master 2 slave
    wire                w_store_miso;       // spi slave 2 master
    wire                w_store_sck;        // spi clock
    wire                w_store_cs;         // spi chip select
    wire                w_store_wp_n;       // write protection
    wire                w_store_hold_n;     // hold

    wire                w_oled_mosi;        // spi master 2 slave [SDI/PA7]
    //wire              w_oled_miso;        // * not used here *
    wire                w_oled_sck;         // spi clock [SCK/PA5]
    wire                w_oled_cs;          // spi chip select [#CS/PA4]
    wire                w_oled_rst_n;       // spi low-active reset [#RES/PB1]
    wire                w_oled_dc;          // spi ? [DC/PB0]

//  ------------    core instatiation   -------------------------------

MNR0_core # (
    .p_data             (c_data),
    .p_be               (c_be),
    .p_ubtn             (c_ubtn)
) u_mnr0_core (

    .i_ftdi_data_in     (w_ftdi_data_in),
    .o_ftdi_data_out    (w_ftdi_data_out),
    .o_ftdi_data_enable (w_ftdi_data_enable),
    .i_ftdi_be_in       (w_ftdi_be_in),
    .o_ftdi_be_out      (w_ftdi_be_out),
    .o_ftdi_be_enable   (w_ftdi_be_enable),
    .i_ftdi_gpio_in     (w_ftdi_gpio_in),
    .o_ftdi_gpio_out    (w_ftdi_gpio_out),
    .o_ftdi_gpio_enable (w_ftdi_gpio_enable),
    .i_ftdi_txe_n       (w_ftdi_txe_n),
    .i_ftdi_rxf_n       (w_ftdi_rxf_n),
    .o_ftdi_wr_n        (w_ftdi_wr_n),
    .o_ftdi_rd_n        (w_ftdi_rd_n),
    .o_ftdi_oe_n        (w_ftdi_oe_n),
    .o_ftdi_reset_n     (w_ftdi_reset_n),

    .o_store_mosi       (w_store_mosi),
    .i_store_miso       (w_store_miso),
    .o_store_sck        (w_store_sck),
    .o_store_cs         (w_store_cs),
    .o_store_wp_n       (w_store_wp_n),
    .o_store_hold_n     (w_store_hold_n),

    .o_oled_mosi        (w_oled_mosi),
    //.i_oled_miso      (w_oled_misoe),
    .o_oled_sck         (w_oled_sck),
    .o_oled_cs          (w_oled_cs),
    .o_oled_rst_n       (w_oled_rst_n),
    .o_oled_dc          (w_oled_dc),

    .i_btn_back         (w_btn_back),
    .o_btn_enable       (w_btn_enable),

    .clk_extclk         (clk_extclk),
    .rst_extrst_n       (rst_extrst_n)
);

endmodule
