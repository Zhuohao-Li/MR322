// readme:
// This code transfer the output of router_algorithm to the control signal of data_selector41

// parameter:
// clk(clock)
// rst_n(negatively effecitve)
// router_algorithm_out_x (the last output of router_algorithm x, it shows where data x should be transferred to)
// router_algorithm_out_y (the last output of router_algorithm y)
// router_algorithm_out_local (the last output of router_algorithm local)
// control_x (path x decide which data should be valid)
// control_y (control y)
// control_local (control local)

// released:3/24/2022
// author: zhuohao li


module transport (clk,
                  rst_n,
                  router_algorithm_out_x,
                  router_algorithm_out_y,
                  router_algorithm_out_local,
                  control_x,
                  control_y,
                  control_local， fail,
                  control_clk);
    
    input clk, rst_n;
    input [1:0] router_algorithm_out_x;
    input [1:0] router_algorithm_out_y;
    input [1:0] router_algorithm_out_local;
    input control_clk;
    output [1:0] control_x;
    output [1:0] control_y;
    output [1:0] control_local;
    input [2:0]fail;
    // input [39:0] din_x;
    // input [39:0] din_y;
    // input [39:0] din_local;
    
    always @(posedge clk or posedge rst_n) begin
        // reset
        if (!rst_n) begin
            control_x     <= 2'b00;
            control_y     <= 2'b00;
            control_local <= 2'b00;
        end
        
        // normally go weill
        else
        begin
        if (!control_clk) // control_clk is enabled
        // if control_clk is disabled, a bubble occurs here
        begin
            case (fail)
                3'b001: control_x     <= 2'b00;
                3'b010: control_y     <= 2'b00;
                3'b100: control_local <= 2'b00;
                default: begin
                    control_x     <= 2'b00;
                    control_y     <= 2'b00;
                    control_local <= 2'b00;
                end
            endcase
            // judgment of the fail signal
            // fail is 3-bit and only the 3 situations are valid
            // otherwise, set all ports invalid
            
            
            // transfer from router outcome to control signals at mux later
            begin
            case (router_algorithm_out_x)
                2'b00: control_x     <= 2'b00;
                2'b01: control_x     <= 2'b01;
                2'b10: control_y     <= 2'b01;
                2'b11: control_local <= 2'b01;
                default:   control_x <= 2'b00;
            endcase
            
            case (router_algorithm_out_y)
                2'b00: control_y     <= 2'b00;
                2'b01: control_x     <= 2'b10;
                2'b10: control_y     <= 2'b10;
                2'b11: control_local <= 2'b10;
                default:   control_y <= 2'b00;
            endcase
            
            case (router_algorithm_out_local)
                2'b00: lcoal             <= 2'b00;
                2'b01: control_x         <= 2'b11;
                2'b10: control_y         <= 2'b11;
                2'b11: control_local     <= 2'b11;
                default:   control_local <= 2'b00;
            endcase
        end
    end
    end
    end
    
endmodule
