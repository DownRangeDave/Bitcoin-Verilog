`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/08/2021 11:36:50 PM
// Design Name: 
// Module Name: Function4
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


module Function4(
    input [31:0] data,
    output [31:0] outputData
    );
    wire [31:0] first;
    wire [31:0] second;
    wire [31:0] third;
    rotr #(6) seven (data,first);
    rotr #(11) eighteen (data,second);
    rotr #(25) twentytwo (data,third);
    assign outputData = (first^second^third);
endmodule
