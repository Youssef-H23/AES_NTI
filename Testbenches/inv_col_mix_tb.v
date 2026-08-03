`timescale 1ns/1ps

module inv_col_mix_tb;
    reg  [127:0] state_in, expected;
    wire [127:0] state_out;

    inv_col_mix dut(.state_in(state_in), .state_out(state_out));
    initial begin
        state_in = 128'h046681e5e0cb199a48f8d37a2806264c; 
        expected = 128'hd4bf5d30e0b452aeb84111f11e2798e5;
        #5;
        if(state_out !== expected) begin
            $display("Error in testcase1");
            $display("Error Mask: %h", state_out ^ expected);
            $stop;
        end

        #5;
        state_in = 128'h584dcaf11b4b5aacdbe7caa81b6bb0e5; 
        expected = 128'h49db873b453953897f02d2f177de961a;
        #5;
        if(state_out !== expected) begin
            $display("Error in testcase2");
            $display("Error Mask: %h", state_out ^ expected);
            $stop;
        end

        #5;
        state_in = 128'h75ec0993200b633353c0cf7cbb25d0dc; 
        expected = 128'hacc1d6b8efb55a7b1323cfdf457311b5;
        #5;
        if(state_out !== expected) begin
            $display("Error in testcase3");
            $display("Error Mask: %h", state_out ^ expected);        
            $stop;
        end

        #5;
        state_in = 128'h0fd6daa9603138bf6fc0106b5eb31301;
        expected = 128'h52a4c89485116a28e3cf2fd7f6505e07;
        #5;
        if(state_out !== expected) begin
            $display("Error in testcase4");
            $display("Error Mask: %h", state_out ^ expected);   
            $stop;
        end

        #5;
        state_in = 128'h25d1a9adbd11d168b63a338e4c4cc0b0; 
        expected = 128'he1fb967ce8c8ae9b356cd2ba974ffb53;
        #5;
        if(state_out !== expected) begin
            $display("Error in testcase5");
            $display("Error Mask: %h", state_out ^ expected);   
            $stop;
        end

        #5;
        state_in = 128'h4b868d6d2c4a8980339df4e837d218d8; 
        expected = 128'ha14f3dfe78e803fc10d5a8df4c632923;
        #5;
        if(state_out !== expected) begin
            $display("Error in testcase6");
            $display("Error Mask: %h", state_out ^ expected);   
            $stop;
        end
        $stop;
    end
    initial begin
        $monitor("Input: %h, Output: %h, Expected: %h", state_in, state_out, expected);
    end
endmodule