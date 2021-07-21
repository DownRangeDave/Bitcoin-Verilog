`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/12/2021 12:08:43 AM
// Design Name: 
// Module Name: initialHash
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


module initialHash(
    input start,
    input clk
    );
    integer i;
    integer j;
    reg [7:0] ram [2**5-1:0];
    reg [31:0] test;
    initial begin 
        ram[0] = 32'b01101010000010011110011001100111;
        ram[1] = 32'b10111011011001111010111010000101;
        ram[2] = 32'b00111100011011101111001101110010;
        ram[3] = 32'b10100101010011111111010100111010;
        ram[4] = 32'b01010001000011100101001001111111;
        ram[5] = 32'b10011011000001010110100010001100;
        ram[6] = 32'b00011111100000111101100110101011;
        ram[7] = 32'b01011011111000001100110100011001;
    end

    always@(posedge clk)begin 
        for(i=0; i<8; i=i+1)begin 
            for(j=0; j<32; j=j+1)begin 
                if(ram[i][j] == 1) begin 
                    test=test+1;
                end 
            
            
            end
        
        end
    
    end
endmodule
