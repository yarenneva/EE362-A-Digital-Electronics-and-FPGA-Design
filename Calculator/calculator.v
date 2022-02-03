`timescale 1ns / 1ps

module calculator(clk, rst, validIn, dataIn, ledOut);
input clk, rst, validIn;
input  [7:0] dataIn;
output reg [7:0] ledOut;

reg [1:0] state, stateNext;
reg [7:0] num1, num1Next, ledOutNext;
reg [2:0] operator, operatorNext;
wire valid;

reg validReg;
wire validClean;
assign valid = validClean &!validReg; 


always @(posedge clk) begin
	state      <= #1 stateNext;
	num1       <= #1 num1Next;
	operator   <= #1 operatorNext;
	ledOut     <= #1 ledOutNext;
	validReg   <= #1 validClean;
end

debounce dbc (.clk(clk), .rst(rst), .in(validIn), .out(validClean));

always @(*) begin
	stateNext    = state;
	num1Next     = num1;
	operatorNext = operator;
	ledOutNext   = ledOut;
	if(rst) begin
		stateNext    = 0;
		num1Next     = 0;
		operatorNext = 0;
		dataOutNext  = 0;
	end else begin
		case(state)
			0: begin
				if(valid)begin
					num1Next = dataIn;
					dataOutNext = num1;
					stateNext = 1;
				end else begin
					dataOutNext = dataOut;
					stateNext = 0;
				end
			end
			1: begin
				operatorNext=dataIn;
				if(!valid)begin
					dataOutNext = num1;
					stateNext = 1;
				end else begin
					if(operator > 2 && operator < 6) begin
						case(operator)
						3: begin dataOutNext= num1*num1; end
						4: begin dataOutNext=num1+1;   end
						5: begin dataOutNext=num1-1; end
						endcase
					stateNext=0;
					end else if(operator <3)begin
						dataOutNext=operator;
						stateNext=2;
						end
				end
			end
			2: begin
			   if(!valid)begin
				   dataOutNext=operator;
					stateNext=2;
					
            end else begin
					stateNext=0;
					case (operator)
					0: begin dataOutNext=num1*dataIn; end
					1: begin dataOutNext=num1+dataIn; end
					2: begin dataOutNext=num1-dataIn; end
					endcase
				end
			end
		endcase
	end
end


endmodule
