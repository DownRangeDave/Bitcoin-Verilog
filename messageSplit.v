`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/09/2021 03:09:30 PM
// Design Name: 
// Module Name: messageSplit
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


module messageSplit(
    input [1023:0] message,
    output [63:0] sha
    );
    wire [511:0] firstBlock;
    wire [511:0] secondBlock;
    assign firstBlock = message[1023:512];
    assign secondBlock = message [511:0];
endmodule
