//状态机P183 第二种描述用可综合Verilog模块设计、用热独码表示状态的状态机
module fsm(Clock,Reset,A,K2,K1);
input 			Clock,Reset,A;
output 			K2,K1;
reg 			K2,K1;
reg		[3:0] 	state;

parameter 	Idle = 	4'b1000,	//有变化
			Start = 4'b0100,
			Stop = 	4'b0010,
			Clear = 4'b0001;
			
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
			default:state <= Idle;		//有变化
		endcase
	end // else

end // always

endmodule

//采用热独码（建议），提高电路速度和可靠性。有了不可到达的状态因此需要default,以确保回到Idle状态






















