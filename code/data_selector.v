// readme:
// this code is select a specific item from 3 input (x, y, local)
// control signal is processed by the process module

// parameters:
// clk(clock)
// rst_n(negtively effective)
// control_x(x path control wire)
// control_y(y path control wire)
// control_local(local path control wire)
// din_x(40-bit data from fifo channel x)
// din_y(40-bit data from fifo channel y)
// din_local(40-bit data from fifo channel local)
// out_x(40-bit data from x path mux)
// out_y(40-bit data from y path mux)
// out_local(40-bit data from local path mux)


// released 3/4/2022




module data_selector41(clk,
                       rst_n,
                       control_x,
                       control_y,
                       control_local,
                       din_x,
                       din_y,
                       din_local,
                       out_x,
                       out_y,
                       out_local);
    input [1:0] control_x; // this is control signal\
    input [1:0] control_y;
    input [1:0] control_local;
    input [39:0] din_x;
    input [39:0] din_y;
    input [39:0] din_local;
    output reg [39:0] out_x;
    output reg [39:0] out_y;
    output reg [39:0] out_local;
    
    
    always @(posedge clk or negedge rst_n)
    begin
        if (!rst_n) out_x <= 0; // output is all zeros, which means it's false
        case ({control_x[1],control_x[0]})
            2'b00: out_x   <= 0;
            2'b01: out_x   <= data_x;
            2'b10: out_x   <= data_y;
            2'b11: out_x   <= data_local;
            default: out_x <= 0;
        endcase
    end
    
    always @(posedge clk or negedge rst_n)
    begin
        if (!rst_n) out_y <= 0; // output is all zeros, which means it's false
        case ({control_y[1],control_y[0]})
            2'b00: out_y   <= 0;
            2'b01: out_y   <= data_x;
            2'b10: out_y   <= data_y;
            2'b11: out_y   <= data_local;
            default: out_y <= 0;
        endcase
    end
    
    always @(posedge clk or negedge rst_n)
    begin
        if (!rst_n) out_local <= 0; // output is all zeros, which means it's false
        case ({control_local[1],control_local[0]})
            2'b00: out_local   <= 0;
            2'b01: out_local   <= data_x;
            2'b10: out_local   <= data_y;
            2'b11: out_local   <= data_local;
            default: out_local <= 0;
        endcase
    end
    //若括号里均为0，则out必为0，完全可以不执行always语句
    // always @(control or in)
    // begin
    //     case({control[1],control[0]})
    //         2'b00: out   <= in[0];
    //         2'b01: out   <= in[1];
    //         2'b10: out   <= in[2];
    //         2'b11: out   <= in[3];
    //         default: out <= 1'bx;
    //     endcase
    // end
endmodule
