 //readme
//top chip 

//released:04/12/2022
//author:qilong han
module noc_chip(
input rst_n,
input clk,
input enable_wire,
input mode_wire,
input dbg_mode_wire,
input clk_global,
input flush_wire,
input [3:0]rate_wire,
output task_send_finish_lc_00,
output task_send_finish_lc_10,
output task_send_finish_lc_11,
output task_send_finish_lc_01,
output task_receive_finish_lc_00,
output task_receive_finish_lc_01,
output task_receive_finish_lc_10,
output task_receive_finish_lc_11,
input [1:0]send_finish_flag00,
input [1:0]send_finish_flag01,
input [1:0]send_finish_flag10,
input [1:0]send_finish_flag11,
input [1:0]receive_finish_flag00,
input [1:0]receive_finish_flag01,
input [1:0]receive_finish_flag10,
input [1:0]receive_finish_flag11,
input [5:0]si_dst_seq00,
input [5:0]si_dst_seq01,
input [5:0]si_dst_seq10,
input [5:0]si_dst_seq11,
input start_in_00,
input start_out_00,
input start_in_01,
input start_out_01,
input start_in_10,
input start_out_10,
input start_in_11,
input start_out_11
);

wire net_rst_n;
wire net_clk;
wire net_enable_wire;
wire net_mode_wire;
wire net_dbg_mode_wire;
wire net_clk_global;
wire net_flush_wire;
wire [3:0] net_rate_wire;
wire net_task_send_finish_lc_00;
wire net_task_send_finish_lc_10;
wire net_task_send_finish_lc_11;
wire net_task_send_finish_lc_01;
wire net_task_receive_finish_lc_00;
wire net_task_receive_finish_lc_01;
wire net_task_receive_finish_lc_10;
wire net_task_receive_finish_lc_11;
wire [1:0] net_send_finish_flag00;
wire [1:0] net_send_finish_flag01;
wire [1:0] net_send_finish_flag10;
wire [1:0] net_send_finish_flag11;
wire [1:0] net_receive_finish_flag00;
wire [1:0] net_receive_finish_flag01;
wire [1:0] net_receive_finish_flag10;
wire [1:0] net_receive_finish_flag11;
wire [5:0] net_si_dst_seq00;
wire [5:0] net_si_dst_seq01;
wire [5:0] net_si_dst_seq10;
wire [5:0] net_si_dst_seq11;
wire net_start_in_00;
wire net_start_out_00;
wire net_start_in_01;
wire net_start_out_01;
wire net_start_in_10;
wire net_start_out_10;
wire net_start_in_11;
wire net_start_out_11;


