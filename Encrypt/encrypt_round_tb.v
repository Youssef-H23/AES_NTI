`timescale 1ns/1ps

module encrypt_round_tb;

    reg  [127:0] plaintext;
    reg  [127:0] cipher_key;

    reg  [127:0] state_in;
    reg  [127:0] round_key;
    reg  [127:0] expected;

    wire [127:0] round0_out;
    wire [127:0] state_out;

    // Debug wires
    wire [127:0] sub_state;
    wire [127:0] shift_state;
    wire [127:0] mix_state;


    //--------------------------------------------------
    // Round 0
    //--------------------------------------------------
    add_round_key round0 (
        .state_in (plaintext),
        .round_key(cipher_key),
        .state_out(round0_out)
    );


    //--------------------------------------------------
    // Round Module
    //--------------------------------------------------
    encrypt_round dut (
        .state_in (state_in),
        .round_key(round_key),
        .state_out(state_out)
    );


    // Access internal signals for debug
    assign sub_state   = dut.sub_state;
    assign shift_state = dut.shift_state;
    assign mix_state   = dut.mix_state;


    initial begin

        $display("======================================");
        $display("         AES ROUND TEST");
        $display("======================================");


        //-----------------------------
        // Round 0
        //-----------------------------
        plaintext  = 128'h3243f6a8885a308d313198a2e0370734;
        cipher_key = 128'h2b7e151628aed2a6abf7158809cf4f3c;

        #10;

        if(round0_out == 128'h193de3bea0f4e22b9ac68d2ae9f84808)
            $display("[PASS] Round 0");
        else begin
            $display("[FAIL] Round 0");
            $display("Expected = 193de3bea0f4e22b9ac68d2ae9f84808");
            $display("Actual   = %h", round0_out);
        end



        //-----------------------------
        // Round 1
        //-----------------------------
        state_in  = round0_out;
        round_key = 128'ha0fafe1788542cb123a339392a6c7605;
        expected  = 128'ha49c7ff2689f352b6b5bea43026a5049;

        #10;

        $display("");
        $display("---- Round 1 Debug ----");
        $display("Input        = %h", state_in);
        $display("SubBytes     = %h", sub_state);
        $display("ShiftRows    = %h", shift_state);
        $display("MixColumns   = %h", mix_state);
        $display("Round Key    = %h", round_key);
        $display("Output       = %h", state_out);


        if(state_out == expected)
            $display("[PASS] Round 1");
        else begin
            $display("[FAIL] Round 1");
            $display("Expected = %h", expected);
            $display("Actual   = %h", state_out);
        end



        //-----------------------------
        // Round 2
        //-----------------------------
        state_in  = state_out;
        round_key = 128'hf2c295f27a96b9435935807a7359f67f;
        expected  = 128'haa8f5f0361dde3ef82d24ad26832469a;

        #10;


        if(state_out == expected)
            $display("[PASS] Round 2");
        else begin
            $display("[FAIL] Round 2");
            $display("Expected = %h", expected);
            $display("Actual   = %h", state_out);
        end


        $display("======================================");
        $display("Simulation Finished");
        $display("======================================");

        $stop;

    end

endmodule