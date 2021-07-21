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
    reg [7:0] num1;
    reg [7:0] num2;
    wire [31:0] number;
    reg test;
    initial test=1;
    rotr #(8)try (clk,test,15,number);
   
endmodule
