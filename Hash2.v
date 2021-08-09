`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/08/2021 01:08:43 PM
// Design Name: 
// Module Name: Hash2
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


module Hash2(
    input [639:0] header,
    input [255:0] hashValues,
    input [2047:0] constantValues,
    output [255:0] finalHash
    );
    reg hashCount;
    reg blockCount;
    wire [2047:0] currentBlock;
    wire [2047:0] currentBlockPopulated;
    wire [2047:0] block1;
    wire [2047:0] block2;
    assign currentBlock = (blockCount) ? block2 : block1;
    initial begin
        hashCount = 0;
        blockCount = 0;
    end
    blockSplitter split(hashCount, header, block1, block2);
    blockPopulate pop(currentBlock, currentBlockPopulated);
    
endmodule
