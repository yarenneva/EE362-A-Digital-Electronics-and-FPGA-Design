`timescale 1ns / 1ps
module led(clk, rst, dataOut);

input clk, rst;
output reg [7:0] dataOut;

reg [21:0] counter, counterNext;
reg [ 7:0] dataOutNext;

reg direction;
reg directionNext;

parameter COUNT = 22'h3FFFFF; // 22'h3FFFFF; modifiy this accordingly

// registers
always @(posedge clk) begin
	counter <= #1 counterNext;
	dataOut <= #1 dataOutNext;
	direction <= #1 directionNext;
end

always @(*) begin
	counterNext = counter;
	dataOutNext = dataOut;
	directionNext=direction;
	if(rst) begin
		dataOutNext = 8'b1000_0000;
		counterNext = 0;
		directionNext=0;
	end
	else if(counter == COUNT -1 ) begin
		if(direction==0)begin
			dataOutNext = dataOut>>1;
			counterNext = 0;
		end
		else if(direction==1)begin
				dataOutNext = dataOut<<1;
				counterNext = 0;
			end
		if(dataOutNext[0]==1)begin
			directionNext=1;
		end
		else if(dataOutNext[7]==1)begin
			directionNext=0;
		end
	end
	else begin
		dataOutNext = dataOut;
		counterNext = counter +1;
		directionNext=direction;
	end
end

endmodule
