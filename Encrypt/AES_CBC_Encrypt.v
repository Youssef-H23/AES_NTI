`include "aes_params.vh"

module AES_CBC_Encrypt #(
    parameter KEY_BITS = 128
)(

    input wire [4*`STATE_WIDTH-1:0] plaintext,
    input wire [`STATE_WIDTH-1:0] key,
    input wire [`STATE_WIDTH-1:0] iv,

    output wire [4*`STATE_WIDTH-1:0] ciphertext

);


    //---------------------------------------------------------
    // Split Plaintext Blocks
    //---------------------------------------------------------

    wire [`STATE_WIDTH-1:0] P0;
    wire [`STATE_WIDTH-1:0] P1;
    wire [`STATE_WIDTH-1:0] P2;
    wire [`STATE_WIDTH-1:0] P3;


    assign P0 = plaintext[4*`STATE_WIDTH-1 -: `STATE_WIDTH];
    assign P1 = plaintext[3*`STATE_WIDTH-1 -: `STATE_WIDTH];
    assign P2 = plaintext[2*`STATE_WIDTH-1 -: `STATE_WIDTH];
    assign P3 = plaintext[1*`STATE_WIDTH-1 -: `STATE_WIDTH];



    //---------------------------------------------------------
    // CBC XOR Inputs
    //---------------------------------------------------------

    wire [`STATE_WIDTH-1:0] X0;
    wire [`STATE_WIDTH-1:0] X1;
    wire [`STATE_WIDTH-1:0] X2;
    wire [`STATE_WIDTH-1:0] X3;


    assign X0 = P0 ^ iv;



    //---------------------------------------------------------
    // AES Encryption Outputs
    //---------------------------------------------------------

    wire [`STATE_WIDTH-1:0] C0;
    wire [`STATE_WIDTH-1:0] C1;
    wire [`STATE_WIDTH-1:0] C2;
    wire [`STATE_WIDTH-1:0] C3;



    //---------------------------------------------------------
    // Block 0
    //---------------------------------------------------------

    Encrypt_Top u_enc0 (

        .plaintext (X0),
        .key       (key),
        .ciphertext(C0)

    );



    assign X1 = P1 ^ C0;


    //---------------------------------------------------------
    // Block 1
    //---------------------------------------------------------

    Encrypt_Top u_enc1 (

        .plaintext (X1),
        .key       (key),
        .ciphertext(C1)

    );



    assign X2 = P2 ^ C1;


    //---------------------------------------------------------
    // Block 2
    //---------------------------------------------------------

    Encrypt_Top u_enc2 (

        .plaintext (X2),
        .key       (key),
        .ciphertext(C2)

    );



    assign X3 = P3 ^ C2;


    //---------------------------------------------------------
    // Block 3
    //---------------------------------------------------------

    Encrypt_Top u_enc3 (

        .plaintext (X3),
        .key       (key),
        .ciphertext(C3)

    );



    //---------------------------------------------------------
    // Combine Ciphertext
    //---------------------------------------------------------

    assign ciphertext[4*`STATE_WIDTH-1 -: `STATE_WIDTH] = C0;

    assign ciphertext[3*`STATE_WIDTH-1 -: `STATE_WIDTH] = C1;

    assign ciphertext[2*`STATE_WIDTH-1 -: `STATE_WIDTH] = C2;

    assign ciphertext[1*`STATE_WIDTH-1 -: `STATE_WIDTH] = C3;


endmodule
