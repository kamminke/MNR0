//  ***********     MNR0 (Monero Hardware Wallet)       ***************
//
//      File:       MNR0/Sources/verilog/MNR0_debouncer.v
//
//      Purpose:    Latch buttons
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

//  Every physical button has the property to beat the contact many times.
//  To avoid this, we using de-bouncing techniques, latching some times the
//  incoming voltage as logic level. While every button is still 'powered'
//  by an output signal, the button can rise attention (e.g. an interrupt).
//  Afterwards, the tri-state IO cells are switched off immediatly until
//  the CPU releases the button again with the clear signal.

`include "timescale.v"

module MNR0_debouncer # (
    parameter           p_ubtn = 2)         // number of user buttons

(   //  --------    button interface    ------------

    input [p_ubtn-1:0]  i_btn_back,         // button feedback signal
    output [p_ubtn-1:0] o_btn_enable,       // button enable signal

    //  --------    upward result   ----------------

    output [p_ubtn-1:0] o_buttons,          // button vector for CPU
    output [p_ubtn-1:0] o_interrupts,       // interrupt bit active
    input [p_ubtn-1:0]  i_clear,            // clear interrupt bit

    //  --------    globals     --------------------

    input               clk_intclk,         // internal clock
    input               rst_intrst          // internal high-active reset
);

    wire [p_ubtn-1:0]   w_buttons;          // button vector for CPU, combinatorial

//  ------------    enable / disable buttons    -----------------------

`ifdef CODINGSTYLE_FPGA
    reg [p_ubtn-1:0]    r_enablereg = 0;    // start disabled
`else
    reg [p_ubtn-1:0]    r_enablereg;
`endif

    integer i;

`ifdef CODINGSTYLE_FPGA
always @ (posedge clk_intclk)
begin
`else
always @ (posedge rst_intrst or posedge clk_intclk)
begin
    if (rst_intrst)
        // start disabled
        r_enablereg <= 0;
    else
`endif
        for (i=0; i<p_ubtn; i=i+1)
            // loop through vector
            if (i_clear[i])
                // CPU clears request, enable
                r_enablereg[i] <= 'b1;
            else if (w_buttons[i])
                // button active, disable
                r_enablereg[i] <= 'b0;
end

    // output matching
    assign o_btn_enable = r_enablereg;

//  ------------    voodoo happens here -------------------------------

    localparam          c_stage = 3;        // sample every button c_stage times

genvar g;
generate
    for (g=0; g<p_ubtn; g=g+1) begin

`ifdef CODINGSTYLE_FPGA
    reg [c_stage-1:0]   r_shiftreg = ~0;    // start empty
`else
    reg [c_stage-1:0]   r_shiftreg;
`endif

`ifdef CODINGSTYLE_FPGA
always @ (posedge clk_intclk)
begin
`else
always @ (posedge rst_intrst or posedge clk_intclk)
begin
    if (rst_intrst)
        // start empty
        r_shiftreg <= ~0;
    else
`endif
        if (r_enablereg[g])
            // button is enabled
            if (~i_btn_back[g])
                // gotcha
                r_shiftreg <= 0;
            else
                // still hold, feed in default one
                r_shiftreg <= {1'b1, r_shiftreg[c_stage-1:0]};
        else
            // button released, shift in one
            r_shiftreg <= {1'b1, r_shiftreg[c_stage-1:0]};
end

    // signal matching, vector over all buttons
    assign w_buttons[g] = ~r_shiftreg[0];

    end
endgenerate

//  ------------    upward matching -----------------------------------

`ifdef CODINGSTYLE_FPGA
    reg [p_ubtn-1:0]    r_buttons = 0;      // start with button unpressed
`else
    reg [p_ubtn-1:0]    r_buttons;
`endif

`ifdef CODINGSTYLE_FPGA
always @ (posedge clk_intclk)
begin
`else
always @ (posedge rst_intrst or posedge clk_intclk)
begin
    if (rst_intrst)
        // start with button unpressed
        r_buttons <= 0;
    else
`endif
        for (i=0; i<p_ubtn; i=i+1)
            // loop through vector
            if (w_buttons[i])
                // button active, follow
                r_buttons[i] <= 'b1;
            else if (i_clear[i])
                // CPU clears request, follow
                r_buttons[i] <= 'b0;
end

    // output matching
    assign o_interrupts = w_buttons;
    assign o_buttons = r_buttons;

endmodule
