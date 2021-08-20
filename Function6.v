`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/09/2021 12:00:18 AM
// Design Name: 
// Module Name: Function6
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


module Function6(
    input start,
    input [31:0] x,
    input [31:0] y,
    input [31:0] z,
    output [31:0] outputData
    );
    wire [31:0] xy;
    wire [31:0] xz;
    wire [31:0] yz;
    assign xy=x&y;
    assign xz=x&z;
    assign yz=y&z;
    assign outputData = (start==1) ? xy|xz|yz:31'bz;
endmodule
