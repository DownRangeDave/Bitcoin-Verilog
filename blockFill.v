`timescale 1ns / 1ps

//Save bits on function shifts

module blockFill(
    input clk,
    input rst,
    input secondThrough,
    input hashCount,
    input [511:0] firstChunk,
    input [511:0] secondChunk,
    output reg [2047:0] firstBlock,
    output reg [2047:0] secondBlock
    );
    reg blockCount;
    reg [31:0] wordStore;
    reg [31:0] func1Words [1:0];
    reg [63:0] func1DWords [1:0];
    reg [31:0] func1Word3;
    reg [31:0] func2Words [1:0];
    reg [63:0] func2DWords [1:0];
    reg [31:0] func2Word3;
    integer A;
    integer i;

    always@(posedge rst or secondThrough)begin
        A<=0;
        blockCount<=0;
    end
    
    always@(posedge clk)begin
        case(A)
            0:begin
                firstBlock<={firstChunk[511:0],{1536{1'bx}}};
                secondBlock<={secondChunk[511:0],{1536{1'bx}}};
                i<=16;
                A<=1;
            end
            1:begin
				wordStore<=blockCount ? secondBlock[(2047-((i-7)*32))-:32]+secondBlock[(2047-((i-16)*32))-:32] : firstBlock[(2047-((i-7)*32))-:32]+firstBlock[(2047-((i-16)*32))-:32];
				func1Word3<=blockCount ? {secondBlock[(2047-((i-15)*32))-:32]} : {firstBlock[(2047-((i-15)*32))-:32]};
				func2Word3<=blockCount ? {secondBlock[(2047-((i-2)*32))-:32]} : {firstBlock[(2047-((i-2)*32))-:32]};

				//Prepare rotate right
				func1DWords[0]<=blockCount ? {{7'b0}, secondBlock[(2047-((i-15)*32))-:32], {25{1'b0}}} : {{7'b0}, firstBlock[(2047-((i-15)*32))-:32], {25{1'b0}}};
				func1DWords[1]<=blockCount ? {{18'b0}, secondBlock[(2047-((i-15)*32))-:32], {14{1'b0}}} : {{18'b0}, firstBlock[(2047-((i-15)*32))-:32], {14{1'b0}}};
				
				func2DWords[0]<=blockCount ? {{17'b0}, secondBlock[(2047-((i-2)*32))-:32], {15{1'b0}}} : {{17'b0}, firstBlock[(2047-((i-2)*32))-:32], {15{1'b0}}};
				func2DWords[1]<=blockCount ? {{19'b0}, secondBlock[(2047-((i-2)*32))-:32], {13{1'b0}}} : {{19'b0}, firstBlock[(2047-((i-2)*32))-:32], {13{1'b0}}};
                A<=2;
            end
            2:begin
				//Add in right half to complete rotate right
                func1Words[0]<=func1DWords[0][63:32]+func1DWords[0][31:0];
                func1Words[1]<=func1DWords[1][63:32]+func1DWords[1][31:0];
                func2Words[0]<=func2DWords[0][63:32]+func2DWords[0][31:0];
                func2Words[1]<=func2DWords[1][63:32]+func2DWords[1][31:0];
				//Shift right	
                func1Word3<=func1Word3>>3;
                func2Word3<=func2Word3>>10;
                A<=3;
            end
            3:begin
                if(blockCount==0) firstBlock[(2047-(i*32))-:32]<=wordStore+(func1Words[0]^func1Words[1]^func1Word3)+(func2Words[0]^func2Words[1]^func2Word3);
                else secondBlock[(2047-(i*32))-:32]<=wordStore+(func1Words[0]^func1Words[1]^func1Word3)+(func2Words[0]^func2Words[1]^func2Word3);
                
                if(i==64)begin
                    if(blockCount==0 & hashCount==0)begin
                        i<=16;
                        blockCount<=1;
                        A<=1;
                    end
                    else A<=4;
                end
                else begin 
                    i<=i+1;
                    A<=1;
                end
            end
            4:begin
				$monitor($time, " Block Fill finished");
				A<=5;
            end
        endcase
    end
endmodule
