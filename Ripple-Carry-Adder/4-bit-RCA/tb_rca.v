`timescale 1ns/100ps			// Setting the Time Unit of Simulation

module tb_rca;					// ripple carry adder testbench
reg[3:0] tb_a, tb_b;
reg tb_ci;
wire[3:0] tb_s;
wire tb_co;
wire [4:0] tb_result;
 
rca U0_rca(.a(tb_a), .b(tb_b), .ci(tb_ci), .s(tb_s), .co(tb_co));		// ripple carry adder module

initial begin
  tb_a=4'b0; tb_b=4'b0; tb_ci=0;			// Start value
  #10; tb_a=4'b0001; tb_b=4'b0001;		// Change value
  #10; tb_a=4'b0010; tb_b=4'b0011;
  #10; tb_a=4'b0111; tb_b=4'b0111;
  #10; tb_a=4'b1111; tb_b=4'b1111;
  #10; tb_ci=1;
  #10; $stop;
end

  assign tb_result = {tb_co,tb_s};		// Connect sum and carry out to check the results together.
endmodule
