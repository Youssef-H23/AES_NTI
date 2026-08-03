module inv_col_mix(
    input  [127:0] state_in, 
    output [127:0] state_out
);
    inv_col_mix_single col0 (.in(state_in[127:96]), .out(state_out[127:96]));
    inv_col_mix_single col1 (.in(state_in[95:64]), .out(state_out[95:64]));
    inv_col_mix_single col2 (.in(state_in[63:32]), .out(state_out[63:32]));
    inv_col_mix_single col3 (.in(state_in[31:0]), .out(state_out[31:0]));
endmodule

