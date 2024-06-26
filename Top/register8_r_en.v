module register8_r_en(clk, reset_n, d_in, d_out, en); // Resettable enabled 8-bit register
input	clk, reset_n, en; 
input [7:0] d_in;   
output [7:0] d_out; 
	
// instance Resettable enabled D flip flop
_dff_r_en U0_dff_r_en(.clk(clk), .reset_n(reset_n), .en(en), .d(d_in[0]), .q(d_out[0])); 
_dff_r_en U1_dff_r_en(.clk(clk), .reset_n(reset_n), .en(en), .d(d_in[1]), .q(d_out[1])); 
_dff_r_en U2_dff_r_en(.clk(clk), .reset_n(reset_n), .en(en), .d(d_in[2]), .q(d_out[2])); 
_dff_r_en U3_dff_r_en(.clk(clk), .reset_n(reset_n), .en(en), .d(d_in[3]), .q(d_out[3])); 
_dff_r_en U4_dff_r_en(.clk(clk), .reset_n(reset_n), .en(en), .d(d_in[4]), .q(d_out[4])); 
_dff_r_en U5_dff_r_en(.clk(clk), .reset_n(reset_n), .en(en), .d(d_in[5]), .q(d_out[5])); 
_dff_r_en U6_dff_r_en(.clk(clk), .reset_n(reset_n), .en(en), .d(d_in[6]), .q(d_out[6])); 
_dff_r_en U7_dff_r_en(.clk(clk), .reset_n(reset_n), .en(en), .d(d_in[7]), .q(d_out[7])); 
	
endmodule