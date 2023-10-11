module binary_to_gray(b,g);

input [3:0]b;
output [3:0]g;
assign g[3]=b[3];

generate 
genvar i;
for(i=0;i<3;i=i+1)
assign g[i]=b[i]^b[i+1];
endgenerate

endmodule
