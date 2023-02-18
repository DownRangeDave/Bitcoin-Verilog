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
    input clk,
    input start,
    input [31:0] data,
    output [31:0] outputData
    );
    wire [31:0] shifted [2:0];
    rotr #(2) two (data,shifted[0]);
    rotr #(13) thirteen (data,shifted[1]);
    rotr #(22) twentytwo (data,shifted[2]);
    assign outputData = (start==1) ? (shifted[0]^shifted[1]^shifted[2]):32'bz;
endmodule
