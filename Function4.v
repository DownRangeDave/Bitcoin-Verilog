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
    wire [31:0] shifted [2:0];
    rotr #(6) six (data,shifted[0]);
    rotr #(11) eleven (data,shifted[1]);
    rotr #(25) twentyfive (data,shifted[2]);
    assign outputData = (shifted[0]^shifted[1]^shifted[2]);
endmodule
