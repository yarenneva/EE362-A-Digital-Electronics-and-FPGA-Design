`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    13:37:53 10/14/2021 
// Design Name: 
// Module Name:    stateMachine 
// Project Name: 
// Target Devices: 
// Tool versions: 
// Description: 
//
// Dependencies: 
//
// Revision: 
// Revision 0.01 - File Created
// Additional Comments: 
//
//////////////////////////////////////////////////////////////////////////////////
module stateMachine(rst,clk,btn,ledOut);
input rst,clk,btn;
output reg [3:0] ledOut;

reg [3:0] ledOutNext;
reg [3:0] stateCount, stateCountNext;
reg btnPrev;

wire valid;

always @(posedge clk) begin
   stateCount <= #1 stateCountNext;
   ledOut <= #1 ledOutNext;
	btnPrev <=#1 btn;
end

assign valid= btn && ~ btnPrev;

always @(*) begin

   stateCountNext=stateCount;
   ledOutNext = ledOut;
	
   if(rst) begin
		ledOutNext=3'b001;
		stateCountNext=3'b000;
		
	end
	if(valid)begin
	stateCountNext=stateCount+1;
	end
	

		if(stateCount == 3'b000) begin
		   ledOutNext = 3'b001;
		end else if(stateCount == 3'b001) begin
		   ledOutNext = 3'b010;
		end else if(stateCount == 3'b010) begin
		   ledOutNext = 3'b011;
		end else if(stateCount == 3'b011) begin
		   ledOutNext = 3'b100;
		end else if(stateCount == 3'b100)begin
			stateCountNext=3'b000;
		end
	
	
end

endmodule
