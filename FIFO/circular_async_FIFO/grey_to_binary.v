module gray_to_binary(g,b);

input [3:0]g;
output [3:0]b;
assign b[3]=g[3];

generate 
genvar i;
for(i=3;i>0;i=i-1)
assign b[i-1]=b[i]^g[i-1];
endgenerate

endmodule
