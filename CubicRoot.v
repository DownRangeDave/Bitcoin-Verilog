`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/07/2021 09:34:55 PM
// Design Name: 
// Module Name: CubicRoot
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


module CubicRoot(
    input clk,
    input [7:0] dividen,
    input [7:0] quotient,
    output reg [7:0] divisor
    );
    reg [7:0] test;
    always@(posedge clk)begin 
        divisor<=quotient/dividen;
    end
endmodule
