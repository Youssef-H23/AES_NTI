`include "aes_params.vh"
module Encrypt_Top #(NUM_ROUNDS = 10)(
/*--------------- Clock/Reset ---------------*/  
    input  wire                    clk,
    input  wire                    rst_n,
    input  wire [`STATE_WIDTH-1:0] initial_vector,
    input  wire [`STATE_WIDTH-1:0] key,
/*-------------- Key Expansions -------------*/
    input  wire [`STATE_WIDTH-1:0] round1_key,
    input  wire [`STATE_WIDTH-1:0] round2_key,
    input  wire [`STATE_WIDTH-1:0] round3_key,
    input  wire [`STATE_WIDTH-1:0] round4_key,
    input  wire [`STATE_WIDTH-1:0] round5_key,
    input  wire [`STATE_WIDTH-1:0] round6_key,
    input  wire [`STATE_WIDTH-1:0] round7_key,
    input  wire [`STATE_WIDTH-1:0] round8_key,
    input  wire [`STATE_WIDTH-1:0] round9_key,
    input  wire [`STATE_WIDTH-1:0] round10_key,
/*--------- Plain Text & Cipher Text ---------*/    
    input  wire [`STATE_WIDTH-1:0] plain_text,
    output wire [`STATE_WIDTH-1:0] cipher_text
);
    
    wire [`STATE_WIDTH-1:0] round1_state_next;
    wire [`STATE_WIDTH-1:0] round2_state_next;
    wire [`STATE_WIDTH-1:0] round3_state_next;
    wire [`STATE_WIDTH-1:0] round4_state_next;
    wire [`STATE_WIDTH-1:0] round5_state_next;
    wire [`STATE_WIDTH-1:0] round6_state_next;
    wire [`STATE_WIDTH-1:0] round7_state_next;
    wire [`STATE_WIDTH-1:0] round10_state_next;

    reg  [`STATE_WIDTH-1:0] round1_state_reg;
    reg  [`STATE_WIDTH-1:0] round2_state_reg;
    reg  [`STATE_WIDTH-1:0] round3_state_reg;
    reg  [`STATE_WIDTH-1:0] round4_state_reg;
    reg  [`STATE_WIDTH-1:0] round5_state_reg;
    reg  [`STATE_WIDTH-1:0] round6_state_reg;
    reg  [`STATE_WIDTH-1:0] round7_state_reg;
    reg  [`STATE_WIDTH-1:0] round10_state_reg;

    wire [`STATE_WIDTH-1:0] round0_state_out;
    wire [`STATE_WIDTH-1:0] round1_state_out;
    wire [`STATE_WIDTH-1:0] round2_state_out;
    wire [`STATE_WIDTH-1:0] round3_state_out;
    wire [`STATE_WIDTH-1:0] round4_state_out;
    wire [`STATE_WIDTH-1:0] round5_state_out;
    wire [`STATE_WIDTH-1:0] round6_state_out;
    wire [`STATE_WIDTH-1:0] round7_state_out;
    wire [`STATE_WIDTH-1:0] round10_state_out;

    assign round1_state_out = round1_state_reg;
    assign round2_state_out = round2_state_reg;
    assign round3_state_out = round3_state_reg;
    assign round4_state_out = round4_state_reg;
    assign round5_state_out = round5_state_reg;
    assign round6_state_out = round6_state_reg;
    assign round7_state_out = round7_state_reg;
    assign round8_state_out = round8_state_reg;
    assign round9_state_out = round9_state_reg;
    assign round10_state_out = round10_state_reg;

    assign cipher_text = round10_state_out;

    always @(posedge clk or negedge rst_n) begin
        if(rst_n) begin
            round1_state_reg <= 'b0;
            round2_state_reg <= 'b0;
            round3_state_reg <= 'b0;
            round4_state_reg <= 'b0;
            round5_state_reg <= 'b0;
            round6_state_reg <= 'b0;
            round7_state_reg <= 'b0;
            round8_state_reg <= 'b0;
            round9_state_reg <= 'b0;
            round10_state_reg <= 'b0;
        end else begin
            round1_state_reg <= round1_state_next;
            round2_state_reg <= round2_state_next;
            round3_state_reg <= round3_state_next;
            round4_state_reg <= round4_state_next;
            round5_state_reg <= round5_state_next;
            round6_state_reg <= round6_state_next;
            round7_state_reg <= round7_state_next;
            round8_state_reg <= round8_state_next;
            round9_state_reg <= round9_state_next;
            round10_state_reg <= round10_state_next;
        end
    end

    add_round_key u_add_round_key (
        .state_in  (plain_text),
        .round_key (key),
        .state_out (round0_state_out)
    );

    encrypt_round u_encrypt_round1 (
        .state_in  (round0_state_out),
        .round_key (round1_key),
        .state_out (round1_state_next)
    );

    encrypt_round u_encrypt_round2 (
        .state_in  (round1_state_out),
        .round_key (round2_key),
        .state_out (round2_state_next)
    );

    encrypt_round u_encrypt_round3 (
        .state_in  (round2_state_out),
        .round_key (round3_key),
        .state_out (round3_state_next)
    );

    encrypt_round u_encrypt_round4 (
        .state_in  (round3_state_out),
        .round_key (round4_key),
        .state_out (round4_state_next)
    );

    encrypt_round u_encrypt_round5 (
        .state_in  (round4_state_out),
        .round_key (round5_key),
        .state_out (round5_state_next)
    );

    encrypt_round u_encrypt_round6 (
        .state_in  (round5_state_out),
        .round_key (round6_key),
        .state_out (round6_state_next)
    );

    encrypt_round u_encrypt_round7 (
        .state_in  (round6_state_out),
        .round_key (round7_key),
        .state_out (round7_state_next)
    );

    encrypt_round u_encrypt_round8 (
        .state_in  (round7_state_out),
        .round_key (round8_key),
        .state_out (round8_state_next)
    );

    encrypt_round u_encrypt_round9 (
        .state_in  (round8_state_out),
        .round_key (round9_key),
        .state_out (round9_state_next)
    );


    encrypt_final_round u_encrypt_final_round (
        .state_in  (round9_state_out),
        .round_key (round10_key),
        .state_out (round10_state_next)
    );

endmodule
