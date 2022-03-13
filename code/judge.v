//


module priority_cal(input [1:0] pri,
                    input en,
                    clk,
                    rst,
                    output reg [1:0] fail = 2'b00);

always @(posedge clk or posedge rst) begin
    if (rst || !en) begin
        // reset
        fail <= 2'b00;
    end
    else if (en) begin
        fail[1] <= (!pri[1]) && pri[0];
        fail[0] <= pri[1] || (!pri[0]);
    end
        end
        
        endmodule
        
        module priority_all(
            input [2:0] fail,
            input clk, rst,
            output reg [2:0] pri = 3'b000
            );
            wire one_suc;
            assign one_suc = fail[2] && fail[1] && fail[0];
            
            always @(posedge clk or posedge rst) begin
                if (rst) begin
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
                    input [5:0] dst,
                    input clk, rst,
                    output [2:0] fail
                    );
                    // 2: x, 1: y, 0: z
                    wire [2:0] suc;
                    wire [2:0] pri;
                    // 2: xy, 1: yz, 0: xz
                    wire [2:0] fail_0, fail_1;
                    wire [2:0] con;
                    conflict ConXY(dst[5:4], dst[3:2], con[2]);
                    conflict ConYZ(dst[3:2], dst[1:0], con[1]);
                    conflict ConXZ(dst[5:4], dst[1:0], con[0]);
                    priority_cal PCalXY(pri[2:1], con[2], clk, rst, {fail_0[2], fail_1[1]});
                    priority_cal PCalYZ(pri[1:0], con[1], clk, rst, {fail_0[1], fail_1[0]});
                    priority_cal PCalXZ({pri[2], pri[0]}, con[0], clk, rst, {fail_1[2], fail_0[0]});
                    assign fail = fail_0 | fail_1;
                    priority_all PAll(fail, clk, rst, pri);
                    ## after the one before was fails, the next one is set a higher priority.
                    
                endmodule
