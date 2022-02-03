`timescale 1ns / 1ps

module stateMachine(clk, rst, en, state);

input clk, rst, en;
output reg [2:0] state;

reg [2:0] stateNext;

always @(posedge clk) begin
	state <= #1 stateNext;
end

always @(*) begin
	stateNext=state;
	
	if(rst) begin
		stateNext=6;
	end
	else if(en)begin
		if(state==6)begin
			stateNext=5;
		end
		else if(state==5)begin
			stateNext=4;
		end
		else if(state==4)begin
			stateNext=3;
		end
		else if(state==3)begin
			stateNext=2;
		end
		else if(state==2)begin
			stateNext=1;
		end
		else if(state==1)begin
			stateNext=0;
		end
		else if(state==0)begin
			stateNext=6;
		end
	end
	// Fill in here.
	// state transitions: 0 -> 1 -> 2-> ... -> 6 -> 0 -> ...
end

endmodule
