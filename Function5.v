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
   
    input [31:0] independent,
    input [31:0] dependentx,
    input [31:0] dependenty,
    output [31:0] outputData
    );
    assign outputData[31] = independent[31] ? dependentx[31] : dependenty[31];
    assign outputData[30] = independent[30] ? dependentx[30] : dependenty[30];
    assign outputData[29] = independent[29] ? dependentx[29] : dependenty[29];
    assign outputData[28] = independent[28] ? dependentx[28] : dependenty[28];
    assign outputData[27] = independent[27] ? dependentx[27] : dependenty[27];
    assign outputData[26] = independent[26] ? dependentx[26] : dependenty[26];
    assign outputData[25] = independent[25] ? dependentx[25] : dependenty[25];
    assign outputData[24] = independent[24] ? dependentx[24] : dependenty[24];
    assign outputData[23] = independent[23] ? dependentx[23] : dependenty[23];
    assign outputData[22] = independent[22] ? dependentx[22] : dependenty[22];
    assign outputData[21] = independent[21] ? dependentx[21] : dependenty[21];
    assign outputData[20] = independent[20] ? dependentx[20] : dependenty[20];
    assign outputData[19] = independent[19] ? dependentx[19] : dependenty[19];
    assign outputData[18] = independent[18] ? dependentx[18] : dependenty[18];
    assign outputData[17] = independent[17] ? dependentx[17] : dependenty[17];
    assign outputData[16] = independent[16] ? dependentx[16] : dependenty[16];
    assign outputData[15] = independent[15] ? dependentx[15] : dependenty[15];
    assign outputData[14] = independent[14] ? dependentx[14] : dependenty[14];
    assign outputData[13] = independent[13] ? dependentx[13] : dependenty[13];
    assign outputData[12] = independent[12] ? dependentx[12] : dependenty[12];
    assign outputData[11] = independent[11] ? dependentx[11] : dependenty[11];
    assign outputData[10] = independent[10] ? dependentx[10] : dependenty[10];
    assign outputData[9] = independent[9] ? dependentx[9] : dependenty[9];
    assign outputData[8] = independent[8] ? dependentx[8] : dependenty[8];
    assign outputData[7] = independent[7] ? dependentx[7] : dependenty[7];
    assign outputData[6] = independent[6] ? dependentx[6] : dependenty[6];
    assign outputData[5] = independent[5] ? dependentx[5] : dependenty[5];
    assign outputData[4] = independent[4] ? dependentx[4] : dependenty[4];
    assign outputData[3] = independent[3] ? dependentx[3] : dependenty[3];
    assign outputData[2] = independent[2] ? dependentx[2] : dependenty[2];
    assign outputData[1] = independent[1] ? dependentx[1] : dependenty[1];
    assign outputData[0] = independent[0] ? dependentx[0] : dependenty[0];
endmodule
