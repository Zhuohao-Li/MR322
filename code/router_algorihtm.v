// readme:
// This code is implement a router. It receives a packet of data of 40-bit and caculate which direction should it transfer to.
// Input is a 40-bit data packet
// Output is the direction (X, Y, Local), X---01, Y---10, Local---11

// parameters:
// clk(clock)
// rst_n(negtively effective)
// din_x(40-bit data from fifo channel x)
// din_y(40-bit data from fifo channel y)
// din_local(40-bit data from fifo channel local)
// current_location(the current router's address)
// dout_x(40-bit data from x path mux)
// dout_y(40-bit data from y path mux)
// dout_local(40-bit data from local path mux)

// released: 3/4/2022
// author: zhuohaoli

module Router_algorithm(clk,
                        rst_n,
                        din_x,
                        din_y,
                        din_local,
                        current_location,
                        dout_x,
                        dout_y,
                        dout_local);
    
    input wire clk;
    input wire rst_n;
    input wire  [39:0] din_x; // this is input data package
    input wire  [39:0] din_y;
    input wire  [39:0] din_local;
    input wire [1:0] current_location; // this is the signal of the router
    output reg [1:0] dout_x; // this is output
    output reg [1:0] dout_y;
    output reg [1:0] dout_local;
    // 00--reset;
    // 01--X;
    // 10--Y;
    // 11--local;
    
    wire [1:0] destination_location_x;
    wire [1:0] source_location_x;
    
    wire [1:0] destination_location_y;
    wire [1:0] source_location_y;
    
    wire [1:0] destination_location_local;
    wire [1:0] source_location_local;
    
    assign destination_location_x = {din_x[37],din_x[36]};
    assign source_loaction_x      = {din_x[39], din_x[38]};
    
    assign destination_location_y = {din_y[37],din_y[36]};
    assign source_loaction_y      = {din_y[39], din_y[38]};
    
    assign destination_location_local = {din_local[37],din_local[36]};
    assign source_loaction_local      = {din_local[39], din_local[38]};
    
    
    wire [1:0] judgement_signal_x;
    wire [1:0] judgement_signal_y;
    wire [1:0] judgement_signal_local;
    assign judgement_signal_x     = current_location ^~ destination_location_x;
    assign judgement_signal_y     = current_location ^~ destination_location_y;
    assign judgement_signal_local = current_location ^~ destination_location_local;
    
    always @(posedge clk or posedge rst_n) begin
        if (!rst_n) dout_x <= 00;
        case (judgement_signal_x)
            2'b00: dout_x   <= 01;
            2'b01: dout_x   <= 10;
            2'b10: dout_x   <= 01;
            2'b11: dout_x   <= 11;
            default: dout_x <= 00;
        endcase
    end
    
    always @(posedge clk or posedge rst_n) begin
        if (!rst_n) dout_y <= 00;
        case (judgement_signal_y)
            2'b00: dout_y   <= 01;
            2'b01: dout_y   <= 10;
            2'b10: dout_y   <= 01;
            2'b11: dout_y   <= 11;
            default: dout_y <= 00;
        endcase
    end
    
    always @(posedge clk or posedge rst_n) begin
        if (!rst_n) dout_local <= 00;
        case (judgement_signal_local)
            2'b00: dout_local   <= 01;
            2'b01: dout_local   <= 10;
            2'b10: dout_local   <= 01;
            2'b11: dout_local   <= 11;
            default: dout_local <= 00;
        endcase
    end
    
    
    // this is only conducted by 'if' sentenses
    
    // always @(posedge clk or negedge rst_n) begin
    //     if (!rst_n)
    //         dout <= 00;
    //     else if (current_location ^~ destination_location == 00)
    //         dout <= 01; //X
    //     else if (current_location ^~ destination_location == 01)
    //         dout <= 10; //Y
    //     else if (current_location ^~ destination_location == 10)
    //         dout <= 01; //X
    //     else if (current_location ^~ destination_location == 11)
    //         dout <= 11; // Local
    
    // end
    
endmodule
    
    
