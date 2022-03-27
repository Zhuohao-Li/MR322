// readme:
// This can judge the allocation when it happens conflict.
// Input is the direction of each data package
// Output is a 3-bit signal indicates which package have transfered unsuccessfully

// parameter:
// clk(clock)
// rst_n((negatively effecitve))
// dout(the direction of each data package :00-NONE 01-X 10-Y 11-LOCAL)

// fail(001-X 010-Y 100-LOCAL)

// released:3/15/2022
// author: hongyang gu



module priority_cal(
    input [1:0] pri,
    input en, clk, rst_n,
    output [1:0] fail
    );

    assign fail[1] = (!pri[1]) && pri[0];
    assign fail[0] = pri[1] || (!pri[0]);

endmodule

module priority_all(
    input [2:0] fail, 
    input clk, rst_n,
    output reg [2:0] pri
    );
    wire one_suc;
    assign one_suc = fail[2] && fail[1] && fail[0];

    always @(posedge clk or posedge rst_n) begin
        if (!rst_n) begin
            // reset
            pri <= 3'b000;
        end
        else begin
            pri[2] <= (pri[2] && one_suc) || fail[2];
            pri[1] <= (pri[1] && one_suc) || fail[1];
            pri[0] <= (pri[0] && one_suc) || fail[0];
        end
    end

endmodule

module conflict(
    input [1:0] m_dst, n_dst,
    output mn_con
    );

    wire [1:0] eq;

    assign eq = m_dst ~^ n_dst;

    assign mn_con = eq[1] && eq[0];

endmodule

module judge(
    input clk, rst_n,
    input [1:0] dout_x, dout_y, dout_local,
    output [2:0] fail
    );

    // 2: x, 1: y, 0: z
    wire [2:0] pri;
    // 2: xy, 1: yz, 0: xz
    wire [2:0] fail_0, fail_1;
    wire [2:0] con;
    conflict ConXY(dout_x, dout_y, con[2]);
    conflict ConYZ(dout_y, dout_local, con[1]);
    conflict ConXZ(dout_x, dout_local, con[0]);
    priority_cal PCalXY(pri[2:1], con[2], clk, rst_n, {fail_0[2], fail_1[1]});
    priority_cal PCalYZ(pri[1:0], con[1], clk, rst_n, {fail_0[1], fail_1[0]});
    priority_cal PCalXZ({pri[2], pri[0]}, con[0], clk, rst_n, {fail_1[2], fail_0[0]});
    assign fail = fail_0 | fail_1;
    priority_all PAll(fail, clk, rst_n, pri);

endmodule
