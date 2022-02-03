`timescale 1ns / 1ps

module pixelGeneration(push,clk,rst,switch, pixel_x, pixel_y, video_on, rgb);

input [1:0] push;
input clk,rst;
input [2:0] switch;
input [9:0] pixel_x, pixel_y;
input video_on;
output reg [2:0] rgb;

reg [9:0] pixelxNext, pixelyNext,pixelx,pixely; 
reg [1:0] buttonPrev;
wire [1:0] PosButton;
//reg [1:0] PosButtonPrev;

assign PosButton[0]= ~ buttonPrev[0] &  push[0];
assign PosButton[1]= ~ buttonPrev[1] &  push[1];
reg [21:0] counter, counterNext;
reg [21:0] inc, incNext;
reg  up, upNext,right, rightNext;

parameter COUNT = 22'h3FFFFF;
wire square_on;

always @(posedge clk) begin
	up <= #1 upNext;
	right <= #1 rightNext;
	pixelx <= #1 pixelxNext;
	pixely <= #1 pixelyNext;
	buttonPrev <= #1 push;
	counter <= #1 counterNext;
	inc <= #1 incNext;
	//PosButtonPrev <= #1 PosButton;
end

always @(*) begin
	counterNext=counter+1;
	rgb = 3'b000;
	pixelxNext=pixelx;
	pixelyNext=pixely;
	incNext=inc;
	upNext = up;
	rightNext =right;
	if(rst)begin
		pixelxNext=320;
		pixelyNext=220;
		rgb = 3'b000;
		incNext=1;
		counterNext=0;
	end
	else if(video_on) begin
		if(square_on)
			rgb = switch;
		else
			rgb = 3'b110;
	end
	 if(counter == COUNT -1) begin
		counterNext=0;
		if ( up==1 && right==0 )begin
			pixelyNext =  pixely+10+inc;
			pixelxNext = pixelx-10-inc;	
		end	
		if(up==0 && right==0)begin
			pixelyNext = pixely -10-inc;
			pixelxNext = pixelx-10-inc;				
		end	
		if(right == 1 && up==0 )begin
			pixelxNext = pixelx+10+inc;	
			pixelyNext =  pixely-10-inc;
		end	
		if(right==1 && up ==1)begin
			pixelxNext = pixelx+10+inc;	
			pixelyNext =  pixely+10+inc;
		end
			
	end
	if( pixelx > 580 )begin
		rightNext = 0;
	end
	else if( pixelx <60)begin
		rightNext = 1;
	end
	else if(pixely <60)begin
		upNext= 1;
	end
	if(pixely > 420)begin
		upNext = 0;
	end
	if(PosButton[0])begin
		incNext = inc + 1;
	end
	if(PosButton[1])begin
		incNext = inc - 1;
	end
end

assign square_on = ((pixel_x > pixelx && pixel_x < pixelx+40) && (pixel_y > pixely && pixel_y < pixely+40));

endmodule
