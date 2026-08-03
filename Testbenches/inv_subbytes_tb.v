`timescale 1ns/1ps

module inv_subbytes_tb;

    //==================================================
    // Parameters
    //==================================================
    parameter STATE_WIDTH = 128;


    //==================================================
    // Testbench Signals
    //==================================================
    reg  [STATE_WIDTH-1:0] i_state;
    wire [STATE_WIDTH-1:0] o_state;


    integer pass_count = 0;
    integer fail_count = 0;


    //==================================================
    // DUT
    //==================================================
    inv_subbytes #(
        .STATE_WIDTH(STATE_WIDTH),
        .BYTE_WIDTH(8)
    ) DUT (
        .i_state(i_state),
        .o_state(o_state)
    );


    //==================================================
    // Verification Task
    //==================================================
    integer test_num = 0;


    task check_inv_subbytes;

        input [STATE_WIDTH-1:0] test_input;
        input [STATE_WIDTH-1:0] expected_output;

        begin

            test_num = test_num + 1;

            i_state = test_input;

            #10;


            if (o_state === expected_output) begin

                pass_count = pass_count + 1;

                $display("[PASS] Test Case %0d", test_num);

            end

            else begin

                fail_count = fail_count + 1;

                $display("[FAIL] Test Case %0d", test_num);

                $display("Input    = %h", test_input);
                $display("Expected = %h", expected_output);
                $display("Actual   = %h", o_state);

            end

        end

    endtask



    //==================================================
    // Test Sequence
    //==================================================
    initial begin


        check_inv_subbytes(
            128'h637C777BF26B6FC53001672BFED7AB76,
            128'h000102030405060708090A0B0C0D0E0F
        );


        check_inv_subbytes(
            128'hCA82C97DFA5947F0ADD4A2AF9CA472C0,
            128'h101112131415161718191A1B1C1D1E1F
        );


        check_inv_subbytes(
            128'hB7FD9326363FF7CC34A5E5F171D83115,
            128'h202122232425262728292A2B2C2D2E2F
        );


        check_inv_subbytes(
            128'h04C723C31896059A071280E2EB27B275,
            128'h303132333435363738393A3B3C3D3E3F
        );


        check_inv_subbytes(
            128'h09832C1A1B6E5AA0523BD6B329E32F84,
            128'h404142434445464748494A4B4C4D4E4F
        );


        check_inv_subbytes(
            128'h53D100ED20FCB15B6ACBBE394A4C58CF,
            128'h505152535455565758595A5B5C5D5E5F
        );


        check_inv_subbytes(
            128'hD0EFAAFB434D338545F9027F503C9FA8,
            128'h606162636465666768696A6B6C6D6E6F
        );


        check_inv_subbytes(
            128'h51A3408F929D38F5BCB6DA2110FFF3D2,
            128'h707172737475767778797A7B7C7D7E7F
        );


        check_inv_subbytes(
            128'hCD0C13EC5F974417C4A77E3D645D1973,
            128'h808182838485868788898A8B8C8D8E8F
        );


        check_inv_subbytes(
            128'h60814FDC222A908846EEB814DE5E0BDB,
            128'h909192939495969798999A9B9C9D9E9F
        );


        check_inv_subbytes(
            128'hE0323A0A4906245CC2D3AC629195E479,
            128'hA0A1A2A3A4A5A6A7A8A9AAABACADAEAF
        );


        check_inv_subbytes(
            128'hE7C8376D8DD54EA96C56F4EA657AAE08,
            128'hB0B1B2B3B4B5B6B7B8B9BABBBCBDBEBF
        );


        check_inv_subbytes(
            128'hBA78252E1CA6B4C6E8DD741F4BBD8B8A,
            128'hC0C1C2C3C4C5C6C7C8C9CACBCCCDCECF
        );


        check_inv_subbytes(
            128'h703EB5664803F60E613557B986C11D9E,
            128'hD0D1D2D3D4D5D6D7D8D9DADBDCDDDEDF
        );


        check_inv_subbytes(
            128'hE1F8981169D98E949B1E87E9CE5528DF,
            128'hE0E1E2E3E4E5E6E7E8E9EAEBECEDEEEF
        );


        check_inv_subbytes(
            128'h8CA1890DBFE6426841992D0FB054BB16,
            128'hF0F1F2F3F4F5F6F7F8F9FAFBFCFDFEFF
        );


        $display("----------------------------------");
        $display("Verification Summary");
        $display("PASS = %0d", pass_count);
        $display("FAIL = %0d", fail_count);
        $display("----------------------------------");


        $stop;

    end

endmodule