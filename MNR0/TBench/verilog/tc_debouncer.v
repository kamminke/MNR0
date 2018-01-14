//  ***********     MNR0 (Monero Hardware Wallet)       ***************
//
//      File:       MNR0/TBench/verilog/tc_debouncer.v
//
//      Purpose:    Testcase for debounder module
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

//  `define             TALKATIVE_MNR0   1   // be more talkative

//  -------------------------------------------------------------------
//                          DESCRIPTION
//  -------------------------------------------------------------------

//  Event principles:
//
//       one clock cycle
//      |---------------|
//       _______         _______         _______
//      ||      |       ||      |       ||      |
//      ||      |       ||      |       ||      |       clk_tb
//  ____||      |_______||      |_______||      |_____
//
//                   ^ STROBE        ^ STROBE
//
//                   ^ write here    ^ write here
//                                   ^ read here
//                   |---------------|
//                    one task cycle

`include "timescale.v"

//  -------------------------------------------------------------------
//                          CONFIGURATION
//  -------------------------------------------------------------------

`define                 TIMELIMIT       10_000

//  ----------------    global signal   -------------------------------

`define                 CLK_PERIOD      10
`define                 RST_PERIOD      200
`define                 STROBE          (0.8 * `CLK_PERIOD)

module tb_debouncer (
//  Sorry, testbenches do not have ports
);

//  ------------    global signals      -------------------------------

    reg                 clk_tb = ~0;        // start with falling edge

always @ (clk_tb)
begin
    clk_tb <= #(`CLK_PERIOD/2) ~clk_tb;
end

    reg                 rst_tb = 0;         // start inactive

initial
begin
    #1;
    // activate reset
    rst_tb <= ~0;
    rst_tb <= #(`RST_PERIOD) 0;
end

//  ------------    testbench top level signals -----------------------

    localparam          c_ubtn = 2;

    reg [c_ubtn-1:0]    r_btn_back = ~0;    // modelize button w/ pull-up
    wire [c_ubtn-1:0]   w_btn_enable;       // drive / enable button

    reg [c_ubtn-1:0]    r_clear = 0;        // CPU (downward) response
    wire [c_ubtn-1:0]   w_buttons;          // CPU (upward) result
    wire [c_ubtn-1:0]   w_interrupts;       // CPU (upward) result

//  ------------    device-under-test (DUT) ---------------------------

MNR0_debouncer # (
    .p_ubtn             (c_ubtn)
) dut (
    .i_btn_back         (r_btn_back),
    .o_btn_enable       (w_btn_enable),

    .o_buttons          (w_buttons),
    .o_interrupts       (w_interrupts),
    .i_clear            (r_clear),

    .clk_intclk         (clk_tb),
    .rst_intrst         (rst_tb)
);

//  ------------    simulate buttons    -------------------------------

    reg [c_ubtn-1:0]    r_pressing = 0;     // start un-pressed

always @ (r_pressing)
begin
    r_btn_back <= ~r_pressing;
end

//  ------------    test functionality  -------------------------------

    integer             failed = 0;         // failed test item counter

task t_initialize;
begin
    #1;
    @ (negedge rst_tb);
    @ (posedge clk_tb);
    #(`STROBE);
end
endtask

task t_idle;
    input integer reps;
begin
    repeat(reps) begin
        @ (posedge clk_tb);
        #(`STROBE);
    end
end
endtask

task t_enable_buttons;
begin
    r_clear <= ~0;
    @ (posedge clk_tb);
    #(`STROBE);
    r_clear <= 0;
    @ (posedge clk_tb);
    #(`STROBE);
end
endtask

task t_press_button;
    input integer btn;
    integer i;
begin
    for (i=0;i<c_ubtn;i=i+1)
        if (btn == i)
            r_pressing[btn] <= 'b0;
        else
            r_pressing[i] <= 'b1;
end
endtask

task t_press_random;
    input integer reps;
    integer btn, delay;
begin
    repeat(reps) begin
        btn = $urandom%c_ubtn;
        delay = $urandom%20;
        t_idle(delay);
        t_press_button(btn);
        $display("\t%m: delay %0d btn %0d", delay, btn);
    end
end
endtask

initial
begin
    t_initialize;

    // 1st, enable / drive buttons with current
    t_enable_buttons;

    // generate some press button events with random distance
    t_press_random(10);

    #1;
    if (failed)
        $display("\t%m: *failed* %0d times", failed);
    else
        $display("\t%m: *well done*");
    $finish;
end

//  ------------    testbench flow control  ---------------------------

initial
begin
    $dumpfile(`DUMPFILE);
    $dumpvars;

    #(`TIMELIMIT);
    $display("\t%m: *time limit (%t) reached*", $time);
    $finish;
end

endmodule
