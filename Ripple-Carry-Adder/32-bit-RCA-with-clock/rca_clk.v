module rca_clk(clock,a,b,ci,s_rca,co_rca);		// ripple carry adder with clock
input clock;
input [31:0] a,b;
input ci;
output [31:0] s_rca;
output co_rca;

reg [31:0] reg_a, reg_b;
reg reg_ci;
reg [31:0] reg_s_rca;
reg reg_co_rca;

wire [31:0] wire_s_rca;
wire wire_co_rca;

always @ (posedge clock)
begin
	reg_a <= a;
	reg_b <= b;
	reg_ci <= ci;
	reg_s_rca <= wire_s_rca;
	reg_co_rca <= wire_co_rca;
end

rca32 U0_rca32(.a(reg_a), .b(reg_b), .ci(reg_ci), .s(wire_s_rca), .co(wire_co_rca));

assign s_rca = reg_s_rca;
assign co_rca = reg_co_rca;

endmodule
