`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/22/2021 04:10:09 PM
// Design Name: 
// Module Name: TemporaryWordOne
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


module TemporaryWordOne(
    input clk,
    input rst,
    input [31:0]e,
    input [31:0]f,
    input [31:0]g,
    input [31:0]h,
    input [31:0] const,
    input [31:0]word,
    output [31:0] outputData 
    );
    wire [31:0] func5Out;
    wire [31:0] func4Out;
    Function4 rotrE(clk,rst,e,func4Out);
    Function5 choice(clk,e,f,g,func5Out);
    assign outputData = func4Out+func5Out+h+const+word;
endmodule
