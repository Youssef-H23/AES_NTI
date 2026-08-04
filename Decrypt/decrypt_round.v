`include "aes_params.vh"

module decrypt_round(

    input  wire [`STATE_WIDTH-1:0] state_in,
    input  wire [`STATE_WIDTH-1:0] round_key,
    output wire [`STATE_WIDTH-1:0] state_out

);

wire [`STATE_WIDTH-1:0] add_key_state;
wire [`STATE_WIDTH-1:0] inv_mix_state;
wire [`STATE_WIDTH-1:0] inv_shift_state;

//-------------------------
// AddRoundKey
//-------------------------
add_round_key u_addroundkey (
    .state_in  (state_in),
    .round_key (round_key),
    .state_out (add_key_state)
);

//-------------------------
// InvMixColumns
//-------------------------
inv_col_mix u_invcolmix (
    .state_in  (add_key_state),
    .state_out (inv_mix_state)
);

//-------------------------
// InvShiftRows
//-------------------------
InvShiftRows u_invshiftrows (
    .state_in  (inv_mix_state),
    .state_out (inv_shift_state)
);

//-------------------------
// InvSubBytes
//-------------------------
inv_subbytes u_inv_subbytes (
    .i_state (inv_shift_state),
    .o_state (state_out)
);

endmodule
