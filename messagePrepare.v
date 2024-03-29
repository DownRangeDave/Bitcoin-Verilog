`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/09/2021 02:45:19 PM
// Design Name: 
// Module Name: hashComp
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


module messagePrepare(
    input clk,
    input [639:0] header,
    output [1023:0] outputData
    );
    integer i;
    reg[2**10-1:0] padding;
    assign outputData = padding;
    always@(posedge clk) begin
       
        padding[1023:384] <= header;
        padding[382:10]<=0; //Padding
        padding[383]<=1; //separator
        //Message Length
        padding[7] <=1;
        padding[8] <=0;
        padding[6:0]<=0; //Padding
        padding[9]<=1;
    end
endmodule
