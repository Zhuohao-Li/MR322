 //readme
//this is the whole pipline
//rst_n  (asy)   hign effective 
//port define refer to the commond of professor
//when any next fifo is full, stop all pipline wating 
//when any fail came ,stop all module before transport.v
//there are some control signals with "con" "control""en"
//
//there have fifo router judge store trans dataselect 
//6 level pipline if no conflict
//7 level when conflict
//
//giving next fifo wclk 
//geting rclk from premodule
//released:04/06/2022
//author:qilong han

module router00#(
     parameter wd = 40)
(
input rst_n,
input wr_en_x,
input wr_en_y,
input wr_en_local,
input [wd-1:0] wdata_x,
input [wd-1:0] wdata_y,
input [wd-1:0] wdata_local,
input wclk_x,//
input wclk_y,
input wclk_local,
input rclk,//
input clk,
input next_full_x,
input next_full_y,
input next_full_local,
output full_x,
output full_y,
output full_local,
output reg [wd-1:0]data_to_x,
output reg [wd-1:0]data_to_y,
output reg [wd-1:0]data_to_local,
output wr_next_x_en,
output wr_next_y_en,
output wr_next_local_en
);


wire empty_x,empty_y,empty_local;
wire [wd-1:0]rdata_x;
wire [wd-1:0]rdata_y;
wire [wd-1:0]rdata_local;
wire control_clk_fifo;


reg con_clk;

reg con_conf_clk;
assign wr_next_y_en=(data_to_y!==0);
assign wr_next_local_en=(data_to_local!==0);
assign wr_next_x_en=(data_to_x!==0);
reg [39:0] DATA_SECOND;
reg [5:0] DATA_SECOND_MUX;
reg flag_CON;
wire flag;
wire [39:0] WIRE_DATA_SECOND;
wire [5:0] WIRE_DATA_SECOND_MUX;

reg [39:0]TRANS_SEL_DATAX;
reg [39:0]TRANS_SEL_DATAY;
reg [39:0]TRANS_SEL_DATALOCAL;
wire [39:0] WIRE_TRANS_SEL_DATAX;
wire [39:0] WIRE_TRANS_SEL_DATAY;
wire [39:0] WIRE_TRANS_SEL_DATALOCAL;

reg [5:0]LAST_DATA_SEC_MUX;
wire [5:0] WIRE_LAST_DA_SE_MUX;
assign WIRE_LAST_DA_SE_MUX=LAST_DATA_SEC_MUX;

assign control_clk_fifo=(con_clk||con_conf_clk);
assign WIRE_DATA_SECOND=DATA_SECOND;
assign WIRE_DATA_SECOND_MUX=DATA_SECOND_MUX;
assign flag=flag_CON;

wire rd_x_en;
assign rd_x_en=!((rst_n || con_clk )||con_conf_clk);
wire rd_y_en;
assign rd_y_en=!((rst_n || con_clk )||con_conf_clk);
wire rd_local_en;
assign rd_local_en=!((rst_n || con_clk )||con_conf_clk);

fifo_asy #(
    .wa(3),
    .wd(40)
) fifo_syn_x(
    .rst_n (rst_n),
    .wclk (wclk_x),//???
    .wr_en(wr_en_x),
    .wdata(wdata_x),
    .full(full_x),
    .rd_en(rd_x_en),
    .rclk (rclk),
    .rdata(rdata_x),
    .empty(empty_x),
	.control_clk(control_clk_fifo)
);

fifo_asy #(
    .wa(3),
    .wd(40)
) fifo_syn_y(
    .rst_n (rst_n),
    .wclk (wclk_y),//???
    .wr_en(wr_en_y),
    .wdata(wdata_y),
    .full(full_y),
    .rd_en(rd_y_en),
    .rclk (rclk),
    .rdata(rdata_y),
    .empty(empty_y),
	.control_clk(control_clk_fifo)
);

fifo_asy #(
    .wa(3),
    .wd(40)
) fifo_syn_local(
    .rst_n (rst_n),
    .wclk (wclk_local),//???
    .wr_en(wr_en_local),
    .wdata(wdata_local),
    .full(full_local),
    .rd_en(rd_local_en),
    .rclk (rclk),
    .rdata(rdata_local),
    .empty(empty_local),
	.control_clk(control_clk_fifo)
);


