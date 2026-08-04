`timescale 1ns/1ps

module encrypt_decrypt_round_tb;

    reg  [127:0] initial_state;
    reg  [127:0] round_key;

    wire [127:0] encrypt_output;
    wire [127:0] decrypt_output;

    integer pass_count = 0;
    integer fail_count = 0;

    //--------------------------------------------------
    // Encrypt Round DUT
    //--------------------------------------------------
    encrypt_round enc_dut (
        .state_in  (initial_state),
        .round_key (round_key),
        .state_out (encrypt_output)
    );

    //--------------------------------------------------
    // Decrypt Round DUT
    //--------------------------------------------------
    decrypt_round dec_dut (
        .state_in  (encrypt_output),
        .round_key (round_key),
        .state_out (decrypt_output)
    );

    initial begin

        $display("======================================");
        $display("   AES ENCRYPT/DECRYPT ROUND-TRIP TEST");
        $display("======================================");

        //--------------------------------------------------
        // Test Case 1
        //--------------------------------------------------
        initial_state = 128'h193de3bea0f4e22b9ac68d2ae9f84808;
        round_key     = 128'ha0fafe1788542cb123a339392a6c7605;

        #10;

        $display("");
        $display("---- Round-Trip Test 1 ----");
        $display("Initial State   = %h", initial_state);
        $display("Round Key       = %h", round_key);
        $display("Encrypt Output  = %h", encrypt_output);
        $display("Decrypt Output  = %h", decrypt_output);

        if (decrypt_output === initial_state) begin
            pass_count = pass_count + 1;
            $display("[PASS] Round-Trip Test 1 (Match)");
        end else begin
            fail_count = fail_count + 1;
            $display("[FAIL] Round-Trip Test 1 (Mismatch)");
        end

        //--------------------------------------------------
        // Test Case 2
        //--------------------------------------------------
        initial_state = 128'ha49c7ff2689f352b6b5bea43026a5049;
        round_key     = 128'hf2c295f27a96b9435935807a7359f67f;

        #10;

        $display("");
        $display("---- Round-Trip Test 2 ----");
        $display("Initial State   = %h", initial_state);
        $display("Round Key       = %h", round_key);
        $display("Encrypt Output  = %h", encrypt_output);
        $display("Decrypt Output  = %h", decrypt_output);

        if (decrypt_output === initial_state) begin
            pass_count = pass_count + 1;
            $display("[PASS] Round-Trip Test 2 (Match)");
        end else begin
            fail_count = fail_count + 1;
            $display("[FAIL] Round-Trip Test 2 (Mismatch)");
        end

        //--------------------------------------------------
        // Test Case 3 (Random/Pattern data)
        //--------------------------------------------------
        initial_state = 128'h00112233445566778899aabbccddeeff;
        round_key     = 128'h0123456789abcdeffedcba9876543210;

        #10;

        $display("");
        $display("---- Round-Trip Test 3 ----");
        $display("Initial State   = %h", initial_state);
        $display("Round Key       = %h", round_key);
        $display("Encrypt Output  = %h", encrypt_output);
        $display("Decrypt Output  = %h", decrypt_output);

        if (decrypt_output === initial_state) begin
            pass_count = pass_count + 1;
            $display("[PASS] Round-Trip Test 3 (Match)");
        end else begin
            fail_count = fail_count + 1;
            $display("[FAIL] Round-Trip Test 3 (Mismatch)");
        end

        $display("");
        $display("======================================");
        $display("Simulation Summary:");
        $display("PASS = %0d, FAIL = %0d", pass_count, fail_count);
        $display("======================================");

        $stop;

    end

endmodule
