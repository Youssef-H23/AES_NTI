`timescale 1ns/1ps

module AES_CBC_Decrypt_tb;

    reg  [127:0] ciphertext;
    reg  [127:0] key;
    reg  [127:0] iv;

    wire [127:0] plaintext;

    integer pass_count = 0;
    integer fail_count = 0;

    // Instantiate AES CBC Decrypt Top
    AES_CBC_Decrypt dut (
        .ciphertext(ciphertext),
        .key       (key),
        .iv        (iv),
        .plaintext (plaintext)
    );

    initial begin
        $monitor(
            "\nTime=%0t\
            \nCiphertext = %h\
            \nState0     = %h\
            \nState1     = %h\
            \nState2     = %h\
            \nState3     = %h\
            \nState4     = %h\
            \nState5     = %h\
            \nState6     = %h\
            \nState7     = %h\
            \nState8     = %h\
            \nState9     = %h\
            \nState10    = %h\
            \nPlaintext  = %h\n",

            $time,
            ciphertext,

            dut.u_decrypt_top.state[0],
            dut.u_decrypt_top.state[1],
            dut.u_decrypt_top.state[2],
            dut.u_decrypt_top.state[3],
            dut.u_decrypt_top.state[4],
            dut.u_decrypt_top.state[5],
            dut.u_decrypt_top.state[6],
            dut.u_decrypt_top.state[7],
            dut.u_decrypt_top.state[8],
            dut.u_decrypt_top.state[9],
            dut.u_decrypt_top.state[10],

            plaintext
        );
    end

    initial begin
        #1;

        $display("=========== Round Keys ===========");
        $display("K0  = %h", dut.u_decrypt_top.r_key[0]);
        $display("K1  = %h", dut.u_decrypt_top.r_key[1]);
        $display("K2  = %h", dut.u_decrypt_top.r_key[2]);
        $display("K3  = %h", dut.u_decrypt_top.r_key[3]);
        $display("K4  = %h", dut.u_decrypt_top.r_key[4]);
        $display("K5  = %h", dut.u_decrypt_top.r_key[5]);
        $display("K6  = %h", dut.u_decrypt_top.r_key[6]);
        $display("K7  = %h", dut.u_decrypt_top.r_key[7]);
        $display("K8  = %h", dut.u_decrypt_top.r_key[8]);
        $display("K9  = %h", dut.u_decrypt_top.r_key[9]);
        $display("K10 = %h", dut.u_decrypt_top.r_key[10]);
    end

    initial begin

        $display("======================================");
        $display("  AES CBC DECRYPT NIST SP 800-38A TEST");
        $display("======================================");

        key = 128'h2B7E151628AED2A6ABF7158809CF4F3C;

        //--------------------------------------------------
        // Block 1
        //--------------------------------------------------
        ciphertext = 128'h7649ABAC8119B246CEE98E9B12E9197D;
        iv         = 128'h000102030405060708090A0B0C0D0E0F;
        #10;

        $display("Block 1 Plaintext = %h", plaintext);
        $display("Expected          = 6BC1BEE22E409F96E93D7E117393172A");

        if (plaintext === 128'h6BC1BEE22E409F96E93D7E117393172A) begin
            pass_count = pass_count + 1;
            $display("[PASS] CBC Block 1");
        end
        else begin
            fail_count = fail_count + 1;
            $display("[FAIL] CBC Block 1");
        end

        //--------------------------------------------------
        // Block 2
        //--------------------------------------------------
        ciphertext = 128'h5086CB9B507219EE95DB113A917678B2;
        iv         = 128'h7649ABAC8119B246CEE98E9B12E9197D;
        #10;

        $display("Block 2 Plaintext = %h", plaintext);
        $display("Expected          = AE2D8A571E03AC9C9EB76FAC45AF8E51");

        if (plaintext === 128'hAE2D8A571E03AC9C9EB76FAC45AF8E51) begin
            pass_count = pass_count + 1;
            $display("[PASS] CBC Block 2");
        end
        else begin
            fail_count = fail_count + 1;
            $display("[FAIL] CBC Block 2");
        end

        //--------------------------------------------------
        // Block 3
        //--------------------------------------------------
        ciphertext = 128'h73BED6B8E3C1743B7116E69E22229516;
        iv         = 128'h5086CB9B507219EE95DB113A917678B2;
        #10;

        $display("Block 3 Plaintext = %h", plaintext);
        $display("Expected          = 30C81C46A35CE411E5FBC1191A0A52EF");

        if (plaintext === 128'h30C81C46A35CE411E5FBC1191A0A52EF) begin
            pass_count = pass_count + 1;
            $display("[PASS] CBC Block 3");
        end
        else begin
            fail_count = fail_count + 1;
            $display("[FAIL] CBC Block 3");
        end

        //--------------------------------------------------
        // Block 4
        //--------------------------------------------------
        ciphertext = 128'h3FF1CAA1681FAC09120ECA307586E1A7;
        iv         = 128'h73BED6B8E3C1743B7116E69E22229516;
        #10;

        $display("Block 4 Plaintext = %h", plaintext);
        $display("Expected          = F69F2445DF4F9B17AD2B417BE66C3710");

        if (plaintext === 128'hF69F2445DF4F9B17AD2B417BE66C3710) begin
            pass_count = pass_count + 1;
            $display("[PASS] CBC Block 4");
        end
        else begin
            fail_count = fail_count + 1;
            $display("[FAIL] CBC Block 4");
        end

        //--------------------------------------------------
        // Additional Test (IV = 0)
        //--------------------------------------------------
        ciphertext = 128'h3925841D02DC09FBDC118597196A0B32;
        iv         = 128'h00000000000000000000000000000000;
        #10;

        $display("Additional Test Plaintext = %h", plaintext);
        $display("Expected                  = 3243F6A8885A308D313198A2E0370734");

        if (plaintext === 128'h3243F6A8885A308D313198A2E0370734) begin
            pass_count = pass_count + 1;
            $display("[PASS] Additional Test (IV = 0)");
        end
        else begin
            fail_count = fail_count + 1;
            $display("[FAIL] Additional Test (IV = 0)");
        end

        $display("");
        $display("======================================");
        $display("Simulation Summary");
        $display("PASS = %0d", pass_count);
        $display("FAIL = %0d", fail_count);
        $display("======================================");


        $stop;

    end

endmodule