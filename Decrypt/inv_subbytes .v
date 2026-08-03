//==============================================================================
// Module Name : inv_subbytes
// Description :
//   Performs the AES inverse SubBytes transformation.
//
// Functionality:
//   - Receives the 128-bit AES state.
//   - Splits the state into sixteen 8-bit bytes.
//   - Applies the AES inverse S-Box substitution to each byte in parallel.
//   - Combines the substituted bytes into a new 128-bit output state.
//
// Inputs:
//   - i_state : 128-bit encrypted AES state.
//
// Outputs:
//   - o_state : 128-bit state after InvSubBytes transformation.
//
// Notes:
//   - Pure combinational logic.
//   - Instantiates sixteen InvSBox modules.
//   - Each byte is processed independently.
//   - Used during AES decryption rounds.
//   - Fully compliant with AES inverse SubBytes operation.
//==============================================================================

module inv_subbytes #(
    parameter STATE_WIDTH = 128,
    parameter BYTE_WIDTH  = 8
)
(
    input wire [STATE_WIDTH-1:0] i_state,
    output wire [STATE_WIDTH-1:0] o_state
);

localparam NUM_BYTES = STATE_WIDTH/BYTE_WIDTH;

genvar i;

generate
    for(i=0;i<NUM_BYTES;i=i+1)
    begin: gen_inv_sbox

        inv_sbox u_inv_sbox(
            .i_data(
                i_state[STATE_WIDTH-1-i*BYTE_WIDTH -: BYTE_WIDTH]
            ),

            .o_data(
                o_state[STATE_WIDTH-1-i*BYTE_WIDTH -: BYTE_WIDTH]
            )
        );

    end
endgenerate

endmodule