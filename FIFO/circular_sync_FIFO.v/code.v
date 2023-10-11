module fifo(data_out,empty,full,data_in,clk,rst,wr_en,rd_en);

input [3:0]data_in;
input clk,rst,wr_en,rd_en;
output reg [3:0]data_out;
reg [3:0]wr_ptr,rd_ptr;
reg [3:0]mem[0:7];
reg [3:0]count=0;
output empty, full;

assign empty =(count==0)?1:0; //generate empty
assign full  =(count==8)?1:0; //generate full

always@(posedge clk, negedge rst)  //Write block
begin
if(!rst)
wr_ptr <= 0;
else if(!full&&wr_en)
begin
mem[wr_ptr]<=data_in;
wr_ptr<=(wr_ptr+1)%8;
end
end

always@(posedge clk, negedge rst)  //Read block
begin
if(!rst)
rd_ptr <= 0;
else if(!empty&&rd_en)
begin
data_out<=mem[rd_ptr];
rd_ptr<=(rd_ptr+1)%8;
end
end

always@(posedge clk) //count update
begin : count_block
if((rd_en!=1)&&(wr_en!=1))
count<=count;
else if((!rd_en)&&(wr_en)&&(!full))
count<=(count<8)?(count+1):count;
else if((rd_en)&&(!wr_en)&&(!empty))
count<=(count>0)?(count-1):(count);
else
count<=count;
end

endmodule