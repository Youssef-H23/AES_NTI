`include "aes_params.vh"

module Encrypt_Top(
    input  wire [`STATE_WIDTH-1:0] plaintext,
    input  wire [`STATE_WIDTH-1:0] key,
    input  wire [`STATE_WIDTH-1:0] iv,
    output wire [`STATE_WIDTH-1:0] ciphertext
);

    wire [`STATE_WIDTH-1:0] cbc_in;
    wire [4*(`NUM_ROUNDS+1)*32-1:0] w;
    
    // Round keys array: r_key[0] to r_key[NUM_ROUNDS]
    wire [`STATE_WIDTH-1:0] r_key [0:`NUM_ROUNDS];

    // Round states array: state[0] to state[NUM_ROUNDS]
    wire [`STATE_WIDTH-1:0] state [0:`NUM_ROUNDS];

    // 1. CBC IV XOR
    add_vector u_add_vector (
        .plaintext (plaintext),
        .vector    (iv),
        .state_out (cbc_in)
    );

    // 2. Key Expansion
    key_expansion u_key_expansion (
        .key(key),
        .w(w)
    );

    // 3. Key Schedulers generated via `generate` loop (0 to NUM_ROUNDS)
    genvar i;
    generate
        for (i = 0; i <= `NUM_ROUNDS; i = i + 1) begin : gen_key_scheduler
            key_scheduler #(
                .KEY_BITS(`KEY_BITS),
                .NUM_ROUNDS(`NUM_ROUNDS)
            ) u_ks (
                .w(w),
                .round_idx(4'(i)),
                .decrypt(1'b0),
                .round_key(r_key[i])
            );
        end
    endgenerate

    // 4. Round 0 (AddRoundKey)
    add_round_key u_round0 (
        .state_in  (cbc_in),
        .round_key (r_key[0]),
        .state_out (state[0])
    );

    // 5. Rounds 1 to NUM_ROUNDS-1 generated via `generate` loop
    genvar r;
    generate
        for (r = 1; r < `NUM_ROUNDS; r = r + 1) begin : gen_encrypt_rounds
            encrypt_round u_round (
                .state_in  (state[r-1]),
                .round_key (r_key[r]),
                .state_out (state[r])
            );
        end
    endgenerate

    // 6. Final Round (NUM_ROUNDS)
    encrypt_final_round u_final_round (
        .state_in  (state[`NUM_ROUNDS-1]),
        .round_key (r_key[`NUM_ROUNDS]),
        .state_out (state[`NUM_ROUNDS])
    );

    assign ciphertext = state[`NUM_ROUNDS];

endmodule
