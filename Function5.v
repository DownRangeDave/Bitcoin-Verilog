`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/08/2021 11:41:12 PM
// Design Name: 
// Module Name: Function5
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


module Function5(
    input clk,
   
    input rst,
    input [31:0] independent,
    input [31:0] dependentx,
    input [31:0] dependenty,
    output reg [31:0] outputData
    );
    integer i;
    initial i=0;
    always@(posedge clk)begin
        if(~rst==1)begin 
            i<=0;
            outputData<=31'bz; 
        end
        else begin 
            for(i=0; i<=31; i=i+1)begin 
                if(independent[i]==0)begin 
                    outputData[i]<=dependenty[i];
                end
                else if(independent[i]==1)begin 
                    outputData[i]<=dependentx[i];
                end
               
            end
        end
    end
endmodule
