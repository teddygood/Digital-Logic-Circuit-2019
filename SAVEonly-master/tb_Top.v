`timescale 1ns/100ps

module tb_Top;
	reg clk, reset_n, m0_req, m0_wr;
	reg[15:0] m0_address;
	reg[31:0] m0_dout;
	wire m0_grant, a_interrupt, d_interrupt;
	wire[31:0] m_din;
	
	//
	wire[3:0] d_state;
	wire[4:0] a_state;
	wire[31:0] m_din2;
	wire[31:0] RESULT;
	wire r_rd_en;
	//
	
	Top Top_1(clk, reset_n, m0_req, m0_wr, m0_address, m0_dout, m0_grant, a_interrupt, d_interrupt, m_din, d_state, a_state, m_din2, RESULT, r_rd_en);
	
	always
		begin
			#5; clk = ~clk; //cycle of clock is 10ns
		end
	
	initial
		begin
			#4; clk = 1'b0; reset_n = 1'b1; m0_req = 1'b0; m0_wr = 1'b0;
			m0_address = 16'h0000; m0_dout = 32'h0000_0000; #10; //initialize
			reset_n = 1'b0; #10; reset_n = 1'b1; //resetted
			
			
			m0_req = 1'b1; m0_wr = 1'b1; m0_address = 16'h0200; m0_dout = 1000000000; #10;
			m0_address = 16'h0204; m0_dout = 1000000000; #10;
			//write two operand to memory
			m0_address = 16'h0300; m0_dout[13:0] = 14'b1111_0000_0001_00; #10; //x
			//write instruction to memory
			
			m0_address = 16'h0003; m0_dout = 32'h0000_0200; #10;
			m0_address = 16'h0004; m0_dout = 32'h0000_0110; #10;
			m0_address = 16'h0005; m0_dout = 32'h0000_0001; #10;
			//write first operand to DMAC
			m0_address = 16'h0006; m0_dout = 32'h0000_0001; #10;
			//DMAC push
			m0_address = 16'h0003; m0_dout = 32'h0000_0204; #10;
			m0_address = 16'h0004; m0_dout = 32'h0000_0111; #10;
			m0_address = 16'h0005; m0_dout = 32'h0000_0001; #10;
			//write second operand to DMAC
			m0_address = 16'h0006; m0_dout = 32'h0000_0001; #10;
			//DMAC push
			m0_address = 16'h0003; m0_dout = 32'h0000_0300; #10;
			m0_address = 16'h0004; m0_dout = 32'h0000_0103; #10;
			m0_address = 16'h0005; m0_dout = 32'h0000_0001; #10;
			//write instruction to DMAC
			m0_address = 16'h0006; m0_dout = 32'h0000_0001; #10;
			//DMAC push
			m0_address = 16'h0002; m0_dout = 32'h0000_0001; #10;
			//DMAC interrupt enable
			m0_address = 16'h0000; m0_dout = 32'h0000_0001; #10;
			m0_req = 1'b0; m0_wr = 1'b0; #1000;
			//DMAC start
			m0_req = 1'b1; m0_wr = 1'b1; m0_address = 16'h0001; m0_dout = 32'h0000_0000; #10;
			m0_address = 16'h0002; m0_dout = 32'h0000_0000; #10;
			//DMAC interrupt clear (interrupt disable)
			//Memory -> DMAC -> ALU
			
			m0_wr = 1'b1; m0_address = 16'h0102; m0_dout = 32'h0000_0001; #10;
			//ALU interrupt enable
			m0_address = 16'h0100; m0_dout = 32'h0000_0001; #10;
			m0_req = 1'b0; m0_wr = 1'b0; #1000;
			//ALU start
			m0_req = 1'b1; m0_wr = 1'b1; m0_address = 16'h0101; m0_dout = 32'h0000_0000; #10;
			m0_address = 16'h0102; m0_dout = 32'h0000_0000; #10;
			//ALU interrupt clear (interrupt disable)
			//before ALU -> after ALU
			
			m0_address = 16'h0003; m0_dout = 32'h0000_0104; #10;
			m0_address = 16'h0004; m0_dout = 32'h0000_0400; #10;
			m0_address = 16'h0005; m0_dout = 32'h0000_0001; #10;
			//write upper result to DMAC
			m0_address = 16'h0006; m0_dout = 32'h0000_0001; #10;
			//DMAC push
			m0_address = 16'h0003; m0_dout = 32'h0000_0104; #10;
			m0_address = 16'h0004; m0_dout = 32'h0000_0404; #10;
			m0_address = 16'h0005; m0_dout = 32'h0000_0001; #10;
			//write lower result to DMAC
			m0_address = 16'h0006; m0_dout = 32'h0000_0001; #10;
			//DMAC push
			m0_address = 16'h0002; m0_dout = 32'h0000_0001; #10;
			//DMAC interrupt enable
			m0_address = 16'h0000; m0_dout = 32'h0000_0001; #10;
			m0_req = 1'b0; m0_wr = 1'b0; #1000;
			//DMAC start
			m0_req = 1'b1; m0_wr = 1'b1; m0_address = 16'h0001; m0_dout = 32'h0000_0000; #10;
			m0_address = 16'h0002; m0_dout = 32'h0000_0000; #10;
			//DMAC interrupt clear (interrupt disable)
			//ALU -> DMAC -> Memory
			
			m0_wr = 1'b0; m0_address = 16'h0400; #10; //read upper result from Memory
			m0_address = 16'h0404; #10; //read lower result from Memory
			
			
			//
			//
			//
			//
			//
			//
			//
			//
			//
			//
		
	
			m0_req = 1'b1; m0_wr = 1'b1; m0_address = 16'h0200; m0_dout = 1234; #10;
			m0_address = 16'h0204; m0_dout = 5678; #10;
			//write two operand to memory
			m0_address = 16'h0300; m0_dout[13:0] = 14'b1101_0000_0001_00; #10; //+
			//write instruction to memory
			m0_address = 16'h0304; m0_dout[13:0] = 14'b1110_0000_0001_00; #10; //-
			//write instruction to memory
			m0_address = 16'h0308; m0_dout[13:0] = 14'b1111_0000_0001_00; #10; //*
			//write instruction to memory
			
			m0_address = 16'h0003; m0_dout = 32'h0000_0200; #10;
			m0_address = 16'h0004; m0_dout = 32'h0000_0110; #10;
			m0_address = 16'h0005; m0_dout = 32'h0000_0001; #10;
			//write first operand to DMAC
			m0_address = 16'h0006; m0_dout = 32'h0000_0001; #10;
			//DMAC push
			m0_address = 16'h0003; m0_dout = 32'h0000_0204; #10;
			m0_address = 16'h0004; m0_dout = 32'h0000_0111; #10;
			m0_address = 16'h0005; m0_dout = 32'h0000_0001; #10;
			//write second operand to DMAC
			m0_address = 16'h0006; m0_dout = 32'h0000_0001; #10;
			//DMAC push
			m0_address = 16'h0003; m0_dout = 32'h0000_0300; #10;
			m0_address = 16'h0004; m0_dout = 32'h0000_0103; #10;
			m0_address = 16'h0005; m0_dout = 32'h0000_0001; #10;
			//write instruction to DMAC
			m0_address = 16'h0006; m0_dout = 32'h0000_0001; #10;
			//DMAC push
			m0_address = 16'h0003; m0_dout = 32'h0000_0304; #10;
			m0_address = 16'h0004; m0_dout = 32'h0000_0103; #10;
			m0_address = 16'h0005; m0_dout = 32'h0000_0001; #10;
			//write instruction to DMAC
			m0_address = 16'h0006; m0_dout = 32'h0000_0001; #10;
			//DMAC push
			m0_address = 16'h0003; m0_dout = 32'h0000_0308; #10;
			m0_address = 16'h0004; m0_dout = 32'h0000_0103; #10;
			m0_address = 16'h0005; m0_dout = 32'h0000_0001; #10;
			//write instruction to DMAC
			m0_address = 16'h0006; m0_dout = 32'h0000_0001; #10;
			//DMAC push
			m0_address = 16'h0002; m0_dout = 32'h0000_0001; #10;
			//DMAC interrupt enable
			m0_address = 16'h0000; m0_dout = 32'h0000_0001; #10;
			m0_req = 1'b0; m0_wr = 1'b0; #3000;
			//DMAC start
			m0_req = 1'b1; m0_wr = 1'b1; m0_address = 16'h0001; m0_dout = 32'h0000_0000; #10;
			m0_address = 16'h0002; m0_dout = 32'h0000_0000; #10;
			//DMAC interrupt clear (interrupt disable)
			//Memory -> DMAC -> ALU
			
			m0_wr = 1'b1; m0_address = 16'h0102; m0_dout = 32'h0000_0001; #10;
			//ALU interrupt enable
			m0_address = 16'h0100; m0_dout = 32'h0000_0001; #10;
			m0_req = 1'b0; m0_wr = 1'b0; #3000;
			//ALU start
			m0_req = 1'b1; m0_wr = 1'b1; m0_address = 16'h0101; m0_dout = 32'h0000_0000; #10;
			m0_address = 16'h0102; m0_dout = 32'h0000_0000; #10;
			//ALU interrupt clear (interrupt disable)
			//before ALU -> after ALU
			
			m0_req = 1'b1; m0_wr = 1'b1; m0_address = 16'h0003; m0_dout = 32'h0000_0104; #10;
			m0_address = 16'h0004; m0_dout = 32'h0000_0410; #10;
			m0_address = 16'h0005; m0_dout = 32'h0000_0001; #10;
			//write upper result to DMAC
			m0_address = 16'h0006; m0_dout = 32'h0000_0001; #10;
			//DMAC push
			m0_address = 16'h0003; m0_dout = 32'h0000_0104; #10;
			m0_address = 16'h0004; m0_dout = 32'h0000_0414; #10;
			m0_address = 16'h0005; m0_dout = 32'h0000_0001; #10;
			//write lower result to DMAC
			m0_address = 16'h0006; m0_dout = 32'h0000_0001; #10;
			//DMAC push
			m0_address = 16'h0003; m0_dout = 32'h0000_0104; #10;
			m0_address = 16'h0004; m0_dout = 32'h0000_0418; #10;
			m0_address = 16'h0005; m0_dout = 32'h0000_0001; #10;
			//write upper result to DMAC
			m0_address = 16'h0006; m0_dout = 32'h0000_0001; #10;
			//DMAC push
			m0_address = 16'h0003; m0_dout = 32'h0000_0104; #10;
			m0_address = 16'h0004; m0_dout = 32'h0000_041C; #10;
			m0_address = 16'h0005; m0_dout = 32'h0000_0001; #10;
			//write lower result to DMAC
			m0_address = 16'h0006; m0_dout = 32'h0000_0001; #10;
			//DMAC push
			m0_address = 16'h0003; m0_dout = 32'h0000_0104; #10;
			m0_address = 16'h0004; m0_dout = 32'h0000_0420; #10;
			m0_address = 16'h0005; m0_dout = 32'h0000_0001; #10;
			//write upper result to DMAC
			m0_address = 16'h0006; m0_dout = 32'h0000_0001; #10;
			//DMAC push
			m0_address = 16'h0003; m0_dout = 32'h0000_0104; #10;
			m0_address = 16'h0004; m0_dout = 32'h0000_0424; #10;
			m0_address = 16'h0005; m0_dout = 32'h0000_0001; #10;
			//write lower result to DMAC
			m0_address = 16'h0006; m0_dout = 32'h0000_0001; #10;
			//DMAC push
			m0_address = 16'h0002; m0_dout = 32'h0000_0001; #10;
			//DMAC interrupt enable
			m0_address = 16'h0000; m0_dout = 32'h0000_0001; #10;
			m0_req = 1'b0; m0_wr = 1'b0; #3000;
			//DMAC start
			m0_req = 1'b1; m0_wr = 1'b1; m0_address = 16'h0001; m0_dout = 32'h0000_0000; #10;
			m0_address = 16'h0002; m0_dout = 32'h0000_0000; #10;
			//DMAC interrupt clear (interrupt disable)
			//ALU -> DMAC -> Memory
			
			m0_wr = 1'b0; m0_address = 16'h0400; #10; //read upper result from Memory
			m0_address = 16'h0404; #10; //read lower result from Memory
			m0_address = 16'h0410; #10; //read upper result from Memory
			m0_address = 16'h0414; #10; //read lower result from Memory
			m0_address = 16'h0418; #10; //read upper result from Memory
			m0_address = 16'h041C; #10; //read lower result from Memory
			m0_address = 16'h0420; #10; //read upper result from Memory
			m0_address = 16'h0424; #10; //read lower result from Memory
			
			
			//
			//
			//
			//
			//
			//
			//
			//
			//
			//
			
			
			m0_req = 1'b1; m0_wr = 1'b1; m0_address = 16'h0200; m0_dout = 1234; #10;
			m0_address = 16'h0204; m0_dout = 5678; #10;
			//write two operand to memory
			m0_address = 16'h0300; m0_dout[13:0] = 14'b1101_0000_0001_00; #10; //+
			//write instruction to memory
			m0_address = 16'h0304; m0_dout[13:0] = 14'b1110_0000_0001_00; #10; //-
			//write instruction to memory
			m0_address = 16'h0308; m0_dout[13:0] = 14'b1111_0000_0001_00; #10; //*
			//write instruction to memory
			
			m0_address = 16'h0003; m0_dout = 32'h0000_0200; #10;
			m0_address = 16'h0004; m0_dout = 32'h0000_0110; #10;
			m0_address = 16'h0005; m0_dout = 32'h0000_0001; #10;
			//write first operand to DMAC
			m0_address = 16'h0006; m0_dout = 32'h0000_0001; #10;
			//DMAC push
			m0_address = 16'h0003; m0_dout = 32'h0000_0204; #10;
			m0_address = 16'h0004; m0_dout = 32'h0000_0111; #10;
			m0_address = 16'h0005; m0_dout = 32'h0000_0001; #10;
			//write second operand to DMAC
			m0_address = 16'h0006; m0_dout = 32'h0000_0001; #10;
			//DMAC push
			m0_address = 16'h0003; m0_dout = 32'h0000_0300; #10;
			m0_address = 16'h0004; m0_dout = 32'h0000_0103; #10;
			m0_address = 16'h0005; m0_dout = 32'h0000_0001; #10;
			//write instruction to DMAC
			m0_address = 16'h0006; m0_dout = 32'h0000_0001; #10;
			//DMAC push
			m0_address = 16'h0003; m0_dout = 32'h0000_0304; #10;
			m0_address = 16'h0004; m0_dout = 32'h0000_0103; #10;
			m0_address = 16'h0005; m0_dout = 32'h0000_0001; #10;
			//write instruction to DMAC
			m0_address = 16'h0006; m0_dout = 32'h0000_0001; #10;
			//DMAC push
			m0_address = 16'h0003; m0_dout = 32'h0000_0308; #10;
			m0_address = 16'h0004; m0_dout = 32'h0000_0103; #10;
			m0_address = 16'h0005; m0_dout = 32'h0000_0001; #10;
			//write instruction to DMAC
			m0_address = 16'h0006; m0_dout = 32'h0000_0001; #10;
			//DMAC push
			m0_address = 16'h0002; m0_dout = 32'h0000_0001; #10;
			//DMAC interrupt enable
			m0_address = 16'h0000; m0_dout = 32'h0000_0001; #10;
			m0_req = 1'b0; m0_wr = 1'b0; #3000;
			//DMAC start
			m0_req = 1'b1; m0_wr = 1'b1; m0_address = 16'h0001; m0_dout = 32'h0000_0000; #10;
			m0_address = 16'h0002; m0_dout = 32'h0000_0000; #10;
			//DMAC interrupt clear (interrupt disable)
			//Memory -> DMAC -> ALU
			
			m0_wr = 1'b1; m0_address = 16'h0102; m0_dout = 32'h0000_0001; #10;
			//ALU interrupt enable
			m0_address = 16'h0100; m0_dout = 32'h0000_0001; #10;
			m0_req = 1'b0; m0_wr = 1'b0; #3000;
			//ALU start
			m0_req = 1'b1; m0_wr = 1'b1; m0_address = 16'h0101; m0_dout = 32'h0000_0000; #10;
			m0_address = 16'h0102; m0_dout = 32'h0000_0000; #10;
			//ALU interrupt clear (interrupt disable)
			//before ALU -> after ALU
			
			m0_req = 1'b1; m0_wr = 1'b1; m0_address = 16'h0003; m0_dout = 32'h0000_0104; #10;
			m0_address = 16'h0004; m0_dout = 32'h0000_0410; #10;
			m0_address = 16'h0005; m0_dout = 32'h0000_0001; #10;
			//write upper result to DMAC
			m0_address = 16'h0006; m0_dout = 32'h0000_0001; #10;
			//DMAC push
			m0_address = 16'h0003; m0_dout = 32'h0000_0104; #10;
			m0_address = 16'h0004; m0_dout = 32'h0000_0414; #10;
			m0_address = 16'h0005; m0_dout = 32'h0000_0001; #10;
			//write lower result to DMAC
			m0_address = 16'h0006; m0_dout = 32'h0000_0001; #10;
			//DMAC push
			m0_address = 16'h0003; m0_dout = 32'h0000_0104; #10;
			m0_address = 16'h0004; m0_dout = 32'h0000_0418; #10;
			m0_address = 16'h0005; m0_dout = 32'h0000_0001; #10;
			//write upper result to DMAC
			m0_address = 16'h0006; m0_dout = 32'h0000_0001; #10;
			//DMAC push
			m0_address = 16'h0003; m0_dout = 32'h0000_0104; #10;
			m0_address = 16'h0004; m0_dout = 32'h0000_041C; #10;
			m0_address = 16'h0005; m0_dout = 32'h0000_0001; #10;
			//write lower result to DMAC
			m0_address = 16'h0006; m0_dout = 32'h0000_0001; #10;
			//DMAC push
			m0_address = 16'h0003; m0_dout = 32'h0000_0104; #10;
			m0_address = 16'h0004; m0_dout = 32'h0000_0420; #10;
			m0_address = 16'h0005; m0_dout = 32'h0000_0001; #10;
			//write upper result to DMAC
			m0_address = 16'h0006; m0_dout = 32'h0000_0001; #10;
			//DMAC push
			m0_address = 16'h0003; m0_dout = 32'h0000_0104; #10;
			m0_address = 16'h0004; m0_dout = 32'h0000_0424; #10;
			m0_address = 16'h0005; m0_dout = 32'h0000_0001; #10;
			//write lower result to DMAC
			m0_address = 16'h0006; m0_dout = 32'h0000_0001; #10;
			//DMAC push
			m0_address = 16'h0002; m0_dout = 32'h0000_0001; #10;
			//DMAC interrupt enable
			m0_address = 16'h0000; m0_dout = 32'h0000_0001; #10;
			m0_req = 1'b0; m0_wr = 1'b0; #3000;
			//DMAC start
			m0_req = 1'b1; m0_wr = 1'b1; m0_address = 16'h0001; m0_dout = 32'h0000_0000; #10;
			m0_address = 16'h0002; m0_dout = 32'h0000_0000; #10;
			//DMAC interrupt clear (interrupt disable)
			//ALU -> DMAC -> Memory
			
			m0_wr = 1'b0; m0_address = 16'h0400; #10; //read upper result from Memory
			m0_address = 16'h0404; #10; //read lower result from Memory
			m0_address = 16'h0410; #10; //read upper result from Memory
			m0_address = 16'h0414; #10; //read lower result from Memory
			m0_address = 16'h0418; #10; //read upper result from Memory
			m0_address = 16'h041C; #10; //read lower result from Memory
			m0_address = 16'h0420; #10; //read upper result from Memory
			m0_address = 16'h0424; #10; //read lower result from Memory
		end
endmodule 