//*******************************************************
wire  [1:0] MUX_DATAX;
wire  [1:0] MUX_DATAY;
wire  [1:0] MUX_DATALOCAL;
wire  [1:0] CURRENT_LOCATION;
assign CURRENT_LOCATION=2'b00;

Router_algorithm Router_algorithm_for(.clk(clk),
                        .rst_n(rst_n),
                        .din_x(rdata_x),
                        .din_y(rdata_y),
                        .din_local(rdata_local),
                        .current_location(CURRENT_LOCATION),
                        .dout_x(MUX_DATAX),
                        .dout_y(MUX_DATAY),
                        .dout_local(MUX_DATALOCAL),
						.control_clk(control_clk_fifo));


reg [39:0] FIFO_X_ROUTER;
reg [39:0] FIFO_Y_ROUTER;
reg [39:0] FIFO_LOCAL_ROUTER;
wire [39:0] ROUTER_JUDGE_X;
wire [39:0] ROUTER_JUDGE_Y;
wire [39:0] ROUTER_JUDGE_LOCAL;

assign ROUTER_JUDGE_LOCAL=FIFO_LOCAL_ROUTER;
assign  ROUTER_JUDGE_X=FIFO_X_ROUTER;
assign  ROUTER_JUDGE_Y=FIFO_Y_ROUTER;

always @(posedge clk or posedge rst_n)
begin
if(rst_n)
	FIFO_X_ROUTER<=40'b0;
	else
	begin
	if(!control_clk_fifo)
	FIFO_X_ROUTER<=rdata_x;
end	
end
always @(posedge clk or posedge rst_n)
begin
if(rst_n)
	FIFO_Y_ROUTER<=40'b0;
	else
	begin
	if(!control_clk_fifo)
	FIFO_Y_ROUTER<=rdata_y;
	end
end
always @(posedge clk or posedge rst_n)
begin
if(rst_n)
	FIFO_LOCAL_ROUTER<=40'b0;
	else
	begin
	if(!control_clk_fifo)
	FIFO_LOCAL_ROUTER<=rdata_local;
	end
end

//***************************************************************************************

wire [2:0] FAILXYL;

judge judge_for(
    .clk(clk), .rst_n(rst_n),
    .dout_x(MUX_DATAX), .dout_y(MUX_DATAY), .dout_local(MUX_DATALOCAL),
    .fail(FAILXYL),
	.control_clk(control_clk_fifo)
    );

reg  [1:0] WAIT_JUDGE_X;
reg  [1:0] WAIT_JUDGE_Y;
reg  [1:0] WAIT_JUDGE_LOCAL;
wire [1:0] JUDGE_TRANS_X;
wire [1:0] JUDGE_TRANS_Y;
wire [1:0] JUDGE_TRANS_LOCAL;

assign  JUDGE_TRANS_X=WAIT_JUDGE_X;
assign JUDGE_TRANS_Y=WAIT_JUDGE_Y;
assign  JUDGE_TRANS_LOCAL=WAIT_JUDGE_LOCAL;

always@(posedge clk or posedge rst_n)
begin
if(rst_n)
WAIT_JUDGE_X<=2'b0;
else
begin
if(!control_clk_fifo)
WAIT_JUDGE_X<=MUX_DATAX;
end
end

always@(posedge clk or posedge rst_n)
begin
if(rst_n)
WAIT_JUDGE_Y<=2'b0;
else
begin
if(!control_clk_fifo)
WAIT_JUDGE_Y<=MUX_DATAY;
end
end
always@(posedge clk or posedge rst_n)
begin
if(rst_n)
WAIT_JUDGE_LOCAL<=2'b0;
else
begin
if(!control_clk_fifo)
WAIT_JUDGE_LOCAL<=MUX_DATALOCAL;
end
end 

reg [39:0] JUDGE_TRANS_DATAX;
reg [39:0] JUDGE_TRANS_DATAY;
reg [39:0] JUDGE_TRANS_DATALOCAL;
wire [39:0] WIRE_JUD_TRAN_DAX;
wire [39:0] WIRE_JUD_TRAN_DAY;
wire [39:0] WIRE_JUD_TRAN_DALOCAL;
assign WIRE_JUD_TRAN_DAX=JUDGE_TRANS_DATAX;
assign WIRE_JUD_TRAN_DAY=JUDGE_TRANS_DATAY;
assign WIRE_JUD_TRAN_DALOCAL=JUDGE_TRANS_DATALOCAL;

