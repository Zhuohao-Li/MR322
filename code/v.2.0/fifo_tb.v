`timescale 1ns / 1ps
module tb();
reg wclk;
reg rclk;
reg rst_n;
reg wr_en,rd_en;
wire empty,full;
wire rdata_valid;
reg [3:0] wdata;
wire [3:0] rdata;
fifo_asy #(
    .wa(3),
    .wd(4)
) fifo_syn_inst(
    .rst_n (rst_n),
    .wclk (wclk),
    .wr_en(wr_en),
    .wdata(wdata),
    .full(full),
    .rd_en(rd_en),
    .rclk (rclk),
    .rdata(rdata),
    .rdata_valid(rdata_valid),
    .empty(empty)
);

//always #10 wclk=~wclk;
//always #10 rclk=~rclk;

// READ FASTER THAN WRITE
always #20 wclk=~wclk;
always #10 rclk=~rclk;

//WRITE FASTER THAN READ
//always #10 wclk=~wclk;
//always #20 rclk=~rclk;

initial begin
 wclk = 0;
 rclk = 0;
 rd_en = 0;
 rst_n = 0;
 #100 
 rst_n = 1;
end
    always @(posedge wclk) begin
        if(!rst_n)begin
            wr_en <= 1'b0;
            wdata <= 1'b0;
        end else begin
            if(!full)begin
                wr_en <= 1'b1;
                wdata <= wdata + 1'b1;
            end
        end
    end

     always @(posedge rclk) begin
         if(!rst_n)begin
            rd_en <= 1'b0;
         end else begin
            rd_en <= 1'b1;
         end
     end
endmodule

