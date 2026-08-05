`include "aes_params.vh"
module Decrypt_Top (
    input  wire [`STATE_WIDTH-1:0] state_in,
    input  wire [`STATE_WIDTH-1:0] round_key,
    output wire [`STATE_WIDTH-1:0] state_out
);
    decrypt_initial_round u_decrypt_initial_round (
        .state_in  (state_in),
        .round_key (round_key),
        .state_out (state_out)
    );

    decrypt_round u_decrypt_round (
        .state_in  (state_out),
        .round_key (round_key),
        .state_out (state_out)
    );

    key_expansion u_key_expansion (
        .round_key (round_key),
        .next_round_key (round_key)
    );

    add_round_key u_add_round_key (
        .state_in  (state_out),
        .round_key (round_key),
        .state_out (state_out)
    );

endmodule