always@(posedge clk or posedge rst_n)
begin
if(rst_n)
JUDGE_TRANS_DATAX<=40'b0;
else
begin
if(!control_clk_fifo)
JUDGE_TRANS_DATAX<=ROUTER_JUDGE_X;
end
end

always@(posedge clk or posedge rst_n)
begin
if(rst_n)
JUDGE_TRANS_DATAY<=40'b0;
else
begin
if(!control_clk_fifo)
JUDGE_TRANS_DATAY<=ROUTER_JUDGE_Y;
end
end
always@(posedge clk or posedge rst_n)
begin
if(rst_n)
JUDGE_TRANS_DATALOCAL<=40'b0;
else
begin
if(!control_clk_fifo)
JUDGE_TRANS_DATALOCAL<=ROUTER_JUDGE_LOCAL;
end
end
//********************************************************

reg [2:0] FAIL_X_Y_LOCAL;
wire[2:0] WIRE_FAIL_XYLOCAL; 
assign WIRE_FAIL_XYLOCAL=con_conf_clk?3'b0:FAIL_X_Y_LOCAL;
//assign WIRE_FAIL_XYLOCAL=FAIL_X_Y_LOCAL;

always@(posedge clk or posedge rst_n)
begin
if(rst_n)
FAIL_X_Y_LOCAL<=3'b0;
else
begin
if(!control_clk_fifo)
FAIL_X_Y_LOCAL<=FAILXYL;
end
end 

reg  [1:0] REG_MUX_X;
reg  [1:0] REG_MUX_Y;
reg  [1:0] REG_MUX_LOCAL;
wire [1:0] MUX_X;
wire [1:0] MUX_Y;
wire [1:0] MUX_LOCAL;
assign MUX_X=REG_MUX_X;
assign MUX_Y=REG_MUX_Y;
assign MUX_LOCAL=REG_MUX_LOCAL;

always@(posedge clk or posedge rst_n)
begin
if(rst_n )
REG_MUX_X<=2'b0;
else
begin
if(!control_clk_fifo)
REG_MUX_X<=JUDGE_TRANS_X;
end
end
always@(posedge clk or posedge rst_n)
begin
if(rst_n )
REG_MUX_Y<=2'b0;
else
begin
if(!control_clk_fifo)
REG_MUX_Y<=JUDGE_TRANS_Y;
end
end
always@(posedge clk or posedge rst_n)
begin
if(rst_n )
REG_MUX_LOCAL <=2'b0;
else
begin
if(!control_clk_fifo)
REG_MUX_LOCAL <=JUDGE_TRANS_LOCAL ;
end
end

reg [39:0] TRANSF_TRANS_DATAX;
reg [39:0] TRANSF_TRANS_DATAY;
reg [39:0] TRANSF_TRANS_DATALOCAL;
wire [39:0] WIRE_TRANSF_TRANS_DATAX;
wire [39:0] WIRE_TRANSF_TRANS_DATALOCAL;
wire [39:0] WIRE_TRANSF_TRANS_DATAY;

assign WIRE_TRANSF_TRANS_DATAX=TRANSF_TRANS_DATAX;
assign WIRE_TRANSF_TRANS_DATAY=TRANSF_TRANS_DATAY;
assign WIRE_TRANSF_TRANS_DATALOCAL=TRANSF_TRANS_DATALOCAL;

always@(posedge clk or posedge rst_n)
begin
if(rst_n)
TRANSF_TRANS_DATAX<=40'b0;
else
begin
if(!control_clk_fifo)
TRANSF_TRANS_DATAX<=WIRE_JUD_TRAN_DAX;
end
end
always@(posedge clk or posedge rst_n)
begin
if(rst_n)
TRANSF_TRANS_DATAY<=40'b0;
else
begin
if(!control_clk_fifo)
TRANSF_TRANS_DATAY<=WIRE_JUD_TRAN_DAY;
end
end
always@(posedge clk or posedge rst_n)
begin
if(rst_n)
TRANSF_TRANS_DATALOCAL<=40'b0;
else
begin
if(!control_clk_fifo)
TRANSF_TRANS_DATALOCAL<=WIRE_JUD_TRAN_DALOCAL;
end
end