HPDWUW1416DGP
	HPDWUW1416DGP_clk(.PAD(clk),.C(net_clk),.IE(1'b1)),
	HPDWUW1416DGP_rst_n(.PAD(rstn),.C(net_rst_n),.IE(1'b1)),
	HPDWUW1416DGP_enable_wire(.PAD(enable_wire),.C(net_enable_wire),.IE(1'b1)),
	HPDWUW1416DGP_mode_wire(.PAD(mode_wire),.C(net_mode_wire),.IE(1'b1)),
	HPDWUW1416DGP_dbg_mode_wire(.PAD(dbg_mode_wire),.C(net_dbg_mode_wire),.IE(1'b1)),
	HPDWUW1416DGP_clk_global(.PAD(clk_global),.C(net_clk_global),.IE(1'b1)),
	HPDWUW1416DGP_flush_wire(.PAD(flush_wire),.C(net_flush_wire),.IE(1'b1)),
	HPDWUW1416DGP_rate_wire0(.PAD(rate_wire[0]),.C(net_rate_wire[0]),.IE(1'b1)),
	HPDWUW1416DGP_rate_wire1(.PAD(rate_wire[1]),.C(net_rate_wire[1]),.IE(1'b1)),
	HPDWUW1416DGP_rate_wire2(.PAD(rate_wire[2]),.C(net_rate_wire[2]),.IE(1'b1)),
	HPDWUW1416DGP_rate_wire3(.PAD(rate_wire[3]),.C(net_rate_wire[3]),.IE(1'b1)),
	HPDWUW1416DGP_send_finish_flag000(.PAD(send_finish_flag00[0]),.C(net_send_finish_flag00[0]),.IE(1'b1)),
	HPDWUW1416DGP_send_finish_flag001(.PAD(send_finish_flag00[1]),.C(net_send_finish_flag00[1]),.IE(1'b1)),
	HPDWUW1416DGP_send_finish_flag010(.PAD(send_finish_flag01[0]),.C(net_send_finish_flag01[0]),.IE(1'b1)),
	HPDWUW1416DGP_send_finish_flag011(.PAD(send_finish_flag01[1]),.C(net_send_finish_flag01[1]),.IE(1'b1)),	
	HPDWUW1416DGP_send_finish_flag100(.PAD(send_finish_flag10[0]),.C(net_send_finish_flag10[0]),.IE(1'b1)),
	HPDWUW1416DGP_send_finish_flag101(.PAD(send_finish_flag10[1]),.C(net_send_finish_flag10[1]),.IE(1'b1)),
	HPDWUW1416DGP_send_finish_flag110(.PAD(send_finish_flag11[0]),.C(net_send_finish_flag11[0]),.IE(1'b1)),
	HPDWUW1416DGP_send_finish_flag111(.PAD(send_finish_flag11[1]),.C(net_send_finish_flag11[1]),.IE(1'b1)),
	HPDWUW1416DGP_receive_finish_flag000(.PAD(receive_finish_flag00[0]),.C(net_receive_finish_flag00[0]),.IE(1'b1)),
	HPDWUW1416DGP_receive_finish_flag001(.PAD(receive_finish_flag00[1]),.C(net_receive_finish_flag00[1]),.IE(1'b1)),
	HPDWUW1416DGP_receive_finish_flag010(.PAD(receive_finish_flag01[0]),.C(net_receive_finish_flag01[0]),.IE(1'b1)),
	HPDWUW1416DGP_receive_finish_flag011(.PAD(receive_finish_flag01[1]),.C(net_receive_finish_flag01[1]),.IE(1'b1)),	
	HPDWUW1416DGP_receive_finish_flag100(.PAD(receive_finish_flag10[0]),.C(net_receive_finish_flag10[0]),.IE(1'b1)),
	HPDWUW1416DGP_receive_finish_flag101(.PAD(receive_finish_flag10[1]),.C(net_receive_finish_flag10[1]),.IE(1'b1)),
	HPDWUW1416DGP_receive_finish_flag110(.PAD(receive_finish_flag11[0]),.C(net_receive_finish_flag11[0]),.IE(1'b1)),
	HPDWUW1416DGP_receive_finish_flag111(.PAD(receive_finish_flag11[1]),.C(net_receive_finish_flag11[1]),.IE(1'b1)),

	HPDWUW1416DGP_si_dst_seq000(.PAD(si_dst_seq00[0]),.C(net_si_dst_seq00[0]),.IE(1'b1)),
	HPDWUW1416DGP_si_dst_seq001(.PAD(si_dst_seq00[1]),.C(net_si_dst_seq00[1]),.IE(1'b1)),
	HPDWUW1416DGP_si_dst_seq002(.PAD(si_dst_seq00[2]),.C(net_si_dst_seq00[2]),.IE(1'b1)),
	HPDWUW1416DGP_si_dst_seq003(.PAD(si_dst_seq00[3]),.C(net_si_dst_seq00[3]),.IE(1'b1)),
	HPDWUW1416DGP_si_dst_seq004(.PAD(si_dst_seq00[4]),.C(net_si_dst_seq00[4]),.IE(1'b1)),
	HPDWUW1416DGP_si_dst_seq005(.PAD(si_dst_seq00[5]),.C(net_si_dst_seq00[5]),.IE(1'b1)),
	
	HPDWUW1416DGP_si_dst_seq010(.PAD(si_dst_seq01[0]),.C(net_si_dst_seq01[0]),.IE(1'b1)),
	HPDWUW1416DGP_si_dst_seq011(.PAD(si_dst_seq01[1]),.C(net_si_dst_seq01[1]),.IE(1'b1)),
	HPDWUW1416DGP_si_dst_seq012(.PAD(si_dst_seq01[2]),.C(net_si_dst_seq01[2]),.IE(1'b1)),
	HPDWUW1416DGP_si_dst_seq013(.PAD(si_dst_seq01[3]),.C(net_si_dst_seq01[3]),.IE(1'b1)),
	HPDWUW1416DGP_si_dst_seq014(.PAD(si_dst_seq01[4]),.C(net_si_dst_seq01[4]),.IE(1'b1)),
	HPDWUW1416DGP_si_dst_seq015(.PAD(si_dst_seq01[5]),.C(net_si_dst_seq01[5]),.IE(1'b1)),
	
	HPDWUW1416DGP_si_dst_seq100(.PAD(si_dst_seq10[0]),.C(net_si_dst_seq10[0]),.IE(1'b1)),
	HPDWUW1416DGP_si_dst_seq101(.PAD(si_dst_seq10[1]),.C(net_si_dst_seq10[1]),.IE(1'b1)),
	HPDWUW1416DGP_si_dst_seq102(.PAD(si_dst_seq10[2]),.C(net_si_dst_seq10[2]),.IE(1'b1)),
	HPDWUW1416DGP_si_dst_seq103(.PAD(si_dst_seq10[3]),.C(net_si_dst_seq10[3]),.IE(1'b1)),
	HPDWUW1416DGP_si_dst_seq104(.PAD(si_dst_seq10[4]),.C(net_si_dst_seq10[4]),.IE(1'b1)),
	HPDWUW1416DGP_si_dst_seq105(.PAD(si_dst_seq10[5]),.C(net_si_dst_seq10[5]),.IE(1'b1)),
	HPDWUW1416DGP_si_dst_seq110(.PAD(si_dst_seq11[0]),.C(net_si_dst_seq11[0]),.IE(1'b1)),
	HPDWUW1416DGP_si_dst_seq111(.PAD(si_dst_seq11[1]),.C(net_si_dst_seq11[1]),.IE(1'b1)),
	HPDWUW1416DGP_si_dst_seq112(.PAD(si_dst_seq11[2]),.C(net_si_dst_seq11[2]),.IE(1'b1)),
	HPDWUW1416DGP_si_dst_seq113(.PAD(si_dst_seq11[3]),.C(net_si_dst_seq11[3]),.IE(1'b1)),
	HPDWUW1416DGP_si_dst_seq114(.PAD(si_dst_seq11[4]),.C(net_si_dst_seq11[4]),.IE(1'b1)),
	HPDWUW1416DGP_si_dst_seq115(.PAD(si_dst_seq11[5]),.C(net_si_dst_seq11[5]),.IE(1'b1)),
	HPDWUW1416DGP_start_in_00(.PAD(start_in_00),.C(net_start_in_00),.IE(1'b1)),	
	HPDWUW1416DGP_start_in_01(.PAD(start_in_01),.C(net_start_in_01),.IE(1'b1)),	
	HPDWUW1416DGP_start_in_10(.PAD(start_in_10),.C(net_start_in_10),.IE(1'b1)),	
	HPDWUW1416DGP_start_in_11(.PAD(start_in_11),.C(net_start_in_11),.IE(1'b1));
	
	
HPDWUW1416DGP
	HPDWUW1416DGP_task_send_finish_1c_00(.PAD(task_send_finish_lc_00),.I(net_task_send_finish_lc_00),.OE(1'b1)),
	HPDWUW1416DGP_task_send_finish_1c_01(.PAD(task_send_finish_lc_01),.I(net_task_send_finish_lc_01),.OE(1'b1)),
	HPDWUW1416DGP_task_send_finish_1c_10(.PAD(task_send_finish_lc_10),.I(net_task_send_finish_lc_10),.OE(1'b1)),
	HPDWUW1416DGP_task_send_finish_1c_11(.PAD(task_send_finish_lc_11),.I(net_task_send_finish_lc_11),.OE(1'b1)),
	HPDWUW1416DGP_task_receive_finish_1c_00(.PAD(task_receive_finish_lc_00),.I(net_task_receive_finish_lc_00),.OE(1'b1)),
	HPDWUW1416DGP_task_receive_finish_1c_01(.PAD(task_receive_finish_lc_01),.I(net_task_receive_finish_lc_01),.OE(1'b1)),
	HPDWUW1416DGP_task_receive_finish_1c_10(.PAD(task_receive_finish_lc_10),.I(net_task_receive_finish_lc_10),.OE(1'b1)),
	HPDWUW1416DGP_task_receive_finish_1c_11(.PAD(task_receive_finish_lc_11),.I(net_task_receive_finish_lc_11),.OE(1'b1)),
	HPDWUW1416DGP_start_out_00(.PAD(start_out_00),.I(net_start_out_00),.OE(1'b1)),	
	HPDWUW1416DGP_start_out_01(.PAD(start_out_01),.I(net_start_out_01),.OE(1'b1)),	
	HPDWUW1416DGP_start_out_10(.PAD(start_out_10),.I(net_start_out_10),.OE(1'b1)),	
	HPDWUW1416DGP_start_out_11(.PAD(start_out_11),.I(net_start_out_11),.OE(1'b1));


noc_top  inst_noc_top(
.rst_n(net_rst_n),
.clk(net_clk),
.enable_wire(net_enable_wire),
.mode_wire(net_mode_wire),
.dbg_mode_wire(net_dbg_mode_wire),
.clk_global(net_clk_global),
.flush_wire(net_flush_wire),
.rate_wire(net_rate_wire),
.task_send_finish_lc_00(net_task_send_finish_lc_00),
.task_send_finish_lc_10(net_task_send_finish_lc_10),
.task_send_finish_lc_11(net_task_send_finish_lc_11),
.task_send_finish_lc_01(net_task_send_finish_lc_01),
.task_receive_finish_lc_00(net_task_receive_finish_lc_00),
.task_receive_finish_lc_01(net_task_receive_finish_lc_01),
.task_receive_finish_lc_10(net_task_receive_finish_lc_10),
.task_receive_finish_lc_11(net_task_receive_finish_lc_11),
.send_finish_flag00(net_send_finish_flag00),
.send_finish_flag01(net_send_finish_flag01),
.send_finish_flag10(net_send_finish_flag10),
.send_finish_flag11(net_send_finish_flag11),
.receive_finish_flag00(net_receive_finish_flag00),
.receive_finish_flag01(net_receive_finish_flag01),
.receive_finish_flag10(net_receive_finish_flag10),
.receive_finish_flag11(net_receive_finish_flag11),
.si_dst_seq00(net_si_dst_seq00),
.si_dst_seq01(net_si_dst_seq10),
.si_dst_seq10(net_si_dst_seq10),
.si_dst_seq11(net_si_dst_seq11),
.start_in_00(net_start_in_00),
.start_out_00(net_start_out_00),
.start_in_01(net_start_in_01),
.start_out_01(net_start_out_01),
.start_in_10(net_start_in_10),
.start_out_10(net_start_out_10),
.start_in_11(net_start_in_11),
.start_out_11(net_start_out_11)
);

endmodule