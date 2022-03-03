// readme:
// This code is implement a router. It receives a packet of data of 40-bit and caculate which direction should it transfer to.
// Input is a 40-bit data packet
// Output is the direction (X, Y, Local), X---01, Y---10, Local---11

module Router(clk,
              rst_n,
              din_x,
              din_y,
              din_local,
              dout,
              current_location);
    
    input wire clk;
    input wire rst_n;
    input wire [39:0] din; // this is input data package
    output reg [1:0] dout; // this is output
    // 00--reset;
    // 01--X;
    // 10--Y;
    // 11--local;
    input wire [1:0] current_location; // this is the signal of the router
    wire [1:0] destination_location;
    wire [1:0] source_location;
    
    assign destination_location = {din[37],din[36]};
    assign source_loaction      = {din[39], din[38]};
    
    
    wire [1:0] judgement_signal;
    assign judgement_signal = current_location ^~ destination_location;
    
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) dout <= 00;
        case (judgement_signal)
            2'b00: dout   <= 01;
            2'b01: dout   <= 10;
            2'b10: dout   <= 01;
            2'b11: dout   <= 11;
            default: dout <= 00;
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
    
    
