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
    reg [7:0] num1;
    reg [7:0] num2;
    wire [31:0] number;
    wire [31:0] number2;
    wire [31:0] function1;
    wire [31:0] function2;
    wire [31:0] function3;
    wire [31:0] function4;
    wire [31:0] function5;
    wire [31:0] function6;
    initial begin
        rst=0;
        clk=0; 
        forever #10 clk=~clk;
    end
    rotr #(32)try (32'b11111111000000001111111100000000,number);
    shr #(2) shift(15,number2);
    Function1 alpha(32'b00000000000000000011111111111111,function1);
    Function2 beta(32'b00000000000000000011111111111111,function2);
    Function3 gamma(32'b00000000000000000011111111111111,function3);
    Function4 delta(32'b00000000000000000011111111111111,function4);
    Function5 epsilon(clk,rst,32'b00000000111111110000000011111111,32'b00000000000000001111111111111111,32'b11111111111111110000000000000000,function5);
    Function6 zeta(32'b00000000111111110000000011111111,32'b00000000000000001111111111111111,32'b11111111111111110000000000000000,function6);
endmodule
