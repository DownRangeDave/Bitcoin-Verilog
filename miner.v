`timescale 1ns / 1ps
//Add block count to reduce resources
module miner(
    input clk,
    input rst,
    input [639:0] header,
    output [255:0] computedHash
    );
    reg secondThrough;
    reg hashCount;
    wire firstDone;
    wire [255:0] outputHash;
    wire [511:0] firstChunk = hashCount ? {outputHash[255:0],1'b1,246'b0,1'b1,8'b0}:{header[639:128]};
    wire [511:0] secondChunk = {header[127:0],1'b1,373'b0,1'b1,1'b0,1'b1,7'b0};
    wire [2047:0] firstBlock;
    wire [2047:0] secondBlock;

    blockFill blockFill(clk, rst, secondThrough, hashCount, firstChunk, secondChunk, firstBlock, secondBlock);
    compression compression(clk, rst, secondThrough, hashCount, firstBlock, secondBlock, outputHash,firstDone);
    
    always@(posedge rst)begin
        hashCount<=0;
        secondThrough<=0;
    end
    always@(posedge clk)begin
        if(firstDone==1)begin
            hashCount<=1;
            secondThrough<=1;
        end
        else hashCount<=0;
    end
    
    
endmodule
