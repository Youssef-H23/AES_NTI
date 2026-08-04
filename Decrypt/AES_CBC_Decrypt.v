module AES_CBC_Decrypt (
    input  wire [`STATE_WIDTH-1:0] state_in,
    input  wire [`STATE_WIDTH-1:0] round_key,
    output wire [`STATE_WIDTH-1:0] state_out
);

    Decrypt_Top u_decrypt_top (
        .state_in  (state_in),
        .round_key (round_key),
        .state_out (state_out)
    );

    add_vector u_add_vector (
        .plaintext (state_out),
        .vector    (round_key),
        .state_out (state_out)
    );
endmodule