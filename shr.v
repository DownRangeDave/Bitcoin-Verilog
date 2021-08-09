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


module shr
#(parameter range=4)(
    
    input [31:0] data,
    output [31:0] shiftedData
    );
    assign shiftedData =  data>>range;
 
endmodule
