`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date:    22:17:05 04/20/2012 
// Design Name: 
// Module Name:    wrLogic 
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
module wrLogic(clk, rst, enter, sw, seg0wr, seg1wr, seg2wr, seg3wr
    );
input clk, rst, enter;
input [3:0] sw;
output reg [4:0] seg0wr, seg1wr, seg2wr, seg3wr;

reg [1:0] state, stateNext;
reg [4:0] seg0wrNext, seg1wrNext, seg2wrNext, seg3wrNext;
reg enter_r;
reg [4:0] seg0wrNext_holder, seg1wrNext_holder, seg2wrNext_holder, seg3wrNext_holder;
reg [4:0] seg0wrNext_holderNext, seg1wrNext_holderNext, seg2wrNext_holderNext, seg3wrNext_holderNext;
always@(posedge clk)begin
	state <= stateNext;
	enter_r <= enter;
	seg0wr <= seg0wrNext;
	seg1wr <= seg1wrNext;
	seg2wr <= seg2wrNext;
	seg3wr <= seg3wrNext;
	seg0wrNext_holder<=seg0wrNext_holderNext;
	seg1wrNext_holder<=seg1wrNext_holderNext;
	seg2wrNext_holder<=seg2wrNext_holderNext;
	seg3wrNext_holder<=seg3wrNext_holderNext;


end

assign posEnter = enter & ~enter_r;// Fill in here sadece pozitif edge alıcak

always@(*)begin
	stateNext=state;
	seg0wrNext=seg0wr;
	seg1wrNext=seg1wr;
	seg2wrNext=seg2wr;
	seg3wrNext=seg3wr;
	seg0wrNext_holderNext=seg0wrNext_holder;
	seg1wrNext_holderNext=seg1wrNext_holder;
	seg2wrNext_holderNext=seg2wrNext_holder;
	seg3wrNext_holderNext=seg3wrNext_holder;
	if(rst)begin
		stateNext=2'b00;
		seg0wrNext=5'b00000;
		seg1wrNext=5'b00000;
		seg2wrNext=5'b00000;
		seg3wrNext=5'b00000;
	end
	else if(posEnter) begin
		if(state==2'b00)begin
			seg0wrNext_holderNext={sw[3:0]};
			stateNext=2'b01;
		end
		if(state==2'b01)begin
			seg1wrNext_holderNext={sw[3:0]};
			stateNext=2'b10;
		end
		if(state==2'b10)begin
			seg2wrNext_holderNext={sw[3:0]};
			stateNext=2'b11;
		end
		if(state==2'b11)begin
			seg0wrNext={seg0wrNext_holder[3:0]};
			seg1wrNext={seg1wrNext_holder[3:0]};
			seg2wrNext={seg2wrNext_holder[3:0]};
			seg3wrNext={sw[3:0]};
			stateNext=0;
			
		end
	
	end
	// Fill in here also
end

endmodule
