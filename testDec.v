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
    reg realClk;
    reg rst;
  //  reg [31:0] num1;
    //reg [31:0] num2;
    reg [639:0] hashCompNum;
    reg [1023:0] messageNum;
    wire [31:0] number;
    wire [31:0] number2;
    wire [31:0] function1;
    wire [31:0] function2;
    wire [31:0] function3;
    wire [31:0] function4;
    wire [31:0] function5;
    wire [31:0] function6;
    wire [1023:0] hashComp;
    wire [31:0] messageSplit;
    initial begin
        //hashCompNum = 640'h0100000050120119172a610421a6c3011dd330d9df07b63616c2cc1f1cd00200000000006657a9252aacd5c0b2940996ecff952228c3067cc38d4885efb5a4ac4247e9f337221b4d4c86041b00000000;
        realClk=0;
        hashCompNum = 640'b1;
        messageNum = 1024'h0100000050120119172a610421a6c3011dd330d9df07b63616c2cc1f1cd00200000000006657a9252aacd5c0b2940996ecff952228c3067cc38d4885efb5a4ac4247e9f337221b4d4c86041b00000000;
        rst=0;
        clk=0; 
        forever #10 clk=~clk;
    end
    //clockDivider clock(realClk,clk);
    rotr #(16)try (clk,32'b11111111000000001111111100000000,number);
    shr #(2) shift(15,number2);
    Function1 alpha(clk,1'b1,32'b00000000000000000011111111111111,function1);
   Function2 beta(clk,1'b1,32'b00000000000000000011111111111111,function2);
   Function3 gamma(clk,1'b1,32'b00000000000000000011111111111111,function3);
    Function4 delta(clk,1'b1,32'b00000000000000000011111111111111,function4);
    Function5 epsilon(clk,1'b1,32'b00000000111111110000000011111111,32'b00000000000000001111111111111111,32'b11111111111111110000000000000000,function5);
    Function6 zeta(1'b1,32'b00000000111111110000000011111111,32'b00000000000000001111111111111111,32'b11111111111111110000000000000000,function6);
    hashComp eta(clk,messageNum,hashComp);
    messageSplit #(1) theta(clk,1,hashComp,messageSplit);
endmodule
