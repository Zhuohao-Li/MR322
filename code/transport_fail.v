// readme:
// This transport data when judgement result is FAIL

// parameter:
// clk(clock)
// rst_n((negatively effecitve))
// router_algorithm_out_x(negatively effecitve)
// router_algorithm_out_y
// router_algorithm_out_local

// control_x
// control_y
// control_local


// released:3/15/2022
// author: hongyang gu

module transport_fail (input clk,
                       rst_n,
                       input [1:0] router_algorithm_out_x,
                       router_algorithm_out_y,
                       router_algorithm_out_local,
                       output reg [1:0] control_x,
                       control_y,
                       control_local);
    
    //indicate weather the port already have been allocated
    wire x_dataIn_flag, y_dataIn_flag, local_dataIn_flag;
    dataInFlag PortXDataInFlag(2'b01, router_algorithm_out_x, router_algorithm_out_y, router_algorithm_out_local, x_dataIn_flag);
    dataInFlag PortYDataInFlag(2'b10, router_algorithm_out_x, router_algorithm_out_y, router_algorithm_out_local, y_dataIn_flag);
    dataInFlag PortLocalDataInFlag(2'b11, router_algorithm_out_x, router_algorithm_out_y, router_algorithm_out_local, local_dataIn_flag);
    
    always @(posedge clk or posedge rst_n) begin
        if (!rst_n) begin
            // reset
            control_x <= 2'b00;
        end
        else if (x_dataIn_flag) begin
            control_x <= 2'b00;
        end
            end
            
            always @(posedge clk or posedge rst_n) begin
                if (!rst_n) begin
                    // reset
                    control_y <= 2'b00;
                end
                else if (y_dataIn_flag) begin
                    control_y <= 2'b00;
                end
                    end
                    
                    always @(posedge clk or posedge rst_n) begin
                        if (!rst_n) begin
                            // reset
                            control_local <= 2'b00;
                        end
                        else if (local_dataIn_flag) begin
                            control_local <= 2'b00;
                        end
                            end
                            
                            endmodule
                            
                            module dataInFlag(
                                input port_location,
                                input [1:0] router_algorithm_out_x, router_algorithm_out_y, router_algorithm_out_local,
                                output dataIn_flag);
                                
                                wire flag_x, flag_y, flag_local;
                                assign flag_x     = router_algorithm_out_x ~^ port_location;
                                assign flag_y     = router_algorithm_out_y ~^ port_location;
                                assign flag_local = router_algorithm_out_local ~^ port_location;
                                
                                assign dataIn_flag = (flag_x[0] && flag_x[1]) || (flag_y[0] && flag_y[1]) || (flag_local[0] && flag_local[1]);
                                
                            endmodule
