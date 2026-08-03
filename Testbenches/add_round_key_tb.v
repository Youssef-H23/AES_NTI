`timescale 1ns / 1ps
`include "aes_params.vh"

module add_round_key_tb;

    reg  [`STATE_WIDTH-1:0] state_in;
    reg  [`STATE_WIDTH-1:0] round_key;
    wire [`STATE_WIDTH-1:0] state_out;

    // Instantiate the DUT (device under test)
    add_round_key dut (
        .state_in   (state_in),
        .round_key  (round_key),
        .state_out  (state_out)
    );

    // Expected result, computed by hand for this test vector
    reg [`STATE_WIDTH-1:0] expected;

    initial begin
        // ---- Test Case 1 ----
        // State  : 63 EB 9F A0 C9 D9 33 32 CB A0 A3 1F A1 A2 49 A0
        // RoundKey: A0 88 23 2A FA 54 A3 6C FE 2C 39 76 17 B1 39 05
        // Expected: C3 63 BC 8A 33 8D 90 5E 35 8C 9A 69 B6 13 70 A5
        state_in  = 128'h63EB9FA0_C9D93332_CBA0A31F_A1A249A0;
        round_key = 128'hA088232A_FA54A36C_FE2C3976_17B13905;
        expected  = 128'hC363BC8A_338D905E_358C9A69_B61370A5;

        #10; // allow combinational logic to settle

        if (state_out === expected) begin
            $display("Test 1 PASSED: state_out = %h", state_out);
        end else begin
            $display("Test 1 FAILED: expected %h, got %h", expected, state_out);
        end

        // ---- Test Case 2: XOR with itself should return zero ----
        state_in  = 128'hFFFFFFFF_FFFFFFFF_FFFFFFFF_FFFFFFFF;
        round_key = 128'hFFFFFFFF_FFFFFFFF_FFFFFFFF_FFFFFFFF;
        expected  = 128'h00000000_00000000_00000000_00000000;

        #10;

        if (state_out === expected) begin
            $display("Test 2 PASSED: state_out = %h", state_out);
        end else begin
            $display("Test 2 FAILED: expected %h, got %h", expected, state_out);
        end

        // ---- Test Case 3: XOR with zero key returns state unchanged ----
        state_in  = 128'h00112233_44556677_8899AABB_CCDDEEFF;
        round_key = 128'h00000000_00000000_00000000_00000000;
        expected  = state_in;

        #10;

        if (state_out === expected) begin
            $display("Test 3 PASSED: state_out = %h", state_out);
        end else begin
            $display("Test 3 FAILED: expected %h, got %h", expected, state_out);
        end

        $finish;
    end

endmodule