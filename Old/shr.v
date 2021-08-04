`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/21/2021 01:31:53 PM
// Design Name: 
// Module Name: shr
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


module shr(
    input start,
    input [5:0] rightShift,
    input [31:0] data,
    output [31:0] shiftedData
    );
    integer i;
    assign shiftedData = (start==1) ? data<<rightShift : 0;
 
endmodule
