`include "aes_params.vh"
`timescale 1ns/1ps

module AES_CBC_Encrypt_tb;

    reg  [127:0] plaintext;
    reg  [127:0] key;
    reg  [127:0] iv;

    wire [127:0] ciphertext;

    integer pass_count = 0;
    integer fail_count = 0;

    // Instantiate AES CBC Encrypt Top
    AES_CBC_Encrypt dut (
        .plaintext  (plaintext),
        .key        (key),
        .iv         (iv),
        .ciphertext (ciphertext)
    );

    initial begin
        $display("======================================");
        $display("  AES CBC ENCRYPT NIST SP 800-38A TEST");
        $display("======================================");

        key = 128'h2B7E151628AED2A6ABF7158809CF4F3C;

        //--------------------------------------------------
        // Block 1 (IV = 000102030405060708090A0B0C0D0E0F)
        //--------------------------------------------------
        plaintext = 128'h6BC1BEE22E409F96E93D7E117393172A;
        iv        = 128'h000102030405060708090A0B0C0D0E0F;
        #10;

        $display("Block 1 Ciphertext = %h", ciphertext);
        $display("Expected           = 7649ABAC8119B246CEE98E9B12E9197D");

        if (ciphertext === 128'h7649ABAC8119B246CEE98E9B12E9197D) begin
            pass_count = pass_count + 1;
            $display("[PASS] CBC Block 1");
        end else begin
            fail_count = fail_count + 1;
            $display("[FAIL] CBC Block 1");
        end

        //--------------------------------------------------
        // Block 2 (IV is previous ciphertext Block 1)
        //--------------------------------------------------
        plaintext = 128'hAE2D8A571E03AC9C9EB76FAC45AF8E51;
        iv        = 128'h7649ABAC8119B246CEE98E9B12E9197D;
        #10;

        $display("Block 2 Ciphertext = %h", ciphertext);
        $display("Expected           = 5086CB9B507219EE95DB113A917678B2");

        if (ciphertext === 128'h5086CB9B507219EE95DB113A917678B2) begin
            pass_count = pass_count + 1;
            $display("[PASS] CBC Block 2");
        end else begin
            fail_count = fail_count + 1;
            $display("[FAIL] CBC Block 2");
        end

        //--------------------------------------------------
        // Block 3 (IV is previous ciphertext Block 2)
        //--------------------------------------------------
        plaintext = 128'h30C81C46A35CE411E5FBC1191A0A52EF;
        iv        = 128'h5086CB9B507219EE95DB113A917678B2;
        #10;

        $display("Block 3 Ciphertext = %h", ciphertext);
        $display("Expected           = 73BED6B8E3C1743B7116E69E22229516");

        if (ciphertext === 128'h73BED6B8E3C1743B7116E69E22229516) begin
            pass_count = pass_count + 1;
            $display("[PASS] CBC Block 3");
        end else begin
            fail_count = fail_count + 1;
            $display("[FAIL] CBC Block 3");
        end

        //--------------------------------------------------
        // Block 4 (IV is previous ciphertext Block 3)
        //--------------------------------------------------
        plaintext = 128'hF69F2445DF4F9B17AD2B417BE66C3710;
        iv        = 128'h73BED6B8E3C1743B7116E69E22229516;
        #10;

        $display("Block 4 Ciphertext = %h", ciphertext);
        $display("Expected           = 3FF1CAA1681FAC09120ECA307586E1A7");

        if (ciphertext === 128'h3FF1CAA1681FAC09120ECA307586E1A7) begin
            pass_count = pass_count + 1;
            $display("[PASS] CBC Block 4");
        end else begin
            fail_count = fail_count + 1;
            $display("[FAIL] CBC Block 4");
        end

        //--------------------------------------------------
        // Additional Test (IV = 0)
        //--------------------------------------------------
        plaintext = 128'h3243F6A8885A308D313198A2E0370734;
        key       = 128'h2B7E151628AED2A6ABF7158809CF4F3C;
        iv        = 128'h00000000000000000000000000000000;
        #10;

        $display("Additional Test Ciphertext = %h", ciphertext);
        $display("Expected                   = 3925841d02dc09fbdc118597196a0b32");

        if (ciphertext === 128'h3925841d02dc09fbdc118597196a0b32) begin
            pass_count = pass_count + 1;
            $display("[PASS] Additional Test (IV = 0)");
        end else begin
            fail_count = fail_count + 1;
            $display("[FAIL] Additional Test (IV = 0)");
        end

        $display("");
        $display("======================================");
        $display("Simulation Summary:");
        $display("PASS = %0d, FAIL = %0d", pass_count, fail_count);
        $display("======================================");

        $stop;
    end

endmodule
