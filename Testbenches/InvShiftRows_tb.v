`timescale 1ns/1ns

module InvShiftRows_tb;

    parameter STATE_WIDTH = 128;

    reg  [STATE_WIDTH-1:0] state_in;
    wire [STATE_WIDTH-1:0] state_out;
    reg  [STATE_WIDTH-1:0] expected;

    InvShiftRows #(
        .STATE_WIDTH(STATE_WIDTH)
    ) dut (
        .state_in(state_in),
        .state_out(state_out)
    );

    initial
    begin
        $monitor(
            "Time = %0t | Input = %h | Output = %h | Expected = %h",
            $time,
            state_in,
            state_out,
            expected
        );
    end


    initial 
    begin
        $display("STARTING INVERSE SHIFT ROWS TEST CASES");
        $display("--------------TEST CASE 1----------------");

        state_in = 128'h00050a0f04090e03080d02070c01060b;
        expected = 128'h000102030405060708090a0b0c0d0e0f;
        #5;
        if (state_out !== expected)
        begin
            $display("ERROR in Test Case 1");
            $display("Input     : %h", state_in);
            $display("Output    : %h", state_out);
            $display("Expected  : %h", expected);
            $display("Error Mask: %h", state_out ^ expected);
            $stop;
        end
        else
            $display("Test Case 1 PASSED");

        $display("--------------TEST CASE 2----------------");
        state_in = 128'h0055aaff4499ee3388dd2277cc1166bb;
        expected = 128'h00112233445566778899aabbccddeeff;
        #5;
        if (state_out !== expected) 
        begin
            $display("ERROR in Test Case 2");
            $display("Input     : %h", state_in);
            $display("Output    : %h", state_out);
            $display("Expected  : %h", expected);
            $display("Error Mask: %h", state_out ^ expected);
            $stop;
        end
        else
            $display("Test Case 2 PASSED");

        $display("--------------TEST CASE 3----------------");
        state_in = 128'h01abba1089dc3267fe5445ef7623cd98;
        expected = 128'h0123456789abcdeffedcba9876543210;
        #5;
        if (state_out !== expected) begin
            $display("ERROR in Test Case 3");
            $display("Input     : %h", state_in);
            $display("Output    : %h", state_out);
            $display("Expected  : %h", expected);
            $display("Error Mask: %h", state_out ^ expected);
            $stop;
        end
        else
            $display("Test Case 3 PASSED");

        $display("--------------TEST CASE 4----------------");
        state_in = 128'h1166bb0055aaff4499ee3388dd2277cc;
        expected = 128'h112233445566778899aabbccddeeff00;
        #5;
        if (state_out !== expected)
        begin
            $display("ERROR in Test Case 4");
            $display("Input     : %h", state_in);
            $display("Output    : %h", state_out);
            $display("Expected  : %h", expected);
            $display("Error Mask: %h", state_out ^ expected);
            $stop;
        end
        else
            $display("Test Case 4 PASSED");

        $display("--------------TEST CASE 5----------------");
        state_in = 128'hde23cddf01ab9bef8957be6713ad45ef;
        expected = 128'hdeadbeef0123456789abcdef13579bdf;
        #5;
        if (state_out !== expected) 
        begin
            $display("ERROR in Test Case 5");
            $display("Input     : %h", state_in);
            $display("Output    : %h", state_out);
            $display("Expected  : %h", expected);
            $display("Error Mask: %h", state_out ^ expected);
            $stop;
        end
        else
            $display("Test Case 5 PASSED");

        $display("----------------------------------------");
        $display("ALL INVERSE SHIFT ROWS TEST CASES PASSED");
        $display("----------------------------------------");

        $stop;

    end

endmodule