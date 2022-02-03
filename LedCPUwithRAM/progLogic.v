`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    00:46:53 12/02/2021 
// Design Name: 
// Module Name:    progLogic 
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
module progLogic(clk,rst,switch,enter,dataWr,addrWr,wrEn);

input clk,rst,enter;
input [7:0] switch;
output reg [15:0] dataWr;
output reg [7:0] addrWr;
output reg wrEn;

reg wrEnNext;
reg [7:0] addrWrNext;
reg [15:0] dataWrNext;
reg count,countNext;

reg enterPrev;
wire PosButton;
assign PosButton= enterPrev & ~ enter;

	
always @(posedge clk)begin
	enterPrev <= #1 enter;
	wrEn <= #1 wrEnNext;
	dataWr <= #1 dataWrNext;
	addrWr <= #1 addrWrNext;
	count <= #1 countNext;
end

always @(*)begin
	addrWrNext=addrWr;
	dataWrNext=dataWr;
	wrEnNext=wrEn;
	countNext=count;
	if(rst)begin
		wrEnNext=0;
		addrWrNext=0;
		dataWrNext=0;
		countNext=0;
	end
	else if(PosButton) begin
		if(count==0)begin
			dataWrNext[15:8]=switch; 
			addrWrNext=addrWr;
			countNext=count+1;
		end
		else if(count==1)begin
			dataWrNext[7:0]=switch; 
			addrWrNext=addrWr;
			wrEnNext=1;
			//countNext=0;
		end
	end
	
	else if(wrEn)begin
		addrWrNext=addrWr+1;
		wrEnNext=0;
		countNext=0;
	end

end

endmodule
