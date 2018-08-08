//状态机P183 第一种描述用可综合Verilog模块设计状态机的典型办法
module fsm(Clock,Reset,A,K2,K1);
input 			Clock,Reset,A;
output 			K2,K1;
output	[1:0] 	state;
reg 			K2,K1;
reg		[1:0] 	state;

parameter 	Idle = 2'b00,
			Start = 2'b01,
			Stop = 2'b10,
			Clear = 2'b11;
			
always@(posedge Clock)begin
	if(!Reset)begin
		state <= Idle;
		K2 <= 0;
		K1 <= 0;
	end // if
	else begin
		case(state)
			Idle:begin
				if(A)begin	
					state <= Start;
					K1 <= 0;
				end // if
				else begin
					state <= Idle;
					K2 <= 0;
					K1 <= 0;
				end // else
			end //Idle
			Start:begin
				if(!A)
					state <= Stop;
				else
					state <= Start;
			end // Start
			Stop:begin
				if(A)begin
					state <= Clear;
					K2 <= 1;
				end // else 
				else begin
					state <= Stop;
					K2 <= 0;
					K1 <= 0;
				end // else
			end // Stop
			Clear:begin
				if(!A)begin
					state <= Idle;
					K2 <= 0;
					K1 <= 1;
				end // if
				else begin
					state <= Clear;
					K2 <= 0;
					K1 <= 0;
				end// else
			end // Clear
			default:state <= 2'bxx;
		endcase
	end // else

end // always

endmodule























