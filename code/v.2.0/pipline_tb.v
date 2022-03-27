`timescale 1ns / 1ps
 
module pipline_tb(); //通常起名格式为 tb_被测试模块名

   reg rst_n ;
   reg clk;
   reg rclk;
   reg wclk;
   reg wr_en_x;
   reg wr_en_y;
   reg wr_en_local;
   reg[39:0] wdata_x;
   reg [39:0]wdata_y;
   reg [39:0]wdata_local;
   reg next_full_x;
   reg next_full_y;
   reg next_full_local;
   wire full_x;
   wire full_local;
   wire full_y;
   wire [39:0]data_to_x;
   wire [39:0]data_to_y;
	wire [39:0]data_to_local;
	wire wr_next_local_en;
	wire wr_next_x_en;
	wire wr_next_y_en;
	wire rd_x_en;
  wire [2:0]FAILXYL;

initial
begin
  $fsdbDumpfile("filename_you_want.fsdb");
  $fsdbDumpvars;
end

//信号初始化
initial begin
/*
	sys_clk = 1'b0; 
	sys_rst_n = 1'b0;
	#200  //延时200ns
	sys_rst_n = 1'b1;
	*/
	wclk=1'b0;
	rclk=1'b0;
	rst_n=1'b0;
	next_full_local=1'b0;
	next_full_x=1'b0;
	next_full_y=1'b0;
	#100
	rst_n=1'b1;
	#20
	rst_n=1'b0;
end

always #10 wclk=~wclk; //每10ns，clk进行翻转
always #10 rclk=~rclk; //每10ns，clk进行翻转

always @(posedge wclk) begin
        if(rst_n)begin
            wr_en_x <= 1'b0;
            wdata_x <={4'b0100,36'b0};
        end else begin
            if(!full_x)begin
                wr_en_x <=1'b1;
                wdata_x <= wdata_x + 40'h1;
            end
        end
    end
always @(posedge wclk) begin
        if(rst_n)begin
            wr_en_y <= 1'b0;
            wdata_y <= {4'b1001,36'b0};
        end else begin
            if(!full_y)begin
                wr_en_y <= 1'b1;
                wdata_y <= wdata_y + 40'h2;
            end
        end
    end

always @(posedge wclk) begin
        if(rst_n)begin
            wr_en_local <= 1'b0;
            wdata_local <= {4'b0010,36'b0};
        end else begin
            if(!full_local)begin
                wr_en_local <= 1'b1;
                wdata_local <= wdata_local + 40'h3;
            end
        end
    end



//例化待测模块
 pipline#(
     .wd(40)) pipline_a(
.rst_n(rst_n),
.wr_en_x(wr_en_x),
.wr_en_y(wr_en_y),
.wr_en_local(wr_en_local),
.wdata_x(wdata_x),
.wdata_y(wdata_y),
.wdata_local(wdata_local),
.wclk(wclk),//
.rclk(rclk),//
.clk(rclk),
.next_full_x(next_full_x),
.next_full_y(next_full_y),
.next_full_local(next_full_local),
.full_x(full_x),
.full_y(full_y),
.full_local(full_local),
.data_to_x(data_to_x),
.data_to_y(data_to_y),
.data_to_local(data_to_local),
.wr_next_x_en(wr_next_x_en),
.wr_next_y_en(wr_next_y_en),
.wr_next_local_en(wr_next_local_en)

);

endmodule

