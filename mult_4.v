//四位乘法器
module mult_4(X,Y,Product);

input[3:0] X,Y;
output[3:0] Product;

assign Product = X * Y;

endmodule
