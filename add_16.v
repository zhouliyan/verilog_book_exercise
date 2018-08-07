//16位加法器
module add_16(X,Y,sum,C);
input[15:0] X,Y;
output[15:0] sum;
output C;

assign {C,Sum} = X + Y;

endmodule