//*******************************************************************
reg [2:0] TRANS_FAIL;
wire [2:0]WIRE_TRANS_FAIL;
wire [1:0] CON_X;
wire [1:0] CON_Y;
wire [1:0] CON_LOCAL;
transport  transport_for(.clk(clk),
                  .rst_n(rst_n),
                  .router_algorithm_out_x(MUX_X),
                  .router_algorithm_out_y(MUX_Y),
                  .router_algorithm_out_local(MUX_LOCAL),
                  .control_x(CON_X),
                  .control_y(CON_Y),
                  .control_local(CON_LOCAL),
				  .fail(WIRE_TRANS_FAIL),
				  .control_clk(con_clk));



assign WIRE_TRANS_FAIL=TRANS_FAIL;
assign WIRE_TRANS_SEL_DATAX=TRANS_SEL_DATAX;
assign WIRE_TRANS_SEL_DATALOCAL=TRANS_SEL_DATALOCAL;
assign WIRE_TRANS_SEL_DATAY=TRANS_SEL_DATAY;

always@(posedge clk or posedge rst_n)
begin
if(rst_n)
TRANS_FAIL<=3'b0;
else
begin
if(!control_clk_fifo)
TRANS_FAIL<=FAIL_X_Y_LOCAL;
end
end
always@(posedge clk or posedge rst_n)
begin
if(rst_n)
TRANS_SEL_DATAX<=40'b0;
else
begin
if(!con_clk)
TRANS_SEL_DATAX<=WIRE_TRANSF_TRANS_DATAX;
end
end
always@(posedge clk or posedge rst_n)
begin
if(rst_n)
TRANS_SEL_DATAY<=40'b0;
else
begin
if(!con_clk)
TRANS_SEL_DATAY<=WIRE_TRANSF_TRANS_DATAY;
end
end
always@(posedge clk or posedge rst_n)
begin
if(rst_n)
TRANS_SEL_DATALOCAL <=40'b0;
else
begin
if(!con_clk)
TRANS_SEL_DATALOCAL <=WIRE_TRANSF_TRANS_DATALOCAL ;
end
end

//******************************************************************************
wire [1:0] FINAL_CON_X;
wire [1:0] FINAL_CON_Y;
wire [1:0] FINAL_CON_LOCAL;
assign FINAL_CON_X=flag?{WIRE_LAST_DA_SE_MUX[1],WIRE_LAST_DA_SE_MUX[0]}:CON_X;
assign FINAL_CON_Y=flag?{WIRE_LAST_DA_SE_MUX[3],WIRE_LAST_DA_SE_MUX[2]}:CON_Y;
assign FINAL_CON_LOCAL=flag?{WIRE_LAST_DA_SE_MUX[5],WIRE_LAST_DA_SE_MUX[4]}:CON_LOCAL;


always @(posedge clk or posedge rst_n)
    begin
        if (rst_n) data_to_x <= 40'b0; // output is all zeros, which means it's false
		else
		begin
		if(!con_clk)
		begin
        case ({FINAL_CON_X[1],FINAL_CON_X[0]})
            2'b00: data_to_x  <= 40'b0;
            2'b01: data_to_x  <= WIRE_TRANS_SEL_DATAX;
            2'b10:  data_to_x  <= WIRE_TRANS_SEL_DATAY;
            2'b11:  data_to_x  <= WIRE_TRANS_SEL_DATALOCAL;
            default: data_to_x  <= 40'b0;
        endcase
		end
    end
	end
    
always @(posedge clk or posedge rst_n)
    begin
        if (rst_n) data_to_y <= 40'b0; // output is all zeros, which means it's false
		else
		begin
		if(!con_clk)
		begin
        case ({FINAL_CON_Y[1],FINAL_CON_Y[0]})
            2'b00: data_to_y <= 40'b0;
            2'b01: data_to_y  <= WIRE_TRANS_SEL_DATAX;
            2'b10:  data_to_y  <= WIRE_TRANS_SEL_DATAY;
            2'b11:  data_to_y  <= WIRE_TRANS_SEL_DATALOCAL;
            default: data_to_y  <= 40'b0;
        endcase
		end
		end
    end
