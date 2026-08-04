`timescale 1ns/1ps

module decrypt_round_tb;

    reg  [127:0] state_in;
    reg  [127:0] round_key;
    reg  [127:0] expected;

    wire [127:0] state_out;

    // Debug wires matching diagram order:
    // add_round_key -> inv_mix_columns -> inv_shift_rows -> inv_sub_bytes
    wire [127:0] add_key_state;
    wire [127:0] inv_mix_state;
    wire [127:0] inv_shift_state;

    integer pass_count = 0;
    integer fail_count = 0;

    //--------------------------------------------------
    // Decrypt Round Module
    //--------------------------------------------------
    decrypt_round dut (
        .state_in  (state_in),
        .round_key (round_key),
        .state_out (state_out)
    );

    // Access internal signals for debug
    assign add_key_state   = dut.add_key_state;
    assign inv_mix_state   = dut.inv_mix_state;
    assign inv_shift_state = dut.inv_shift_state;

    initial begin

        $display("======================================");
        $display("       AES DECRYPT ROUND TEST");
        $display("======================================");

        //--------------------------------------------------
        // Test Case 1: Invert Encryption Round 1
        // Input: Encrypt Round 1 Output
        // Key: Encrypt Round 1 Key
        // Expected: Encrypt Round 1 Input (Round 0 Output)
        //--------------------------------------------------
        state_in  = 128'ha49c7ff2689f352b6b5bea43026a5049;
        round_key = 128'ha0fafe1788542cb123a339392a6c7605;
        expected  = 128'h193de3bea0f4e22b9ac68d2ae9f84808;

        #10;

        $display("");
        $display("---- Decrypt Round 1 Test ----");
        $display("Input          = %h", state_in);
        $display("AddRoundKey    = %h", add_key_state);
        $display("InvMixColumns  = %h", inv_mix_state);
        $display("InvShiftRows   = %h", inv_shift_state);
        $display("State Out      = %h", state_out);
        $display("Expected       = %h", expected);

        if(state_out === expected) begin
            pass_count = pass_count + 1;
            $display("[PASS] Decrypt Round 1");
        end else begin
            fail_count = fail_count + 1;
            $display("[FAIL] Decrypt Round 1");
        end

        //--------------------------------------------------
        // Test Case 2: Invert Encryption Round 2
        // Input: Encrypt Round 2 Output
        // Key: Encrypt Round 2 Key
        // Expected: Encrypt Round 2 Input (Round 1 Output)
        //--------------------------------------------------
        state_in  = 128'haa8f5f0361dde3ef82d24ad26832469a;
        round_key = 128'hf2c295f27a96b9435935807a7359f67f;
        expected  = 128'ha49c7ff2689f352b6b5bea43026a5049;

        #10;

        $display("");
        $display("---- Decrypt Round 2 Test ----");
        $display("Input          = %h", state_in);
        $display("AddRoundKey    = %h", add_key_state);
        $display("InvMixColumns  = %h", inv_mix_state);
        $display("InvShiftRows   = %h", inv_shift_state);
        $display("State Out      = %h", state_out);
        $display("Expected       = %h", expected);

        if(state_out === expected) begin
            pass_count = pass_count + 1;
            $display("[PASS] Decrypt Round 2");
        end else begin
            fail_count = fail_count + 1;
            $display("[FAIL] Decrypt Round 2");
        end

        $display("");
        $display("======================================");
        $display("Simulation Summary:");
        $display("PASS = %0d, FAIL = %0d", pass_count, fail_count);
        $display("======================================");

        $stop;

    end

endmodule
