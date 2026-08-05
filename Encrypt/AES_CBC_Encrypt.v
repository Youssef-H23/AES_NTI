`include "aes_params.vh"

module AES_CBC_Encrypt (
    input  wire [`STATE_WIDTH-1:0] plaintext,
    input  wire [`STATE_WIDTH-1:0] key,
    input  wire [`STATE_WIDTH-1:0] iv,
    output wire [`STATE_WIDTH-1:0] ciphertext
);

    Encrypt_Top u_encrypt_top (
        .plaintext  (plaintext),
        .key        (key),
        .iv         (iv),
        .ciphertext (ciphertext)
    );

endmodule
