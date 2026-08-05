`include "aes_params.vh"
module key_scheduler #(parameter NUM_ROUNDS = 10)(
    input  wire [4*(NUM_ROUNDS+1)*32-1:0] expanded_key,
    output wire [`STATE_WIDTH-1:0] round1_key,
    output wire [`STATE_WIDTH-1:0] round2_key,
    output wire [`STATE_WIDTH-1:0] round3_key,
    output wire [`STATE_WIDTH-1:0] round4_key,
    output wire [`STATE_WIDTH-1:0] round5_key,
    output wire [`STATE_WIDTH-1:0] round6_key,
    output wire [`STATE_WIDTH-1:0] round7_key,
    output wire [`STATE_WIDTH-1:0] round8_key,
    output wire [`STATE_WIDTH-1:0] round9_key,
    output wire [`STATE_WIDTH-1:0] round10_key
);
    assign round1_key = expanded_key[1*(`STATE_WIDTH) +:`STATE_WIDTH];
    assign round2_key = expanded_key[2*(`STATE_WIDTH) +:`STATE_WIDTH];
    assign round3_key = expanded_key[3*(`STATE_WIDTH) +:`STATE_WIDTH];
    assign round4_key = expanded_key[4*(`STATE_WIDTH) +:`STATE_WIDTH];
    assign round5_key = expanded_key[5*(`STATE_WIDTH) +:`STATE_WIDTH];
    assign round6_key = expanded_key[6*(`STATE_WIDTH) +:`STATE_WIDTH];
    assign round7_key = expanded_key[7*(`STATE_WIDTH) +:`STATE_WIDTH];
    assign round8_key = expanded_key[8*(`STATE_WIDTH) +:`STATE_WIDTH];
    assign round9_key = expanded_key[9*(`STATE_WIDTH) +:`STATE_WIDTH];
    assign round10_key = expanded_key[10*(`STATE_WIDTH) +:`STATE_WIDTH];
endmodule
