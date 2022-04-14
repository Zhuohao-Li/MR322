 //readme
//conect the whole noc 


//released:04/11/2022
//author:qilong han

module noc_top(
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

wire [39:0]data_p2r_00;
wire [39:0]data_p2r_01;
wire [39:0]data_p2r_10;
wire [39:0]data_p2r_11;
wire valid_p2r_inject_00;
wire valid_p2r_inject_01;
wire valid_p2r_inject_10;
wire valid_p2r_inject_11;

wire [39:0]data_r2p_00;
wire [39:0]data_r2p_01;
wire [39:0]data_r2p_10;
wire [39:0]data_r2p_11;
wire valid_r2p_00;
wire valid_r2p_01;
wire valid_r2p_10;
wire valid_r2p_11;
wire full_00;
wire full_01;
wire full_10;
wire full_11;

wire full_0001;
wire full_0010;
wire full_0100;
wire full_0111;
wire full_1000;
wire full_1011;
wire full_1101;
wire full_1110;


wire wr_en_0001;
wire wr_en_0010;
wire wr_en_0100;
wire wr_en_0111;
wire wr_en_1000;
wire wr_en_1011;
wire wr_en_1101;
wire wr_en_1110;
wire globe;
assign globe=1'b1;
wire [39:0]data_0001;
wire [39:0]data_0010;
wire [39:0]data_0100;
wire [39:0]data_0111;
wire [39:0]data_1000;
wire [39:0]data_1011;
wire [39:0]data_1101;
wire [39:0]data_1110;


wire [25:0]so_retrsreq_receive_num_01_00;
wire [25:0]so_retrsreq_receive_num_10_00;
wire [25:0]so_retrsreq_receive_num_11_00;
wire [25:0]so_retrsreq_receive_num_01_01;
wire [25:0]so_retrsreq_receive_num_10_01;
wire [25:0]so_retrsreq_receive_num_11_01;
wire [25:0]so_retrsreq_receive_num_01_10;
wire [25:0]so_retrsreq_receive_num_10_10;
wire [25:0]so_retrsreq_receive_num_11_10;
wire [25:0]so_retrsreq_receive_num_01_11;
wire [25:0]so_retrsreq_receive_num_10_11;
wire [25:0]so_retrsreq_receive_num_11_11;
wire [25:0]so_retrsreq_send_num_01_00;
wire [25:0]so_retrsreq_send_num_10_00;
wire [25:0]so_retrsreq_send_num_11_00;
wire [25:0]so_retrsreq_send_num_01_01;
wire [25:0]so_retrsreq_send_num_10_01;
wire [25:0]so_retrsreq_send_num_11_01;
wire [25:0]so_retrsreq_send_num_01_10;
wire [25:0]so_retrsreq_send_num_10_10;
wire [25:0]so_retrsreq_send_num_11_10;
wire [25:0]so_retrsreq_send_num_01_11;
wire [25:0]so_retrsreq_send_num_10_11;
wire [25:0]so_retrsreq_send_num_11_11;
wire [7:0]latency_min_x_00;
wire [7:0]latency_min_y_00;
wire [7:0]latency_min_diag_00;
wire [7:0]latency_max_x_00;
wire [7:0]latency_max_y_00;
wire [7:0]latency_max_diag_00;
wire [31:0]latency_sum_x_00;
wire [31:0]latency_sum_y_00;
wire [31:0]latency_sum_diag_00;
wire [7:0]latency_min_x_11;
wire [7:0]latency_min_y_11;
wire [7:0]latency_min_diag_11;
wire [7:0]latency_max_x_11;
wire [7:0]latency_max_y_11;
wire [7:0]latency_max_diag_11;
wire [31:0]latency_sum_x_11;
wire [31:0]latency_sum_y_11;
wire [31:0]latency_sum_diag_11;
wire [7:0]latency_min_x_01;
wire [7:0]latency_min_y_01;
wire [7:0]latency_min_diag_01;
wire [7:0]latency_max_x_01;
wire [7:0]latency_max_y_01;
wire [7:0]latency_max_diag_01;
wire [31:0]latency_sum_x_01;
wire [31:0]latency_sum_y_01;
wire [31:0]latency_sum_diag_01;
wire [7:0]latency_min_x_10;
wire [7:0]latency_min_y_10;
wire [7:0]latency_min_diag_10;
wire [7:0]latency_max_x_10;
wire [7:0]latency_max_y_10;
wire [7:0]latency_max_diag_10;
wire [31:0]latency_sum_x_10;
wire [31:0]latency_sum_y_10;
wire [31:0]latency_sum_diag_10;
PE_00  TG00(
    .clk(clk), .rst_n(rst_n), .enable_wire(enable_wire), .mode_wire(mode_wire), .dbg_mode_wire(dbg_mode_wire),
    .clk_global(clk_global), // use for time stamp
	.flush_wire(flush_wire), .rate_wire(rate_wire),
    .task_send_finish_lc(task_send_finish_lc_00), .task_receive_finish_lc(task_receive_finish_lc_00), .send_finish_flag(send_finish_flag00) ,
	.receive_finish_flag(receive_finish_flag00),
    .si_dst_seq(si_dst_seq00),
    .so_retrsreq_receive_num_01(so_retrsreq_receive_num_01_00), .so_retrsreq_receive_num_10(so_retrsreq_receive_num_10_00), .so_retrsreq_receive_num_11(so_retrsreq_receive_num_11_00),
    .so_retrsreq_send_num_01(so_retrsreq_send_num_01_00), .so_retrsreq_send_num_10(so_retrsreq_send_num_10_00), .so_retrsreq_send_num_11(so_retrsreq_send_num_11_00),
    .data_p2r(data_p2r_00), .valid_p2r_inject(valid_p2r_inject_00),
    .data_r2p(data_r2p_00), .valid_r2p(valid_r2p_00), .full(full_00), .start_in(start_in_00), .start_out(start_out_00),
	.latency_min_x(latency_min_x_00), .latency_min_y(latency_min_y_00), .latency_min_diag(latency_min_diag_00),
	.latency_max_x(latency_max_x_00), .latency_max_y(latency_max_y_00), .latency_max_diag(latency_max_diag_00),
	.latency_sum_x(latency_sum_x_00), .latency_sum_y(latency_sum_y_00), .latency_sum_diag(latency_sum_diag_00)
);

PE_01  TG01(
    .clk(clk), .rst_n(rst_n), .enable_wire(enable_wire), .mode_wire(mode_wire), .dbg_mode_wire(dbg_mode_wire),
    .clk_global(clk_global), // use for time stamp
	.flush_wire(flush_wire), .rate_wire(rate_wire),
    .task_send_finish_lc(task_send_finish_lc_01), .task_receive_finish_lc(task_receive_finish_lc_01), .send_finish_flag(send_finish_flag01) ,
	.receive_finish_flag(receive_finish_flag01),
    .si_dst_seq(si_dst_seq01),
    .so_retrsreq_receive_num_01(so_retrsreq_receive_num_01_01), .so_retrsreq_receive_num_10(so_retrsreq_receive_num_10_01), .so_retrsreq_receive_num_11(so_retrsreq_receive_num_11_01),
    .so_retrsreq_send_num_01(so_retrsreq_send_num_01_01), .so_retrsreq_send_num_10(so_retrsreq_send_num_10_01), .so_retrsreq_send_num_11(so_retrsreq_send_num_11_01),
    .data_p2r(data_p2r_01), .valid_p2r_inject(valid_p2r_inject_01),
    .data_r2p(data_r2p_01), .valid_r2p(valid_r2p_01), .full(full_01), .start_in(start_in_01), .start_out(start_out_01),
	.latency_min_x(latency_min_x_01), .latency_min_y(latency_min_y_01), .latency_min_diag(latency_min_diag_01),
	.latency_max_x(latency_max_x_01), .latency_max_y(latency_max_y_01), .latency_max_diag(latency_max_diag_01),
	.latency_sum_x(latency_sum_x_01), .latency_sum_y(latency_sum_y_01), .latency_sum_diag(latency_sum_diag_01)
);
PE_11  TG11(
    .clk(clk), .rst_n(rst_n), .enable_wire(enable_wire), .mode_wire(mode_wire), .dbg_mode_wire(dbg_mode_wire),
    .clk_global(clk_global), // use for time stamp
	.flush_wire(flush_wire), .rate_wire(rate_wire),
    .task_send_finish_lc(task_send_finish_lc_11), .task_receive_finish_lc(task_receive_finish_lc_11), .send_finish_flag(send_finish_flag11) ,
	.receive_finish_flag(receive_finish_flag11),
    .si_dst_seq(si_dst_seq11),
    .so_retrsreq_receive_num_01(so_retrsreq_receive_num_01_11), .so_retrsreq_receive_num_10(so_retrsreq_receive_num_10_11), .so_retrsreq_receive_num_11(so_retrsreq_receive_num_11_11),
    .so_retrsreq_send_num_01(so_retrsreq_send_num_01_11), .so_retrsreq_send_num_10(so_retrsreq_send_num_10_11), .so_retrsreq_send_num_11(so_retrsreq_send_num_11_11),
    .data_p2r(data_p2r_11), .valid_p2r_inject(valid_p2r_inject_11),
    .data_r2p(data_r2p_11), .valid_r2p(valid_r2p_11), .full(full_11), .start_in(start_in_11), .start_out(start_out_11),
	.latency_min_x(latency_min_x_11), .latency_min_y(latency_min_y_11), .latency_min_diag(latency_min_diag_11),
	.latency_max_x(latency_max_x_11), .latency_max_y(latency_max_y_11), .latency_max_diag(latency_max_diag_11),
	.latency_sum_x(latency_sum_x_11), .latency_sum_y(latency_sum_y_11), .latency_sum_diag(latency_sum_diag_11)
);
PE_10  TG10(
    .clk(clk), .rst_n(rst_n), .enable_wire(enable_wire), .mode_wire(mode_wire), .dbg_mode_wire(dbg_mode_wire),
    .clk_global(clk_global), // use for time stamp
	.flush_wire(flush_wire), .rate_wire(rate_wire),
    .task_send_finish_lc(task_send_finish_lc_10), .task_receive_finish_lc(task_receive_finish_lc_10), .send_finish_flag(send_finish_flag10) ,
	.receive_finish_flag(receive_finish_flag10),
    .si_dst_seq(si_dst_seq10),
    .so_retrsreq_receive_num_01(so_retrsreq_receive_num_01_10), .so_retrsreq_receive_num_10(so_retrsreq_receive_num_10_10), .so_retrsreq_receive_num_11(so_retrsreq_receive_num_11_10),
    .so_retrsreq_send_num_01(so_retrsreq_send_num_01_10), .so_retrsreq_send_num_10(so_retrsreq_send_num_10_10), .so_retrsreq_send_num_11(so_retrsreq_send_num_11_10),
    .data_p2r(data_p2r_10), .valid_p2r_inject(valid_p2r_inject_10),
    .data_r2p(data_r2p_10), .valid_r2p(valid_r2p_10), .full(full_10), .start_in(start_in_10), .start_out(start_out_10),
	.latency_min_x(latency_min_x_10), .latency_min_y(latency_min_y_10), .latency_min_diag(latency_min_diag_10),
	.latency_max_x(latency_max_x_10), .latency_max_y(latency_max_y_10), .latency_max_diag(latency_max_diag_10),
	.latency_sum_x(latency_sum_x_10), .latency_sum_y(latency_sum_y_10), .latency_sum_diag(latency_sum_diag_10)
);


router00 router_00
(
.rst_n(rst_n),
.wr_en_x(wr_en_0100),
.wr_en_y(wr_en_1000),
.wr_en_local(valid_p2r_inject_00),
.wdata_x(data_0100),
.wdata_y(data_1000),
.wdata_local(data_p2r_00),
.wclk_x(clk),//
.wclk_y(clk),//
.wclk_local(clk),//
.rclk(clk),//
.clk(clk),
.next_full_x(full_0100),
.next_full_y(full_1000),
.next_full_local(globe),
.full_x(full_0001),
.full_y(full_0010),
.full_local(full_00),
.data_to_x(data_0001),
.data_to_y(data_0010),
.data_to_local(data_r2p_00),
.wr_next_x_en(wr_en_0001),
.wr_next_y_en(wr_en_0010),
.wr_next_local_en(valid_r2p_00)
);
router01 router_01
(
.rst_n(rst_n),
.wr_en_x(wr_en_0001),
.wr_en_y(wr_en_1101),
.wr_en_local(valid_p2r_inject_01),
.wdata_x(data_0001),
.wdata_y(data_1101),
.wdata_local(data_p2r_01),
.wclk_x(clk),//
.wclk_y(clk),//
.wclk_local(clk),//
.rclk(clk),//
.clk(clk),
.next_full_x(full_0001),
.next_full_y(full_1101),
.next_full_local(globe),
.full_x(full_0100),
.full_y(full_0111),
.full_local(full_01),
.data_to_x(data_0100),
.data_to_y(data_0111),
.data_to_local(data_r2p_01),
.wr_next_x_en(wr_en_0100),
.wr_next_y_en(wr_en_0111),
.wr_next_local_en(valid_r2p_01)
);
router11 router_11
(
.rst_n(rst_n),
.wr_en_x(wr_en_1011),
.wr_en_y(wr_en_0111),
.wr_en_local(valid_p2r_inject_11),
.wdata_x(data_1011),
.wdata_y(data_0111),
.wdata_local(data_p2r_11),
.wclk_x(clk),//
.wclk_y(clk),//
.wclk_local(clk),//
.rclk(clk),//
.clk(clk),
.next_full_x(full_1011),
.next_full_y(full_0111),
.next_full_local(globe),
.full_x(full_1110),
.full_y(full_1101),
.full_local(full_11),
.data_to_x(data_1110),
.data_to_y(data_1101),
.data_to_local(data_r2p_11),
.wr_next_x_en(wr_en_1110),
.wr_next_y_en(wr_en_1101),
.wr_next_local_en(valid_r2p_11)
);
router10 router_10
(
.rst_n(rst_n),
.wr_en_x(wr_en_1110),
.wr_en_y(wr_en_0010),
.wr_en_local(valid_p2r_inject_10),
.wdata_x(data_1110),
.wdata_y(data_0010),
.wdata_local(data_p2r_10),
.wclk_x(clk),//
.wclk_y(clk),//
.wclk_local(clk),//
.rclk(clk),//
.clk(clk),
.next_full_x(full_1110),
.next_full_y(full_0010),
.next_full_local(globe),
.full_x(full_1011),
.full_y(full_1000),
.full_local(full_10),
.data_to_x(data_1011),
.data_to_y(data_1000),
.data_to_local(data_r2p_10),
.wr_next_x_en(wr_en_1011),
.wr_next_y_en(wr_en_1000),
.wr_next_local_en(valid_r2p_10)
);

endmodule