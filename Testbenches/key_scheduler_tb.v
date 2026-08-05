`timescale 1ns/1ps

module key_scheduler_tb;

    reg  [127:0] key;
    reg  [3:0]   round_idx;
    reg          decrypt;

    wire [1407:0] w;
    wire [127:0]  round_key;

    integer i;
    integer pass_count = 0;
    integer fail_count = 0;

    // Instantiate Key Expansion
    key_expansion #(
        .KEY_BITS(128),
        .NUM_ROUNDS(10)
    ) u_key_expansion (
        .key(key),
        .w(w)
    );

    // Instantiate Key Scheduler DUT
    key_scheduler #(
        .KEY_BITS(128),
        .NUM_ROUNDS(10)
    ) u_key_scheduler (
        .w(w),
        .round_idx(round_idx),
        .decrypt(decrypt),
        .round_key(round_key)
    );

    initial begin
        $display("======================================");
        $display("       AES KEY SCHEDULER TEST");
        $display("======================================");

        // FIPS-197 Test Key
        key = 128'h2b7e151628aed2a6abf7158809cf4f3c;

        //--------------------------------------------------
        // Test Encryption Key Schedule (decrypt = 0)
        //--------------------------------------------------
        decrypt = 1'b0;
        $display("");
        $display("--- Testing Encryption Key Schedule ---");

        for (i = 0; i <= 10; i = i + 1) begin
            round_idx = i;
            #5;
            $display("Encrypt Round %0d Key = %h", round_idx, round_key);
            if (round_key === w[i*128 +: 128]) begin
                pass_count = pass_count + 1;
            end else begin
                fail_count = fail_count + 1;
                $display("[FAIL] Encrypt Round %0d key mismatch", i);
            end
        end

        //--------------------------------------------------
        // Test Decryption Key Schedule (decrypt = 1)
        //--------------------------------------------------
        decrypt = 1'b1;
        $display("");
        $display("--- Testing Decryption Key Schedule ---");

        for (i = 0; i <= 10; i = i + 1) begin
            round_idx = i;
            #5;
            $display("Decrypt Round %0d Key = %h (Expected w[%0d])", round_idx, round_key, 10 - i);
            if (round_key === w[(10 - i)*128 +: 128]) begin
                pass_count = pass_count + 1;
            end else begin
                fail_count = fail_count + 1;
                $display("[FAIL] Decrypt Round %0d key mismatch", i);
            end
        end

        $display("");
        $display("======================================");
        $display("Simulation Summary:");
        $display("PASS = %0d, FAIL = %0d", pass_count, fail_count);
        $display("======================================");

        $stop;
    end

endmodule
