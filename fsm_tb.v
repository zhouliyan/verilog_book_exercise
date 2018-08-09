//fsm的测试模块
'timescale 1ns/1ns

module fsm_tb;
reg a;
reg clock,rst;
wire k2,k1;

initial begin			//initial常用于仿真时信号的给出
a = 0;
rst = 1;				//给复位信号变量赋初始值
clock = 0;				//给时钟变量赋初始值
#22 rst = 0;			//使复位信号有效
#133 rst = 1;			//经过一个多周期后使复位信号无效
end // initial

always #50 clock = ~clock;		//产生周期性的时钟

always@(posedge clock)begin	//在每次时钟正跳变沿时刻产生不同的a
	#30 a = {$random} % 2;		//每次a的值是0还是1是随机的
	#(3*50 + 12);				//a的值维持一段时间
end // always

initial begin
	#100000 $stop;				//系统任务，暂停仿真以便观察仿真波形
end //initial

fsm m(.Clock(clock),.Reset(rst),.A(a),.K2(k2),.K1(k1));	//调用被测试模块

endmodule



