//  ***********     MNR0 (Monero Hardware Wallet)       ***************
//
//      File:       MNR0/Sources/verilog/MNR0_core.v
//
//      Purpose:    Core level file, wraps all interals
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

//  This wrapper file contains all internal stuff and hide them from
//  higher pad level.

module MNR0_core # (
    parameter           p_data = 16,        // ftdi data width, could be 16 or 32
                        p_be = p_data / 8,  // ftdi be width, just one bit per byte
                        p_ubtn = 2)         // number of user buttons

(   //  --------    USB (via FTDI) interface    ----

    input [p_data-1:0]  i_ftdi_data_in,     // data bus in
    output [p_data-1:0] o_ftdi_data_out,    // data bus out
    output [p_data-1:0] o_ftdi_data_enable, // data bus enable
    input [p_be-1:0]    i_ftdi_be_in,       // byte enable in
    output [p_be-1:0]   o_ftdi_be_out,      // byte enable out
    output [p_be-1:0]   o_ftdi_be_enable,   // byte enable enable
    input [1:0]         i_ftdi_gpio_in,     // general purpose io in
    output [1:0]        o_ftdi_gpio_out,    // general purpose io out
    output [1:0]        o_ftdi_gpio_enable, // general purpose io enable
    input               i_ftdi_txe_n,       // transmit fifo emtpy (low-active)
    input               i_ftdi_rxf_n,       // receive fifo full (low-active)
    output              o_ftdi_wr_n,        // write enable (low-active)
    output              o_ftdi_rd_n,        // read enable (low-active)
    output              o_ftdi_oe_n,        // output enable (low-active)
    output              o_ftdi_reset_n,     // reset (low-active)

    //  --------    key store (flash) interface ----

    output              o_store_mosi,       // spi master 2 slave
    input               i_store_miso,       // spi slave 2 master
    output              o_store_sck,        // spi clock
    output              o_store_cs,         // spi chip select
    output              o_store_wp_n,       // write protection
    output              o_store_hold_n,     // hold

    //  --------    OLED interface      ------------

    output              o_oled_mosi,        // spi master 2 slave [SDI/PA7]
    //input             i_oled_miso,        // * not used here *
    output              o_oled_sck,         // spi clock [SCK/PA5]
    output              o_oled_cs,          // spi chip select [#CS/PA4]
    output              o_oled_rst_n,       // spi low-active reset [#RES/PB1]
    output              o_oled_dc,          // spi ? [DC/PB0]

    //  --------    button interface    ------------

    input [p_ubtn-1:0]  i_btn_back,         // button feedback signal
    output [p_ubtn-1:0] o_btn_enable,       // button enable signal

    //  --------    globals     --------------------

    input               clk_extclk,         // external clock
    input               rst_extrst_n);      // external low-active reset

//  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
//                          @ EXTCLK
//  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

//  ------------    global signals  -----------------------------------

//  This Phase-locked Loop (PLL) is a security feature - USE IT!

    wire                clk_intclk;         // use internal clock only!
    wire                rst_intrst;         // use internal reset only!

MNR0_globals u_mnr0_globals (
    .clk_extclk         (clk_extclk),
    .rst_extrst_n       (rst_extrst_n),
    .clk_intclk         (clk_intclk),
    .rst_intrst         (rst_intrst)
);

//  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
//                          @ INTCLK
//  ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

//  ------------    debouncer latch -----------------------------------

    wire [p_ubtn-1:0]   w_buttons;          // button vector for CPU
    wire [p_ubtn-1:0]   w_interrupts_set;   // interrupt bit active
    wire [p_ubtn-1:0]   w_interrupts_clear; // clear interrupt bit

MNR0_debouncer # (
    .p_ubtn             (p_ubtn)
) u_mnr0_debouncer (
    .i_btn_back         (i_btn_back),
    .o_btn_enable       (o_btn_enable),

    .o_buttons          (w_buttons),
    .o_interrupts       (w_interrupts_set),
    .i_clear            (w_interrupts_clear),

    .clk_intclk         (clk_intclk),
    .rst_intrst         (rst_intrst)
);

endmodule
