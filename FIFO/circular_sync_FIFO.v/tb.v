module fifo_tb;

reg clk=0;
reg [3:0]data_in;
reg rst,wr_en,rd_en;
wire [3:0]data_out;
wire full,empty;

fifo f(data_out,empty,full,data_in,clk,rst,wr_en,rd_en);

always #5 clk =~clk;

initial
begin
#2 rst=0;
#1 rst=1;
end

initial
begin
data_in=4;
#8 data_in=7;
#9 data_in=2;
#25 data_in=5;
#12 data_in=11;
#13 data_in=14;
#22 data_in=1;
end

initial
begin
#1 wr_en=1;
#1 rd_en=0;
#37 rd_en=1;
#40 rd_en = 0;
end

endmodule