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
    input clk,
    input [1023:0] message,
    output [31:0] sha
    );
    reg [31:0] holder [2**4-1:0];
    wire [511:0] firstBlock;
    wire [511:0] secondBlock;
    assign firstBlock = message[1023:512];
    assign secondBlock = message [511:0];
    
    assign sha = holder[15];
    integer i;
    always@(posedge clk)begin 
        for(i=0; i<16;i=i+1)begin 
            holder[i] <= firstBlock[511-(i*32)-:32];
        end        
    
    end
endmodule