always @(posedge clk or posedge rst_n)
    begin
        if (rst_n) data_to_local <= 40'b0; // output is all zeros, which means it's false
		else
		begin
		if(!con_clk)
		begin
        case ({FINAL_CON_LOCAL[1],FINAL_CON_LOCAL[0]})
            2'b00: data_to_local  <= 40'b0;
            2'b01: data_to_local  <= WIRE_TRANS_SEL_DATAX;
            2'b10:  data_to_local  <= WIRE_TRANS_SEL_DATAY;
            2'b11:  data_to_local  <= WIRE_TRANS_SEL_DATALOCAL;
            default: data_to_local  <= 40'b0;
        endcase
		end 
		end
    end
//*****************************************************************************************



always@(posedge clk or  posedge rst_n)
begin
if(rst_n)
con_clk<=1'b0;
else
begin
if((next_full_local || next_full_x) || next_full_y)
con_clk<=1'b1;
else
con_clk<=1'b0;
end
end



always@(posedge clk or posedge rst_n)
begin 
if(rst_n)
con_conf_clk<=0;
else
begin
if((WIRE_FAIL_XYLOCAL[0] || WIRE_FAIL_XYLOCAL[1]) || WIRE_FAIL_XYLOCAL[2])
con_conf_clk<=1;
else 
con_conf_clk<=0;
end
end

//*******************************************************

/*
always@(posedge clk or posedge rst_n)
begin
if((rst_n || con_clk )||con_conf_clk)
rd_x_en<=0;
else
rd_x_en<=1;
end
always@(posedge clk or posedge rst_n)
begin
if((rst_n || con_clk) || con_conf_clk)
rd_y_en<=0;
else
rd_y_en<=1;
end
always@(posedge clk or posedge rst_n)
begin
if((rst_n || con_clk) ||con_conf_clk)
rd_local_en<=0;
else
rd_local_en<=1;
end
*/
//*******************************************************




always@(posedge clk or posedge rst_n)
begin
if(rst_n)
{DATA_SECOND}<=40'b0;
else
begin 
if(!con_clk)
begin
case (WIRE_FAIL_XYLOCAL)
		3'b100:{DATA_SECOND}<={WIRE_TRANSF_TRANS_DATAX};
		3'b010:{DATA_SECOND}<={WIRE_TRANSF_TRANS_DATAY};
		3'b001:{DATA_SECOND}<={WIRE_TRANSF_TRANS_DATALOCAL};
            default: {DATA_SECOND}<=40'b0;
    endcase
end
end 
end

always@(posedge clk or posedge rst_n)
begin 
if(rst_n)
flag_CON<=1'b0;
else 
begin
if(!con_clk)
begin 
if(DATA_SECOND_MUX!==6'b000000)
flag_CON<=1'b1;
else
flag_CON<=1'b0;
end 
end

end 

always@(posedge clk or posedge rst_n)
begin
if(rst_n)
DATA_SECOND_MUX<=6'b0;
else
begin 
if(!con_clk)
begin
case (WIRE_FAIL_XYLOCAL)
		3'b100:begin
		case(MUX_X)
			2'b01:DATA_SECOND_MUX<=6'b000001;
			2'b10:DATA_SECOND_MUX<=6'b000100;
			2'b11:DATA_SECOND_MUX<=6'b010000;
			default:DATA_SECOND_MUX<=6'b0;
		endcase
		end
		3'b010:
		begin
		case(MUX_Y)
			2'b01:DATA_SECOND_MUX<=6'b000010;
			2'b10:DATA_SECOND_MUX<=6'b001000;
			2'b11:DATA_SECOND_MUX<=6'b100000;
			default:DATA_SECOND_MUX<=6'b0;
		endcase
		end
		3'b001:
		begin
		case(MUX_LOCAL)
			2'b01:DATA_SECOND_MUX<=6'b000011;
			2'b10:DATA_SECOND_MUX<=6'b001100;
			2'b11:DATA_SECOND_MUX<=6'b110000;
			default:DATA_SECOND_MUX<=6'b0;
		endcase
		end
            default: DATA_SECOND_MUX<=6'b0;
    endcase
end
end 
end


always@(posedge clk or posedge rst_n)
begin 
if(rst_n)
LAST_DATA_SEC_MUX<=6'b0;
else
begin
if(!con_clk) 
LAST_DATA_SEC_MUX<=WIRE_DATA_SECOND_MUX;
end 
end 




//***********************************************************

endmodule


