`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/25/2021 08:16:05 PM
// Design Name: 
// Module Name: Main
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


module Main(
    input clk,
    input rst,
    output [1:0] outputfinal
   
    );
    wire [1023:0] outputData;
    wire [649:0] message;
    wire [31:0] endd;
    assign message = 640'h0100000050120119172a610421a6c3011dd330d9df07b63616c2cc1f1cd00200000000006657a9252aacd5c0b2940996ecff952228c3067cc38d4885efb5a4ac4247e9f337221b4d4c86041b00000000;
    assign outputfinal = 1;
    hashComp comp(clk,message,outputData);
    messageSplit split(clk,rst,outputData,endd);
endmodule
