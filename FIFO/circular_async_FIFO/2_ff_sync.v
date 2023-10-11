module two_flop_sync(in,clk,out);

input [3:0]in;
input clk;
reg [3:0]q;
output reg [3:0]out;

always@(posedge clk)
begin
q<=in;
out<=q;
end
endmodule 