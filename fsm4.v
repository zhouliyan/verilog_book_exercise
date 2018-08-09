//状态机P187 用可综合的Verilog模块设计复杂的多输出状态机时常用的方法
module fsm(Clock,Reset,A,K2,K1);
input 			Clock,Reset,A;
output 			K2,K1;
reg				K2,K1;
reg		[1:0]	state,nextstate;

parameter 	Idle = 2'b00,
			Start = 2'b01,
			Stop = 2'b10,
			Clear = 2'b11;
			
//每一个时钟沿产生一次可能的状态变化			
always@(posedge Clock)begin
	if(!Reset)
		state <= Idle;
	else
		state <= nextstate;
end // always

//产生下一状态的组合逻辑
always@(state or A)begin
	case(state)
	Idle:begin
		if(A) 	nextstate <= Start;
		else 	nextstate <= Idle;
	end // Idle
	Start:begin
		if(!A) 	nextstate<= Stop;
		else 	nextstate<= Start;
	end // Start
	Stop:begin
		if(A) 	nextstate <= Clear;
		else 	nextstate <= Stop;
	end // Stop
	Clear:begin
		if(!A) 	nextstate <= Idle;
		else 	nextstate <= Clear;
	end // Clear
	default:
		nextstate <= 2'bxx;
	endcase
end // always

//产生输出K1的组合逻辑
always@(state or Reset or A)begin
	if(!Reset)
		K1 <= 0;
	else if(state == Clear && !A) //从Clear转向Idle
		K1 <= 1;
	else
		K1 <= 0;
end // always

//产生输出K2的组合逻辑
always@(state or Reset or A)begin
	if(!Reset)
		K2 <= 0;
	else if(state == Stop && A) //从Stop转向Clear
		K2 <= 1;
	else
		K2 <= 0;
end // always

endmodule
