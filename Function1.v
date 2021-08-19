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
    input clk,
    input [31:0] data,
    output [31:0] outputData
    );
    wire [31:0] shifted [2:0];
   
    rotr #(7) seven (clk,data,shifted[0]);
    rotr #(18) eighteen (clk,data,shifted[1]);
    shr #(3) three (data,shifted[2]);
    assign outputData = (shifted[0]^shifted[1]^shifted[2]);
endmodule
