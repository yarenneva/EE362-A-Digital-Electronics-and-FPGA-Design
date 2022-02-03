`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    22:19:48 10/13/2021 
// Design Name: 
// Module Name:    UDC 
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
module UDC(rst,upDown,clk,sevenSegment,anode);
input rst;
input upDown;
input clk;
output reg[7:0] sevenSegment;
output reg[3:0] anode;
wire enable;
delay delay(.rst(rst), .clk(clk), .out(enable));
reg [3:0] cnt,cntNext;
always@(posedge clk) begin
  cnt<= #1 cntNext;
end

always@(*)begin
	anode=4'b0111;
	cntNext=cnt;
	if(rst)begin
		cntNext=0;
	end 
	else if(enable) begin
		if(upDown)begin
			cntNext=cnt+1;
			if(cnt==9) begin
				cntNext=0; 
			end
		end  else begin
			cntNext=cnt-1;
			if(cnt==0) begin
				cntNext=9; 
			end
	   end
		
	end
	case(cnt)
	0: sevenSegment=8'b0000_0010;//8'b1100_0000;
	1: sevenSegment=8'b1001_1110;//8'b1111_1001;
	2: sevenSegment=8'b0010_0100;//8'b1010_0100;
	3: sevenSegment=8'b0000_1100;//8'b1011_0000;
	4: sevenSegment=8'b1001_1000;//8'b1001_1001;
	5: sevenSegment=8'b0100_1000;//8'b1001_0010;
	6: sevenSegment=8'b0100_0000;//8'b1000_0010;
	7: sevenSegment=8'b0001_1110;//8'b1111_1000;
	8: sevenSegment=8'b0000_0000;//8'b1000_0000;
	9: sevenSegment=8'b0000_1000;//8'b1001_0000;
	default: sevenSegment=8'b1111_1111;
	endcase
end
endmodule
