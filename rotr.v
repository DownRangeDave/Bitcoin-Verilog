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
    input [31:0] data,
    output  [31:0] outData
    );
    reg [31:0] dataCopy;
    /*
    initial begin
        dataCopy[31:32-range] = data[range-1:0];
       if(range<=31) dataCopy[31-range:0] = 0;
    end
    */
    assign outData =  (data>>range)+dataCopy; 
    
    always@(posedge clk)begin 
         dataCopy[31:32-range] <= data[range-1:0];
       if(range<=31)begin  dataCopy[31-range:0] <= 0; end
    
    end
    
endmodule
