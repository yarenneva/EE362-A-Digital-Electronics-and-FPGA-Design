`timescale 1ns / 1ps

module pixelGeneration(switch,push, pixel_x, pixel_y, video_on, rgb,clk,rst);

input [2:0] switch;
input [3:0] push;
input [9:0] pixel_x, pixel_y;
input video_on,clk,rst;
output reg [2:0] rgb;

reg [9:0] pixelxNext, pixelyNext,pixelx,pixely; 
reg [3:0] buttonPrev;
wire [3:0] PosButton;
wire square_on;
reg [3:0] PosButtonN;

assign PosButton[0]=  buttonPrev[0] & ~ push[0];
assign PosButton[1]=  buttonPrev[1] & ~ push[1];
assign PosButton[2]=  buttonPrev[2] & ~ push[2];
assign PosButton[3]=  buttonPrev[3] & ~ push[3];

always @(posedge clk) begin
	pixelx <= #1 pixelxNext;
	pixely <= #1 pixelyNext;
	buttonPrev <= #1 push;
	PosButtonN <= #1 PosButton;
end

always @(*) begin
	rgb = 3'b000;
	pixelxNext=pixelx;
	pixelyNext=pixely;
	
	if(rst)begin
		pixelxNext=320;
		pixelyNext=220;
		rgb = 3'b000;
	end
	
	else if(video_on) begin
		if(square_on)
			rgb = switch;
		
		else
			rgb = 3'b110;
	end
	if(PosButtonN[0])begin
		pixelxNext = pixelx +12;
	end
	else if(PosButtonN[1])begin
		pixelxNext = pixelx -12;
	end
	else if(PosButtonN[2])begin
		pixelyNext = pixely +12;
	end
	else if(PosButtonN[3])begin
		pixelyNext = pixely -12;
	end
		

end

assign square_on = ((pixel_x > pixelx && pixel_x < pixelx+40) && (pixel_y > pixely && pixel_y < pixely+40));

endmodule
