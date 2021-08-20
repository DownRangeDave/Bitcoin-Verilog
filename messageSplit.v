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


module messageSplit(
    input clk,
    input rst,
    input [1023:0] message,
    output [31:0] sha
    );
    reg [31:0] holder [2**6-1:0];
    reg [31:0] secondholder [2**6-1:0];
    wire [511:0] firstBlock;
    wire [511:0] secondBlock;
    wire [31:0] otherFunction;
    assign firstBlock = message[1023:512];
    assign secondBlock = message [511:0];
    
    assign sha = holder[15];
    integer i;
    reg [3:0] A;
    initial begin A=0;end 
     genvar b;
    always@(posedge clk)begin
        if(~rst)begin A<=0;end
        else begin 
            case(A) 
                0: begin 
                    for(i=0; i<16;i=i+1)begin 
                        holder[i] <= firstBlock[511-(i*32)-:32];
                        secondholder[i] <= secondBlock[511-(i*32)-:32];
                    end
                    if(i==15)begin 
                        A<=1;
                    end
                    else A<=0;      
                end
                1:begin 
                  
                
                end
            endcase 
        end 
          
    end
endmodule
