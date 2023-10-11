module fifo_async_tb;

reg [3:0]data_in;
reg rd_en, wr_en;
reg rd_rst, wr_rst;
reg rd_clk=0;
reg wr_clk=0;

wire [3:0]data_out;
wire empty, full;

fifo_async f(data_out,empty,full,data_in,rd_en,wr_en,rd_rst,wr_rst,rd_clk,wr_clk);

always #5 wr_clk=~wr_clk;
always #2 rd_clk=~rd_clk;

initial
begin
wr_en=1;rd_en=0;
#20 rd_en=1;
#20 rd_en=0;wr_en=1;
#20 rd_en=1;wr_en=1;
#18 rd_en=1;wr_en=0;
end

initial
begin
wr_rst=0; rd_rst=0;
#1 wr_rst=1; rd_rst=1;
end

initial
begin
#4 data_in=0;
#10 data_in=11;
#11 data_in=6;
#10 data_in=5;
#10 data_in=9;
#10 data_in=7;
#10 data_in=5;
#10 data_in=11;
#10 data_in=8;
#10 data_in=2;
#10 data_in=3;
#10 data_in=13;
#10 data_in=11;
#10 data_in=8;
#10 data_in=2;
#10 data_in=3;
#10 data_in=13;
#10 data_in=11;
#10 data_in=6;
#10 data_in=5;
#10 data_in=9;
#10 data_in=7;
#10 data_in=5;
#10 data_in=11;
#10 data_in=11;
#10 data_in=8;
#10 data_in=2;
#10 data_in=3;
end

endmodule