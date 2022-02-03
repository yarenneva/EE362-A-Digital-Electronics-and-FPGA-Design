`timescale 1ns / 1ps

module SevenSegFourDig(in,clk,sevenSeg,anode,rst);

input [15:0] in;
input clk,rst;
output reg [7:0] sevenSeg;
output reg[3:0] anode;

reg [15:0] counter, counterNext;
reg [3:0] refIn;
//reg [3:0] anodeNext;
//parameter COUNT = 16'hFFFF; 

//assign in= refIn; 

always @(posedge clk) begin
	counter <= #1 counterNext+1;
	//refIn <= #1 refInNext;

end

always @(*) begin
	counterNext = counter+1;
	//refInNext=refIn;
	//sevenSeg = 8'b00000010;
	if(rst)begin
		counterNext=0;
		anode=4'b0000;
		sevenSeg = 8'b00000010;
	end
	
	
	if(counter[15:14]==2'b00)begin
		anode=4'b0111;
		refIn = in[15:12];
	end
	else if(counter[15:14]==2'b01)begin
		anode=4'b1011;
		refIn = in[11:8];
	end
	else if(counter[15:14]==2'b10)begin
		anode=4'b1101;
		refIn = in[7:4];
		
	end
	else if(counter[15:14]==2'b11)begin
		anode=4'b1110;
		refIn = in[3:0];
		
	end
		
		
	case(refIn[3:0])
		0: sevenSeg = 8'b00000010;  //0
		1: sevenSeg = 8'b10011110;  //1
		2: sevenSeg = 8'b00100100;  //2
		3: sevenSeg = 8'b00001100;  //3
		4: sevenSeg = 8'b10011000;  //4
		5: sevenSeg = 8'b01001000;  //5
		6: sevenSeg = 8'b01000000;  //6
		7: sevenSeg = 8'b00011110;  //7
		8: sevenSeg = 8'b00000000;  //8
		9: sevenSeg = 8'b00001000;  //9
		10: sevenSeg = 8'b00010000; //A
		11: sevenSeg = 8'b11000000; //b
		12: sevenSeg = 8'b01100010; //C
		13: sevenSeg = 8'b10000100; //d
		14: sevenSeg = 8'b01100000; //e
		15: sevenSeg = 8'b01110000; //f
	endcase

	
end

endmodule
