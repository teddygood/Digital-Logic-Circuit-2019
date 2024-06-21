module mx8(a, b, c, d, e, f, g, h, s2, s1, s0, y); // 1 bit 8-to-1 Multiplexer
    input a, b, c, d, e, f, g, h;     
    input s0, s1, s2;           // selection signal
    output y;

    wire w0, w1, w2, w3, w4, w5;

    // step 1 
    mx2 U0_mx2(.d0(a), .d1(b), .s(s0), .y(w0));     // instance 1 bit 2-to-1 Multiplexer
    mx2 U1_mx2(.d0(c), .d1(d), .s(s0), .y(w1));     
    mx2 U2_mx2(.d0(e), .d1(f), .s(s0), .y(w2));     
    mx2 U3_mx2(.d0(g), .d1(h), .s(s0), .y(w3));     
    // step 2
    mx2 U4_mx2(.d0(w0), .d1(w1), .s(s1), .y(w4));   
    mx2 U5_mx2(.d0(w2), .d1(w3), .s(s1), .y(w5));   
    // step 3
    mx2 U6_mx2(.d0(w4), .d1(w5), .s(s2), .y(y));        
    
endmodule