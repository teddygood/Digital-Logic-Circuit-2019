module ALU_Top(clk, reset_n, s_sel, s_wr, s_addr, s_din, s_dout, s_interrupt, wAddr, rAddr, re, we, wData, rData, o_rd_en, o_wr_en, o_din, o_dout, o_full, o_empty, o_wr_ack, o_wr_err, o_rd_ack, o_rd_err, o_data_count, r_rd_en, r_wr_en, r_din, r_dout, r_full, r_empty, r_wr_ack, r_wr_err, r_rd_ack, r_rd_err, r_data_count, alu_begin, alu_done, operand_state, instruction_state, need_pop, alu_state, operand1, operand2, result2, result1, RESULT);
	input clk, reset_n, s_sel, s_wr;
	input[15:0] s_addr;
	input[31:0] s_din;
	
	//
	output[3:0] wAddr, rAddr;
	output re;
	output we;
	output[31:0] wData, rData;
	//wire for register file
	
	output o_rd_en, o_wr_en;
	output[31:0] o_din;
	output[31:0] o_dout;
	output o_full, o_empty, o_wr_ack, o_wr_err, o_rd_ack, o_rd_err;
	output[3:0] o_data_count;
	//wire for operator fifo
	
	output r_rd_en, r_wr_en;
	output[31:0] r_din;
	output[31:0] r_dout;
	output r_full, r_empty, r_wr_ack, r_wr_err, r_rd_ack, r_rd_err;
	output[3:0] r_data_count;
	//wire for result fifo
	
	output alu_begin;
	output alu_done;
	//signal between slave and alu
	
	output operand_state, instruction_state, need_pop;
	output[4:0] alu_state;
	
	output[31:0] operand1, operand2, result2, result1;
	
	output[31:0] RESULT;
	//
	
	output[31:0] s_dout;
	output s_interrupt;
	
	ALU_registerfile_2 ALU_registerfile_2_1(clk, reset_n, wAddr, wData, we, re, rAddr, rData); //operand register file (16)
	fifo fifo_1(clk, reset_n, o_rd_en, o_wr_en, o_din, o_dout, o_full, o_empty, o_wr_ack, o_wr_err, o_rd_ack, o_rd_err, o_data_count); //operation fifo (8)
	DMAC_fifo DMAC_fifo_1(clk, reset_n, r_rd_en, r_wr_en, r_din, r_dout, r_full, r_empty, r_wr_ack, r_wr_err, r_rd_ack, r_rd_err, r_data_count); //result fifo (16)
	
	ALU_slave ALU_slave1(clk, reset_n, s_sel, s_wr, s_addr, s_din, o_wr_ack, o_wr_err, r_rd_ack, r_rd_err, r_dout, o_empty, alu_done, o_din, o_wr_en, r_rd_en, we, wAddr, wData, s_dout, s_interrupt, alu_begin, operand_state, instruction_state, need_pop, RESULT); //slave part      
	ALU_alu_top ALU_alu_top_1(clk, reset_n, alu_begin, o_empty, o_rd_err, o_rd_ack, o_dout, r_full, r_wr_err, r_wr_ack, rData, o_rd_en, r_wr_en, alu_done, re, rAddr, r_din, alu_state, operand1, operand2, result2, result1); //calculating part
endmodule 