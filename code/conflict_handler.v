module conflict_handler(
    clk,
    rst_n,
    fail,
    router_algorithm_out_x,
    router_algorithm_out_y,
    router_algorithm_out_local,
    port
    )
    input clk;
    input rst_n;
    input fail;
    input [1:0] router_algorithm_out_x;
    input [1:0] router_algorithm_out_y;
    input [1:0] router_algorithm_out_local;
    reg output [1:0] port;
    
    always @(posedge clk or posedge rst_n)
    begin
        if (! rst_n) begin
            port <= 2'b00;
        end
        case (fail) begin
        3'b001: port <= router_algorithm_out_x;
        3'b010: port <= router_algorithm_out_y;
        3'b100: port <= router_algorithm_out_local;
    end
    end
