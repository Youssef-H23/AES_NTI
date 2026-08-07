`include "aes_params.vh"
module key_expansion_tb();

    reg [127:0] key; reg [1407:0] expected_expansion;
    wire [1407:0] w;

    key_expansion dut (.key(key), .w(w));

    integer i,j;
    initial begin
        key = 128'h2b7e1516_28aed2a6_abf71588_09cf4f3c; 

        expected_expansion = {
                                128'hd014f9a8_c9ee2589_e13f0cc8_b6630ca6, // Round 10
                                128'hac7766f3_19fadc21_28d12941_575c006e, // Round 9 
                                128'head27321_b58dbad2_312bf560_7f8d292f, // Round 8 
                                128'h4e54f70e_5f5fc9f3_84a64fb2_4ea6dc4f, // Round 7 
                                128'h6d88a37a_110b3efd_dbf98641_ca0093fd, // Round 6 
                                128'hd4d1c6f8_7c839d87_caf2b8bc_11f915bc, // Round 5 
                                128'hef44a541_a8525b7f_b671253b_db0bad00, // Round 4 
                                128'h3d80477d_4716fe3e_1e237e44_6d7a883b, // Round 3 
                                128'hf2c295f2_7a96b943_5935807a_7359f67f, // Round 2 
                                128'ha0fafe17_88542cb1_23a33939_2a6c7605, // Round 1 
                                128'h2b7e1516_28aed2a6_abf71588_09cf4f3c  // Round 0
                            };
        #5;
        for (i=0;i<11;i=i+1) begin
            for(j=0;j<4;j=j+1) begin
                if (w[(i*128+j*4) +:4] !== expected_expansion[(i*128+j*4) +:4]) begin
                    $display("Error in round %0d, word %0d", i, 3-j);
                    $stop;
                end 
                else $display ("Pass: round %0d, word %0d", i, 3-j);
                #5;
            end
        end
        $display("Verification Complete");
        $finish;
    end

    reg [127:0] current_round_key;

    initial begin

        #4; 
        $display("=================================================================================");
        $display("                          AES-128 KEY EXPANSION OUTPUT                           ");
        $display("=================================================================================");
        $display("Round |    Word 0 (W0)   |    Word 1 (W1)   |    Word 2 (W2)   |    Word 3 (W3)   ");
        $display("---------------------------------------------------------------------------------");
        
        for (i = 0; i <= 10; i = i + 1) begin

            current_round_key = w[i*128 +: 128];

            $display("  %2d  |     %h     |     %h     |     %h     |     %h", 
                i, 
                current_round_key[127:96],  
                current_round_key[95:64],   
                current_round_key[63:32],   
                current_round_key[31:0]     
            );
        end
        $display("=================================================================================");
    end
endmodule

module key_expansion_pipelined_tb();

    reg [127:0] key; reg [1407:0] expected_expansion;
    wire [1407:0] w;
    reg clk, rst_n;
    key_expansion_pipelined dut (.clk(clk), .rst_n(rst_n), .key(key), .w(w));

    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end
    integer i,j;
    initial begin
        rst_n = 1;
        key = 128'h2b7e1516_28aed2a6_abf71588_09cf4f3c; 

        expected_expansion = {
                                128'hd014f9a8_c9ee2589_e13f0cc8_b6630ca6, // Round 10
                                128'hac7766f3_19fadc21_28d12941_575c006e, // Round 9 
                                128'head27321_b58dbad2_312bf560_7f8d292f, // Round 8 
                                128'h4e54f70e_5f5fc9f3_84a64fb2_4ea6dc4f, // Round 7 
                                128'h6d88a37a_110b3efd_dbf98641_ca0093fd, // Round 6 
                                128'hd4d1c6f8_7c839d87_caf2b8bc_11f915bc, // Round 5 
                                128'hef44a541_a8525b7f_b671253b_db0bad00, // Round 4 
                                128'h3d80477d_4716fe3e_1e237e44_6d7a883b, // Round 3 
                                128'hf2c295f2_7a96b943_5935807a_7359f67f, // Round 2 
                                128'ha0fafe17_88542cb1_23a33939_2a6c7605, // Round 1 
                                128'h2b7e1516_28aed2a6_abf71588_09cf4f3c  // Round 0
                            };
        repeat (10) @(negedge clk);
        for (i=0;i<11;i=i+1) begin
            for(j=0;j<4;j=j+1) begin
                if (w[(i*128+j*4) +:4] !== expected_expansion[(i*128+j*4) +:4]) begin
                    $display("Error in round %0d, word %0d", i, 3-j);
                    $stop;
                end 
                else $display ("Pass: round %0d, word %0d", i, 3-j);
            end
        end
        #5;
        $display("Verification Complete");
        $finish;
    end

    reg [127:0] current_round_key;

    initial begin

        repeat (10) @(negedge clk); 
        $display("=================================================================================");
        $display("                          AES-128 KEY EXPANSION OUTPUT                           ");
        $display("=================================================================================");
        $display("Round |    Word 0 (W0)   |    Word 1 (W1)   |    Word 2 (W2)   |    Word 3 (W3)   ");
        $display("---------------------------------------------------------------------------------");
        
        for (i = 0; i <= 10; i = i + 1) begin

            current_round_key = w[i*128 +: 128];

            $display("  %2d  |     %h     |     %h     |     %h     |     %h", 
                i, 
                current_round_key[127:96],  
                current_round_key[95:64],   
                current_round_key[63:32],   
                current_round_key[31:0]     
            );
        end
        $display("=================================================================================");
    end
endmodule

module next_key_tb ();
    reg  [3:0]r; 
    reg  [127:0]in, expected;
    wire [127:0]out;
    next_key dut (.r(r), .in(in), .out(out));
    
    initial begin
        in = 128'h2b7e1516_28aed2a6_abf71588_09cf4f3c;
        r = 1;
        #5;
        $display("=========================================================================");
        $display("Round |    Rotword    |     SubWord     |     Rcon    |      T(W)     ");
        $display("-------------------------------------------------------------------------");
        $display("  %2d  |     %h     |     %h     |     %h     |     %h", 
            r, 
            dut.rotword,  
            dut.subword,   
            dut.rcon,   
            dut.t_w     
        );
        $display("Out = %h", out);
        $display("=========================================================================");

        in = 128'ha0fafe17_88542cb1_23a33939_2a6c7605;
        r = 2;
        #5;
        $display("=========================================================================");
        $display("Round |    Rotword    |     SubWord     |     Rcon    |      T(W)     ");
        $display("-------------------------------------------------------------------------");
        $display("  %2d  |     %h     |     %h     |     %h     |     %h", 
            r, 
            dut.rotword,  
            dut.subword,   
            dut.rcon,   
            dut.t_w     
        );
        $display("Out = %h", out);
        $display("=========================================================================");
        
    end
endmodule
