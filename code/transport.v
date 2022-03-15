// readme:
// This code transfer the output of router_algorithm to the control signal of data_selector41


// eg:


// parameter:
// clk(clock)
// rst_n(negatively effecitve)
// router_algorithm_out_x (the last output of router_algorithm x)
// router_algorithm_out_y (the last output of router_algorithm y)
// router_algorithm_out_local (the last output of router_algorithm local)
// control_x (control x)
// control_y (control y)
// control_local (control local)

// released:3/4/2022
// author: zhuohao li


module transport (clk,
                  rst_n,
                  router_algorithm_out_x,
                  router_algorithm_out_y,
                  router_algorithm_out_local,
                  control_x,
                  control_y,
                  control_local);
    
    input clk, rst_n;
    input [1:0] router_algorithm_out_x;
    input [1:0] router_algorithm_out_y;
    input [1:0] router_algorithm_out_local;
    output [1:0] control_x;
    output [1:0] control_y;
    output [1:0] control_local;
    reg [2:0] issue
    // input [39:0] din_x;
    // input [39:0] din_y;
    // input [39:0] din_local;
    
    always @(posedge clk or posedge rst_n) begin
        if (!rst_n)
        begin
            issue     <= 0;  // neo problem
            control_x <= 0;
        end
            case (router_algorithm_out_x)
                2'b00: issue[0]          <= 1;  // x_data has problem
                2'b01: control_x         <= 2'b01;
                2'b10: control_y         <= 2'b01;
                2'b11: control_local     <= 2'b01;
                default: 2'b00: issue[0] <= 1;
            endcase
    end
    
    always @(posedge clk or posedge rst_n) begin
        if (!rst_n) begin
            issue     <= 0;
            control_y <= 0;
        end
            case (router_algorithm_out_y)
                2'b00: issue[1]      <= 0;  // // y_data has problem
                2'b01: control_x     <= 2'b10;
                2'b10: control_y     <= 2'b10;
                2'b11: control_local <= 2'b10;
                default: issue[1]    <= 0;
            endcase
    end
    
    always @(posedge clk or posedge rst_n) begin
        if (!rst_n) begin
            control_local <= 0;
            issue         <= 0;
        end
            case (router_algorithm_out_local)
                2'b00: issue[2]      <= 0; // local_data has problem
                2'b01: control_x     <= 2'b11;
                2'b10: control_y     <= 2'b11;
                2'b11: control_local <= 2'b11;
                default: issue[2]    <= 0;
            endcase
    end
    
endmodule
