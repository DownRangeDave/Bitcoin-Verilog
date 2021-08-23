`timescale 1ns / 1ps
module TemporaryWord(
       input clk,
       input start,
       input [31:0] e,
       input [31:0] f,
       input [31:0] g,
       input [31:0] h,
       input [31:0] const,
       input [31:0] word,
       input [31:0] a,
       input [31:0] b,
       input [31:0] c,
       output [31:0] outputFirst,
       output [31:0] outputSecond,
       output [31:0] outputBoth
    );
        TemporaryWordOne first(clk,start,e,f,g,h,const,word,outputFirst);
        TemporaryWordTwo second(clk,start,a,b,c,outputSecond);
        assign outputBoth = outputFirst+outputSecond;
endmodule 