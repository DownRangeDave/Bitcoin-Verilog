`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/08/2021 11:17:59 PM
// Design Name: 
// Module Name: Function1
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


module Function1(
    input [31:0] data,
    output [31:0] outputData
    );
    wire [31:0] first;
    wire [31:0] second;
    wire [31:0] third;
    rotr #(7) seven (data,first);
    rotr #(18) eighteen (data,second);
    shr #(3) three (data,third);
    assign outputData = (first^second^third);
endmodule
