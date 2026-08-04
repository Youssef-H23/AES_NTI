`timescale 1ns/1ps

module encrypt_round_tb;

    parameter STATE_WIDTH = 128;

    reg  [STATE_WIDTH-1:0] state_in;
    reg  [STATE_WIDTH-1:0] round_key;
    reg  [STATE_WIDTH-1:0] expected;

    wire [STATE_WIDTH-1:0] state_out;

    encrypt_round dut (
        .state_in(state_in),
        .round_key(round_key),
        .state_out(state_out)
    );

    initial begin
        $monitor(
            "Time=%0t | Input=%h | RoundKey=%h | Output=%h | Expected=%h",
            $time,
            state_in,
            round_key,
            state_out,
            expected
        );
    end

    initial begin

        $dumpfile("encrypt_round_tb.vcd");
        $dumpvars(0, encrypt_round_tb);

        $display("STARTING ENCRYPT ROUND TEST");

        $display("Round 1");

        state_in  = 128'h193de3bea0f4e22b9ac68d2ae9f84808;
        round_key = 128'ha0fafe1788542cb123a339392a6c7605;
        expected  = 128'ha49c7ff2689f352b6b5bea43026a5049;

        #5;

        if (state_out !== expected) begin
            $display("ERROR in Round 1");
            $display("Input     : %h", state_in);
            $display("Round Key : %h", round_key);
            $display("Output    : %h", state_out);
            $display("Expected  : %h", expected);
            $display("Error Mask: %h", state_out ^ expected);
        end
        else
            $display("Round 1 PASSED");


        $display("Round 2");

        state_in  = 128'ha49c7ff2689f352b6b5bea43026a5049;
        round_key = 128'hf2c295f27a96b9435935807a7359f67f;
        expected  = 128'haa8f5f0361dde3ef82d24ad26832469a;

        #5;

        if (state_out !== expected) begin
            $display("ERROR in Round 2");
            $display("Input     : %h", state_in);
            $display("Round Key : %h", round_key);
            $display("Output    : %h", state_out);
            $display("Expected  : %h", expected);
            $display("Error Mask: %h", state_out ^ expected);
        end
        else
            $display("Round 2 PASSED");


        $display("Round 3");

        state_in  = 128'haa8f5f0361dde3ef82d24ad26832469a;
        round_key = 128'h3d80477d4716fe3e1e237e446d7a883b;
        expected  = 128'h486c4eee671d9d0d4de3b138d65f58e7;

        #5;

        if (state_out !== expected) begin
            $display("ERROR in Round 3");
            $display("Input     : %h", state_in);
            $display("Round Key : %h", round_key);
            $display("Output    : %h", state_out);
            $display("Expected  : %h", expected);
            $display("Error Mask: %h", state_out ^ expected);
        end
        else
            $display("Round 3 PASSED");

        $display("Simulation Finished");

        $stop;

    end

endmodule
