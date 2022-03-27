// readme:
// This code restore the fail data and transfer port and finish that work in the conflict_handler cycle/

// parameter:
// clk(clock)
// rst_n(negatively effecitve)
// [2:0] fail (from judge, 'fail' shows which data is invaid)
// router_algorithm_out_x (the last output of router_algorithm x, it shows where data x should be transferred to)
// router_algorithm_out_y (the last output of router_algorithm y)
// router_algorithm_out_local (the last output of router_algorithm local)
// din_x (data from fifo x layer)
// din_y
// din_local
// dout (output data)
// port(output direction next time)

// released:3/16/2022
// author: zhuohao li


module conflict_handler(
    clk,
    rst_n,
    fail,
    router_algorithm_out_x,
    router_algorithm_out_y,
    router_algorithm_out_local,
    din_x,
    din_y,
    din_local,
    dout,
    port
    )
    input clk;
    input rst_n;
    input fail;
    input [1:0] router_algorithm_out_x;
    input [1:0] router_algorithm_out_y;
    input [1:0] router_algorithm_out_local;
    input [39:0] din_x;
    input [39:0] din_y;
    input [39:0] din_local;
    output reg [39:0] dout;
    output reg [1:0] port;
    
    always @(posedge clk or posedge rst_n)
    begin
        if (! rst_n) begin
            port <= 2'b00; //reset
        end
            case (fail)  //'fail' controls
                3'b001: begin
                    port <= router_algorithm_out_x;
                    dout <= din_x;
                end
                3'b010: begin
                    port <= router_algorithm_out_y;
                    dout <= din_y;
                end
                3'b100: begin
                    port <= router_algorithm_out_local;
                    dout <= din_local;
                end
            endcase
    end
