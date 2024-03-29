`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/07/2021 09:43:10 PM
// Design Name: 
// Module Name: testDec
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module testDec();
    reg clk;
    reg rst;
    reg [639:0] header;
    wire [31:0] number;
    wire [31:0] number2;
    wire [31:0] function1;
    wire [31:0] function2;
    wire [31:0] function3;
    wire [31:0] function4;
    wire [31:0] function5;
    wire [31:0] function6;
	wire [31:0] wordone;
	wire [31:0] wordtwo;

    wire [1023:0] message;
    wire [255:0] sha;
    initial begin
        header = 640'h0100000050120119172a610421a6c3011dd330d9df07b63616c2cc1f1cd00200000000006657a9252aacd5c0b2940996ecff952228c3067cc38d4885efb5a4ac4247e9f337221b4d4c86041b00000000;
        //header =  640'h010000009500c43a25c624520b5100adf82cb9f9da72fd2447a496bc600b0000000000006cd862370395dedf1da2841ccda0fc489e3039de5f1ccddef0e834991a65600ea6c8cb4db3936a1ae3143991;

        rst=0;
        clk=0; 
        forever #10 clk=~clk;
    end
    rotr #(10)try (32'b11111111000000001111111100000000,number);
    shr #(2) shift(15,number2);
    Function1 alpha(clk,1'b1,32'b00000000000000000011111111111111,function1);
	Function2 beta(clk,1'b1,32'b00000000000000000011111111111111,function2);
	Function3 gamma(clk,1'b1,32'b00000000000000000011111111111111,function3);
    Function4 delta(clk,1'b1,32'b00000000000000000011111111111111,function4);
    Function5 epsilon(clk,32'b00000000111111110000000011111111,32'b00000000000000001111111111111111,32'b11111111111111110000000000000000,function5);
    Function6 zeta(1'b1,32'b00000000111111110000000011111111,32'b00000000000000001111111111111111,32'b11111111111111110000000000000000,function6);
	TemporaryWordOne one(clk,1'b1,32'b11111111000000001111111100000000,32'b00000000111111110000000011111111,32'b00000000000000000011111111111111,32'b00000000000000000011111111111111,32'b00000000000000000011111111111111,32'b00000000000000000011111111111111,wordone);
    TemporaryWordTwo two(clk,1'b1,32'b11111111000000001111111100000000,32'b11111111000000001111111100000000,32'b11111111000000001111111100000000,wordtwo);

    messagePrepare eta(clk,header,message);
    hashComp #(1) theta(clk,1'b1,message,sha);
endmodule
