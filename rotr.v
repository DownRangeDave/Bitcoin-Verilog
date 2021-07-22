`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/21/2021 03:21:34 PM
// Design Name: 
// Module Name: rotr
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


module rotr
#( parameter range=4)
(
    input clk,
    input start,
    input [31:0] data,
    output  [31:0] outData
    );
    integer i;
    reg A;
    reg [31:0] dataCopy;
    initial begin 
        dataCopy[31:32-range] = data[range-1:0];
        dataCopy[31-range:0] = 'b0;
    end
    assign outData = (data>>range)+dataCopy; 
    /*
    always@(posedge clk)begin 
        if(start)begin 
            outData<= (data << range);   
            outData[range:0]<=dataCopy; 
            
            
        end
    
    end
    */
endmodule
