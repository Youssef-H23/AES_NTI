`include "aes_params.vh"

module AES_CBC_Decrypt (

    input  wire [`STATE_WIDTH-1:0] ciphertext,
    input  wire [`STATE_WIDTH-1:0] key,
    input  wire [`STATE_WIDTH-1:0] iv,

    output wire [`STATE_WIDTH-1:0] plaintext

);

    Decrypt_Top u_decrypt_top (

        .ciphertext (ciphertext),
        .key        (key),
        .iv         (iv),
        .plaintext  (plaintext)

    );

endmodule
