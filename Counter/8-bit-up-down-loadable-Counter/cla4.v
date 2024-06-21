module cla4(a, b, ci, s, co); // 4-bit carry look-ahead adder
    input [3:0] a, b;
    input ci; // c in
    output [3:0] s; // sum
    output co; // c out

    wire c1, c2, c3;

    fa_v2 U0_fa(.a(a[0]), .b(b[0]), .ci(ci), .s(s[0])); // instance full adder without carry out
    fa_v2 U1_fa(.a(a[1]), .b(b[1]), .ci(c1), .s(s[1]));
    fa_v2 U2_fa(.a(a[2]), .b(b[2]), .ci(c2), .s(s[2]));
    fa_v2 U3_fa(.a(a[3]), .b(b[3]), .ci(c3), .s(s[3]));
    clb4 U4_clb4(.a(a), .b(b), .ci(ci), .c1(c1), .c2(c2), .c3(c3), .co(co)); // instance carry look-ahead block

endmodule