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
    input [31:0] data,
    output [31:0] outData
    );

  assign outData[31-range:0] = data[31:range];
  assign outData[31-:range] = data[0+:range];

endmodule
