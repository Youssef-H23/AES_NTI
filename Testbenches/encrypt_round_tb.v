`timescale 1ns/1ps

module encrypt_round_tb;

    parameter STATE_WIDTH = 128;

    reg  [STATE_WIDTH-1:0] state_in;
    reg  [STATE_WIDTH-1:0] round_key;
    wire [STATE_WIDTH-1:0] state_out;
    reg  [STATE_WIDTH-1:0] expected;

    encrypt_round dut (
        .state_in  (state_in),
        .round_key (round_key),
        .state_out (state_out)
    );

    initial 
    begin
        $monitor(
            "Time = %0t | Input = %h | Round_Key = %h | Output = %h | Expected = %h",
            $time,
            state_in,
            round_key,
            state_out,
            expected
        );
    end


    initial 
    begin
        $dvarsfile("encrypt_round_tb.vcd");
        $dvars(0, encrypt_round_tb);

        $display("--- STARTING ENCRYPT ROUND TEST ---");
        $display("--------------TEST CASE 1----------------");

        state_in  = 128'h00112233445566778899aabbccddeeff;
        round_key = 128'hd6aa74fdd2af72fadaa678f1d6ab76fe;
        expected  = 128'hb5d3922426c8898c77a044050440fc5d;
        #5; 

        if (state_out !== expected) 
        begin
            $display("ERROR in Test Case 1");
            $display("Input     : %h", state_in);
            $display("Round Key : %h", round_key);
            $display("Output    : %h", state_out);
            $display("Expected  : %h", expected);
            $display("Error Mask: %h", state_out ^ expected);
        end
        else 
            $display("Test Case 1 PASSED");

        $display("--------------TEST CASE 2----------------");

        state_in  = 128'h63cab7040953d051cd60e0e7ba70e18c;
        round_key = 128'hb692cf0b643dbdf1be9bc5006830b3fe;
        expected  = 128'hf2f4acd907668a2554b5089de32874ce;
        #5;

        if (state_out !== expected) 
        begin
            $display("ERROR in Test Case 2");
            $display("Input     : %h", state_in);
            $display("Round Key : %h", round_key);
            $display("Output    : %h", state_out);
            $display("Expected  : %h", expected);
            $display("Error Mask: %h", state_out ^ expected);
        end
        else 
            $display("Test Case 2 PASSED");

        $display("--------------TEST CASE 3----------------");

        state_in  = 128'h00102030405060708090a0b0c0d0e0f0;
        round_key = 128'h000102030405060708090a0b0c0d0e0f;
        expected  = 128'h5f73661653f0ba95ffb7312211b4f715;
        #5;

        if (state_out !== expected) 
        begin
            $display("ERROR in Test Case 3");
            $display("Input     : %h", state_in);
            $display("Round Key : %h", round_key);
            $display("Output    : %h", state_out);
            $display("Expected  : %h", expected);
            $display("Error Mask: %h", state_out ^ expected);
        end
        else
            $display("Test Case 3 PASSED");

        $stop;

    end

endmodule