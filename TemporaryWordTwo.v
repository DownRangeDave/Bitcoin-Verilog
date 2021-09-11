`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/22/2021 04:21:43 PM
// Design Name: 
// Module Name: TemporaryWordTwo
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


module TemporaryWordTwo(
    input clk,
    input rst,
    input [31:0] a,
    input [31:0] b,
    input [31:0] c,
    output [31:0] outputData 
    );
    wire [31:0] func6Output;
    wire [31:0] func4Output;
    Function3 func3(clk,rst,a,func4Output);
    Function6 maj(rst,a,b,c,func6Output);
    assign outputData = func4Output+func6Output;
    
endmodule
