module decrypt_initial_round
#(
    parameter STATE_WIDTH = 128
)
(
    input  wire [STATE_WIDTH-1:0] state_in,
    input  wire [STATE_WIDTH-1:0] round_key,
    output wire [STATE_WIDTH-1:0] state_out
);

    wire [STATE_WIDTH-1:0] add_round_key_out;
    wire [STATE_WIDTH-1:0] inv_shift_rows_out;

    // AddRoundKey
    add_round_key u_add_round_key (
        .state_in(state_in),
        .round_key(round_key),
        .state_out(add_round_key_out)
    );

    // InvShiftRows
    InvShiftRows #(
        .STATE_WIDTH(STATE_WIDTH)
    ) u_inv_shift_rows (
        .state_in(add_round_key_out),
        .state_out(inv_shift_rows_out)
    );

    // InvSubBytes
    inv_subbytes #(
        .STATE_WIDTH(STATE_WIDTH),
        .BYTE_WIDTH(8)
    ) u_inv_subbytes (
        .i_state(inv_shift_rows_out),
        .o_state(state_out)
    );

endmodule