// readme:
// This can cover the failed dout (the direction of each data package) with 2'b00 by fail signal
// Input is dout and fail signal
// Output is dout_


// parameter:
// clk(clock)
// enable(enable)
// rst_n((negatively effecitve))
// dout(the direction of each data package :00-NONE 01-X 10-Y 11-LOCAL)

// dout_(clear the direction of the data package which is sent unsuccessfully)

// released:3/15/2022
// author: hongyang gu

module transport_fail(
    input clk, enable, rst_n,
    input [1:0] dout_x, dout_y, dout_local,
    input [2:0] fail,
    output [1:0] dout_x, dout_y, dout_local);


transport_fail_unit tfuX(clk, enable, rst_n, dout_x, fail[2], dout_x);
transport_fail_unit tfuY(clk, enable, rst_n, dout_y, fail[1], dout_y);
transport_fail_unit tfuLOCAL(clk, enable, rst_n, dout_local, fail[0], dout_local);

//here use two registers because it takes one cycle for judge.v to calculate fail signal

endmodule

module transport_fail_unit(
    input clk, enable, rst_n,
    input [1:0] dout,
    input fail,
    output reg [1:0] dout_);

always @(posedge clk or posedge rst_n) begin
    if (!rst_n) begin
        // reset
        dout_ <= 2'b00;
    end
    else if (enable) begin
        case(fail)
            1'b0:dout_ <= dout;
            1'b1:dout_ <= 2'b00;
            default: dout_ <= 2'b00;
        endcase
    end
end

endmodule