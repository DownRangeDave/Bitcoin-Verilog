`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/09/2021 03:09:30 PM
// Design Name: 
// Module Name: messageSplit
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


module messageSplit
#(parameter delayparam=15)
(
    input clk,
    input rst,
    input [1023:0] message,
    output  [31:0] sha
    );
    reg [31:0] holder [2**6-1:0];
    reg [31:0] secondholder [2**6-1:0];
    wire [511:0] firstBlock;
    wire [511:0] secondBlock;
    wire [31:0] alphaOutput;//used for functions 1 
    wire [31:0] betaOutput;//used for functions 2
     wire [31:0] alphaOutputblk2;//used for functions 1 
    wire [31:0] betaOutputblk2;//used for functions 2
    reg start;
    assign firstBlock = message[1023:512];
    assign secondBlock = message [511:0];
    
    assign sha = holder[15];
    integer i;
    reg [3:0] A;
    integer delay;
    reg [31:0] firstBlockHolder;
    reg [31:0] secondBlockHolder;
    initial begin A=0;end 
     Function1 firstBlockfunc(clk,start,holder[i-15],alphaOutput);
     Function2 firstBlockfunc2(clk,start,holder[i-2],betaOutput);
     
     Function1 secondBlockfunc1(clk,start,holder[i-15],alphaOutputblk2);
     Function2 secondBlockfunc2(clk,start,holder[i-2],betaOutputblk2);
     
    always@(posedge clk)begin
        if(~rst==1)begin A<=0; start <=0;end
        else begin 
            case(A)
                0:begin
                    delay<=0;
                    firstBlockHolder<=32'bz;
                    secondBlockHolder<=32'bz; 
                    i<=0;
                    start<=0;
                    A<=1;
                end 
                1: begin 
                    //start of making the first 16 words in  both blocks 
                    firstBlockHolder<=firstBlock[511-(i*32)-:32]; //sets place holder
                    secondBlockHolder<=secondBlock[511-(i*32)-:32];
                    /*
                    for(i=0; i<16;i=i+1)begin 
                        holder[i] <= firstBlock[511-(i*32)-:32];
                       
                        secondholder[i] <= secondBlock[511-(i*32)-:32];
                    end
                    */
                    //terrible idea but it should work 
                    if(delay==delayparam)begin 
                        A<=2;
                        delay<=0;
                    end
                   else begin delay<=delay+1; end
                        
                end
                2:begin //assigns holderblocks to ram
                    holder[i]<=firstBlockHolder;
                    secondholder[i]<=secondBlockHolder;
                    if(delay==delayparam)begin
                        $display("State: %d w%d %b\n",A,i,holder[i]); 
                        A<=3;
                        delay<=0;
                    end
                   else begin delay<=delay+1; end
                
                end
                3:begin //moves i to next position 
                    if(i<15) begin 
                        A<=1;
                        i<=i+1;
                    end
                    else begin //when it becomes 15 and has done all 0-15 slots 
                        A<=4;
                        i<=i+1;
                        start<=1;
                    end
                
                end
                4:begin 
                    firstBlockHolder<=betaOutput+holder[i-7]+alphaOutput+holder[i-16];//sets place holder
                    secondBlockHolder<=betaOutputblk2+secondholder[i-7]+alphaOutputblk2+secondholder[i-16];
                    if(delay==delayparam)begin 
                        A<=5;
                        delay<=0;
                    end
                    else begin delay<=delay+1; end
                
                end
                5:begin 
                    holder[i]<=firstBlockHolder;
                    secondholder[i]<=secondBlockHolder;
                    if(delay==delayparam)begin 
                        A<=6;
                        delay<=0;
                        $display("State: %d w%d %b\n",A,i,holder[i]);
                    end
                    else begin delay<=delay+1; end
                end 
                6:begin 
                     if(i<63) begin 
                        A<=4;
                        i<=i+1;
                    end
                    else begin //when it becomes 15 and has done all 0-15 slots 
                        A<=7;
                       // i<=i+1;
                        start<=0;
                    end
                
                
                end
                
                7:begin 
                
                
                end
                
                
                
                
                
                
                /*
                
                
                //////////////////////////////////////////////////////////
                2:begin 
                   i<=i+1;
                   if(i==16)begin A<=3; start<=1; end
                end
                3:begin //where the fun begins
                    for(i=i; i<64; i=i+1)begin
                        holder[i]<= betaOutput+holder[i-7]+alphaOutput+holder[i-16];
                        $display("State: %d, w%d %b\n",A,i,holder[i]);
                        secondholder[i]<= betaOutputblk2+secondholder[i-7]+alphaOutputblk2+secondholder[i-16];  
                    end
                    if(i==63) A<=4;
                    else A<=3;
                end
                4:begin 
                
                end
                */
            endcase 
        end 
          
    end
endmodule
