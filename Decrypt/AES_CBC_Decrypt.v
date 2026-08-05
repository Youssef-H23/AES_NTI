`include "aes_params.vh"

module AES_CBC_Decrypt #(
    parameter KEY_BITS = 128
)(
    input  wire [4*`STATE_WIDTH-1:0] ciphertext,
    input  wire [`STATE_WIDTH-1:0] key,
    input  wire [`STATE_WIDTH-1:0] iv,

    output wire [4*`STATE_WIDTH-1:0] plaintext
);


    //---------------------------------------------------------
    // Split Ciphertext Blocks
    //---------------------------------------------------------

    wire [`STATE_WIDTH-1:0] C0;
    wire [`STATE_WIDTH-1:0] C1;
    wire [`STATE_WIDTH-1:0] C2;
    wire [`STATE_WIDTH-1:0] C3;


    assign C0 = ciphertext[4*`STATE_WIDTH-1 -: `STATE_WIDTH];
    assign C1 = ciphertext[3*`STATE_WIDTH-1 -: `STATE_WIDTH];
    assign C2 = ciphertext[2*`STATE_WIDTH-1 -: `STATE_WIDTH];
    assign C3 = ciphertext[1*`STATE_WIDTH-1 -: `STATE_WIDTH];



    //---------------------------------------------------------
    // AES Decryption Outputs
    //---------------------------------------------------------

    wire [`STATE_WIDTH-1:0] D0;
    wire [`STATE_WIDTH-1:0] D1;
    wire [`STATE_WIDTH-1:0] D2;
    wire [`STATE_WIDTH-1:0] D3;



    //---------------------------------------------------------
    // AES Decrypt Block 0
    //---------------------------------------------------------

    Decrypt_Top u_dec0 (

        .ciphertext (C0),
        .key        (key),
        .decrypted_state(D0)

    );


    //---------------------------------------------------------
    // AES Decrypt Block 1
    //---------------------------------------------------------

    Decrypt_Top u_dec1 (

        .ciphertext (C1),
        .key        (key),
        .decrypted_state(D1)

    );


    //---------------------------------------------------------
    // AES Decrypt Block 2
    //---------------------------------------------------------

    Decrypt_Top u_dec2 (

        .ciphertext (C2),
        .key        (key),
        .decrypted_state(D2)

    );


    //---------------------------------------------------------
    // AES Decrypt Block 3
    //---------------------------------------------------------

    Decrypt_Top u_dec3 (

        .ciphertext (C3),
        .key        (key),
        .decrypted_state(D3)

    );



    //---------------------------------------------------------
    // CBC XOR
    //---------------------------------------------------------

    assign plaintext[4*`STATE_WIDTH-1 -: `STATE_WIDTH] = D0 ^ iv;

    assign plaintext[3*`STATE_WIDTH-1 -: `STATE_WIDTH] = D1 ^ C0;

    assign plaintext[2*`STATE_WIDTH-1 -: `STATE_WIDTH] = D2 ^ C1;

    assign plaintext[1*`STATE_WIDTH-1 -: `STATE_WIDTH] = D3 ^ C2;


endmodule
