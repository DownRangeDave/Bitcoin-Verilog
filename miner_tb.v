`timescale 1ns / 1ps
module miner_tb;
	reg clk;
	reg [639:0] header;
	reg rst;
	reg start;
	wire [255:0] outputHash;
	miner mine(clk, rst,header,outputHash);
	
	initial begin
		start<=0;
		$dumpfile("run2.vcd");
		$dumpvars(0,miner_tb);
		clk<=0;
		forever #10 clk=~clk;
		
	end
	always@(posedge clk)begin
		
		if(start!=1)begin
			rst<=1;
			header <= 640'h0100000050120119172a610421a6c3011dd330d9df07b63616c2cc1f1cd00200000000006657a9252aacd5c0b2940996ecff952228c3067cc38d4885efb5a4ac4247e9f337221b4d4c86041b00000000; //5bd0d617b30a972407ad69a845cd74fb201d940cd45acc15fcd4761493bc3ae2
			start<=1;
		end
		else begin
			rst<=0;
		end
	end
endmodule
