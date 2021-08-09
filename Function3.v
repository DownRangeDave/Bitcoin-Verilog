`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/08/2021 11:32:31 PM
// Design Name: 
// Module Name: Function3
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


module Function3(
    input [31:0] data,
    output [31:0] outputData
    );
    wire [31:0] first;
    wire [31:0] second;
    wire [31:0] third;
    rotr #(2) seven (data,first);
    rotr #(13) eighteen (data,second);
    rotr #(22) twentytwo (data,third);
    assign outputData = (first^second^third);
endmodule
