`timescale 1ns/1ps

`include "aes_params.vh"

module AES_CBC_Decrypt_tb;


    //---------------------------------------------------------
    // Signals
    //---------------------------------------------------------

    reg  [4*`STATE_WIDTH-1:0] ciphertext;
    reg  [`STATE_WIDTH-1:0] key;
    reg  [`STATE_WIDTH-1:0] iv;

    wire [4*`STATE_WIDTH-1:0] plaintext;


    //---------------------------------------------------------
    // Expected Plaintext
    //---------------------------------------------------------

    reg [4*`STATE_WIDTH-1:0] expected_plaintext;



    //---------------------------------------------------------
    // DUT
    //---------------------------------------------------------

    AES_CBC_Decrypt dut (

        .ciphertext(ciphertext),
        .key       (key),
        .iv        (iv),
        .plaintext (plaintext)

    );


    //---------------------------------------------------------
    // Test
    //---------------------------------------------------------

    initial begin


        $display("======================================");
        $display("      AES CBC DECRYPT TEST");
        $display("======================================");


        //-----------------------------------------------------
        // NIST AES-128 CBC Test Vector
        //-----------------------------------------------------

        key = 128'h2B7E151628AED2A6ABF7158809CF4F3C;

        iv = 128'h000102030405060708090A0B0C0D0E0F;


        ciphertext = 512'h7649ABAC8119B246CEE98E9B12E9197D5086CB9B507219EE95DB113A917678B273BED6B8E3C1743B7116E69E222295163FF1CAA1681FAC09120ECA307586E1A7;


        expected_plaintext = 512'h6BC1BEE22E409F96E93D7E117393172AAE2D8A571E03AC9C9EB76FAC45AF8E5130C81C46A35CE411E5FBC1191A0A52EFF69F2445DF4F9B17AD2B417BE66C3710;


        #20;


        $display("====================================================");
        $display("                  CBC-AES128 (Decryption)");
        $display("====================================================");

        $display("");
        $display("Key is");
        $display("    %h", key);


        $display("");
        $display("Ciphertext is");
        $display("    %h", ciphertext[511:384]);
        $display("    %h", ciphertext[383:256]);
        $display("    %h", ciphertext[255:128]);
        $display("    %h", ciphertext[127:0]);


        $display("");
        $display("Block #1");
        $display("    Ciphertext    %h", dut.C0);
        $display("    InputBlock    %h", dut.C0);
        $display("    OutputBlock   %h", dut.D0);
        $display("    Plaintext     %h", plaintext[511:384]);


        $display("");
        $display("Block #2");
        $display("    Ciphertext    %h", dut.C1);
        $display("    InputBlock    %h", dut.C1);
        $display("    OutputBlock   %h", dut.D1);
        $display("    Plaintext     %h", plaintext[383:256]);


        $display("");
        $display("Block #3");
        $display("    Ciphertext    %h", dut.C2);
        $display("    InputBlock    %h", dut.C2);
        $display("    OutputBlock   %h", dut.D2);
        $display("    Plaintext     %h", plaintext[255:128]);


        $display("");
        $display("Block #4");
        $display("    Ciphertext    %h", dut.C3);
        $display("    InputBlock    %h", dut.C3);
        $display("    OutputBlock   %h", dut.D3);
        $display("    Plaintext     %h", plaintext[127:0]);


        $display("");
        $display("Plaintext is");
        $display("    %h", plaintext[511:384]);
        $display("    %h", plaintext[383:256]);
        $display("    %h", plaintext[255:128]);
        $display("    %h", plaintext[127:0]);


        $display("");
        $display("****************************************************");
        $display("====================================================");


        //-----------------------------------------------------
        // Check Result
        //-----------------------------------------------------

        if (plaintext == expected_plaintext) begin

            $display("[PASS] AES CBC Decryption");

        end
        else begin

            $display("[FAIL] AES CBC Decryption");

            $display("Expected = %h", expected_plaintext);

            $display("Actual   = %h", plaintext);

        end


        $display("======================================");

        $finish;

    end


endmodule
