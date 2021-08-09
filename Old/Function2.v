`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/08/2021 11:28:07 PM
// Design Name: 
// Module Name: Function2
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


module Function2(
    input [31:0] data,
    output [31:0] outputData
    );
    wire [31:0] first;
    wire [31:0] second;
    wire [31:0] third;
    rotr #(17) seven (data,first);
    rotr #(19) eighteen (data,second);
    shr #(10) three (data,third);
    assign outputData = (first^second^third);
endmodule
