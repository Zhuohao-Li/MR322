// readme:
// This code implement FIFO

// parameter:
// wclk(write clock)
// rclk(read clock)
// rst_n(negatively effecitve)
// wr_en (write enable)
// wdata (write data)
// rd_en (read_enable)

// full
// empty
// rdata
// control_localrdata_valid

// released:3/15/2022
// author: qilong han

module fifo_asy #(parameter wa = 3,
                  parameter wd = 4)
                 (input rst_n,
                  input wclk,
                  input wr_en,
                  input [wd-1:0] wdata,
                  output full,
                  input rd_en,
                  input rclk,
                  output reg [wd-1:0] rdata,
                  output reg rdata_valid,
                  output empty);
    //syn [wa-1:0] raddr &  [wa-1:0] raddr
    reg [wa:0] raddr;
    reg [wa:0] waddr;
    
    //gray
    wire [wa:0] gray_waddr = (waddr>>1)^waddr;
    wire [wa:0] gray_raddr = (raddr>>1)^raddr;
    
    // full rclk->wclk
    reg [wa:0] gray_raddr_r1,gray_raddr_r2;
    always @(posedge wclk) begin
        if (!rst_n)begin
            gray_raddr_r1 <= {wa{1'b0}};
            gray_raddr_r2 <= {wa{1'b0}};
            end else begin
            gray_raddr_r1 <= gray_raddr;
            gray_raddr_r2 <= gray_raddr_r1;
        end
    end
    
    wire full_con1 = &(~(gray_waddr[wa-2:0]^gray_raddr_r2[wa-2:0]));
    wire full_con2 = &(~(gray_waddr[wa:wa-1]^gray_raddr_r2[wa:wa-1]));
    assign full    = full_con1&~full_con2;
    
    // empty wclk->rclk
    reg [wa:0] gray_waddr_r1,gray_waddr_r2;
    always @(posedge rclk) begin
        if (!rst_n)begin
            gray_waddr_r1 <= {wa{1'b0}};
            gray_waddr_r2 <= {wa{1'b0}};
            end else begin
            gray_waddr_r1 <= gray_waddr;
            gray_waddr_r2 <= gray_waddr_r1;
        end
    end
    wire empty_con1 = &(~(gray_waddr_r2[wa-2:0]^gray_raddr[wa-2:0]));
    wire empty_con2 = &(~(gray_waddr_r2[wa:wa-1]^gray_raddr[wa:wa-1]));
    assign empty    = empty_con1&empty_con2;
    
    parameter deep = (1<<wa)-1;
    reg [wd-1:0] fifo_mem[deep:0] ;
    
    always @(posedge wclk) begin
        if (!rst_n)
            waddr <= {wa{1'b0}};
        else if (wr_en&&!full) begin
            fifo_mem[waddr[wa-1:0]] <= wdata;
            waddr                   <= waddr + 1'b1;
        end
            end
            
            // assign  rdata = (!empty&&rd_en)?fifo_mem[raddr[wa-1:0]]:{wd{1'b0}};
            
            always @(posedge rclk) begin
                if (!rst_n)begin
                    raddr       <= {wa{1'b0}};
                    rdata       <= {wd{1'b0}};
                    rdata_valid <= 1'b0;
                    end else if (rd_en&&!empty) begin
                    raddr       <= raddr + 1'b1;
                    rdata       <= fifo_mem[raddr[wa-1:0]];
                    rdata_valid <= 1'b1;
                    end else begin
                    rdata       <= {wd{1'b0}};
                    rdata_valid <= 1'b0;
                end
            end
            endmodule
