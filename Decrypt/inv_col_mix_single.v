module inv_col_mix_single(
    input  [31:0]in,
    output [31:0]out
);

    wire [7:0]s_inv0, s_inv1, s_inv2, s_inv3;

    assign s_inv3 = in[07:00]; 
    assign s_inv2 = in[15:08]; 
    assign s_inv1 = in[23:16]; 
    assign s_inv0 = in[31:24];

    //0e*s0 + 0b*s1 + 0d*s2 + 09*s3
    assign out [31:24] = (xtime_8(s_inv0)^xtime_4(s_inv0)^xtime_2(s_inv0)) ^ (xtime_8(s_inv1)^xtime_2(s_inv1)^s_inv1) ^ (xtime_8(s_inv2)^xtime_4(s_inv2)^s_inv2) ^ (xtime_8(s_inv3)^s_inv3);
    //09*s0 + 0e*s1 + 0b*s2 + 0d*s3
    assign out [23:16] = (xtime_8(s_inv0)^s_inv0) ^ (xtime_8(s_inv1)^xtime_4(s_inv1)^xtime_2(s_inv1)) ^ (xtime_8(s_inv2)^xtime_2(s_inv2)^s_inv2) ^ (xtime_8(s_inv3)^xtime_4(s_inv3)^s_inv3);
    //0d*s0 + 09*s1 + 0e*s2 + 0b*s3
    assign out [15:08] = (xtime_8(s_inv0)^xtime_4(s_inv0)^s_inv0) ^ (xtime_8(s_inv1)^s_inv1) ^ (xtime_8(s_inv2)^xtime_4(s_inv2)^xtime_2(s_inv2)) ^ (xtime_8(s_inv3)^xtime_2(s_inv3)^s_inv3);
    //0b*s0 + 0d*s1 + 09*s2 + 0e*s3
    assign out [07:00] = (xtime_8(s_inv0)^xtime_2(s_inv0)^s_inv0) ^ (xtime_8(s_inv1)^xtime_4(s_inv1)^s_inv1) ^ (xtime_8(s_inv2)^s_inv2) ^ (xtime_8(s_inv3)^xtime_4(s_inv3)^xtime_2(s_inv3));

    function [7:0] xtime_2 (input [7:0] in_byte); begin
        xtime_2 = {in_byte[6:0], 1'b0} ^ (in_byte[7] ? 8'h1B : 8'h00);    
    end
    endfunction
    function [7:0] xtime_4 (input [7:0] in_byte); begin
        xtime_4 = xtime_2(xtime_2(in_byte));    
    end
    endfunction
    function [7:0] xtime_8 (input [7:0] in_byte); begin
        xtime_8 = xtime_2(xtime_4(in_byte));    
    end
    endfunction
endmodule
