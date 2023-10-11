module fifo_async(data_out,empty,full,data_in,rd_en,wr_en,rd_rst,wr_rst,rd_clk,wr_clk);

input [3:0]data_in;
input rd_en, wr_en;
input rd_rst, wr_rst;
input rd_clk, wr_clk;

output reg [3:0]data_out;
output empty, full;

reg [3:0]mem[0:7];
reg [2:0]wr_add,rd_add;
reg [3:0]wr_ptr, rd_ptr;

wire [3:0]gray_wr_ptr,gray_rd_ptr;
wire [3:0]syn_gray_wr_ptr, syn_gray_rd_ptr;
wire [3:0]syn_wr_ptr,syn_rd_ptr;

assign empty = (rd_ptr==syn_wr_ptr)?1:0;
assign full  = ({~(syn_rd_ptr[3]),syn_rd_ptr[2:0]}==wr_ptr)?1:0;

//read pointer
binary_to_gray b1(rd_ptr,gray_rd_ptr);
two_flop_sync  s1(gray_rd_ptr,wr_clk,syn_gray_rd_ptr);
gray_to_binary b2(syn_gray_rd_ptr,syn_rd_ptr);

//write pointer
binary_to_gray b3(wr_ptr,gray_wr_ptr);
two_flop_sync  s2(gray_wr_ptr,rd_clk,syn_gray_wr_ptr);
gray_to_binary b4(syn_gray_wr_ptr,syn_wr_ptr);

always@(posedge wr_clk, negedge wr_rst)  //write block
begin
if(!wr_rst)
begin
wr_ptr<=0;
wr_add<=0;
end
else if(!full && wr_en)
begin
mem[wr_add]<=data_in;
wr_add = (wr_add+1)%8;
wr_ptr = (wr_ptr+1)%16;
end
end


always@(posedge rd_clk, negedge rd_rst) //read block
begin
if(!rd_rst)
begin
rd_ptr<=0;
rd_add<=0;
end
else if(!empty && rd_en)
begin
data_out<=mem[rd_add];
rd_add=(rd_add+1)%8;
rd_ptr=(rd_ptr+1)%16;
end
end

endmodule
