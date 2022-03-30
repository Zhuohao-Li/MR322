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


// new feature:
// I verfy the logic. The module must take at least 2 cycles to finished!!!!!
// In the first cycle, it must be reset and all control_signal is unenabled.
// In the second cycle, the module can be normally executed.

// released:3/30/2022
// author: zhuohao li


module transport (clk,
                  rst_n,
                  router_algorithm_out_x,
                  router_algorithm_out_y,
                  router_algorithm_out_local,
                  control_x,
                  control_y,
                  control_local,
                  fail,
                  control_clk);
    
    input clk, rst_n;
    input [1:0] router_algorithm_out_x;
    input [1:0] router_algorithm_out_y;
    input [1:0] router_algorithm_out_local;
    input control_clk;
    output reg[1:0]  control_x;
    output reg[1:0]  control_y;
    output reg[1:0]  control_local;
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
        
        // No reset
        else begin
        if (!control_clk) // when control_clk is enabled
        begin
            if (fail == 3'b000) // no valid fail signals
            begin
                // transfer from router outcome to control signals at mux later
                
                case (router_algorithm_out_x)
                    2'b00: control_x     <= 2'b00; // if there's something wrong, control signal will select an invalid one
                    2'b01: control_x     <= 2'b01; // if data_x is about to go 01 direction(x), x fifo will select 01(data x)
                    2'b10: control_y     <= 2'b01; // if data_x is about to go 10 direction(y), y fifo will select 01(data x)
                    2'b11: control_local <= 2'b01; // if data_x is about to go 11 direction(local), local fifo will select 01(data x)
                    default:   control_x <= 2'b00; // other situation will set to be error
                endcase
                // the others (y, local) is like above
                case (router_algorithm_out_y)
                    2'b00: control_y     <= 2'b00;
                    2'b01: control_x     <= 2'b10;
                    2'b10: control_y     <= 2'b10;
                    2'b11: control_local <= 2'b10;
                    default:   control_y <= 2'b00;
                endcase
                
                case (router_algorithm_out_local)
                    2'b00: control_local     <= 2'b00;
                    2'b01: control_x         <= 2'b11;
                    2'b10: control_y         <= 2'b11;
                    2'b11: control_local     <= 2'b11;
                    default:   control_local <= 2'b00;
                endcase
            end
            
            // judgment of the fail signal
            // fail is 3-bit and only the 3 situations are valid
            // otherwise, set all ports invalid
            else if (fail == 3'b001)
            begin // x is wrong
            case (router_algorithm_out_y)
                2'b00: control_y     <= 2'b00;
                2'b01: control_x     <= 2'b10;
                2'b10: control_y     <= 2'b10;
                2'b11: control_local <= 2'b10;
                default:   control_y <= 2'b00;
            endcase
            
            case (router_algorithm_out_local)
                2'b00: control_local     <= 2'b00;
                2'b01: control_x         <= 2'b11;
                2'b10: control_y         <= 2'b11;
                2'b11: control_local     <= 2'b11;
                default:   control_local <= 2'b00;
            endcase
        end
        
        else if (fail == 3'b010) begin
        case (router_algorithm_out_x)
            2'b00: control_x     <= 2'b00;
            2'b01: control_x     <= 2'b01;
            2'b10: control_y     <= 2'b01;
            2'b11: control_local <= 2'b01;
            default:   control_x <= 2'b00;
        endcase
        
        case (router_algorithm_out_local)
            2'b00: control_local     <= 2'b00;
            2'b01: control_x         <= 2'b11;
            2'b10: control_y         <= 2'b11;
            2'b11: control_local     <= 2'b11;
            default:   control_local <= 2'b00;
        endcase
    end
    
    else if (fail == 3'b100) begin
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
    end
    
    end
    
    else begin // if control_clk is disabled, a bubble occurs here
    control_x     <= 2'b00;
    control_y     <= 2'b00;
    control_local <= 2'b00;
    end
    
    end
    end
    
endmodule
