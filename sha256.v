`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/11/2021 11:30:57 PM
// Design Name: 
// Module Name: sha256
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


module sha256(
    input start,
    
    input clk,
    output reg[3:0] test
  //  output reg [255:0] line 
    );
    reg [31:0] workingConst [2**6-1:0];
    reg [31:0] readConst [2**6-1:0];
    reg read;//for ram
    reg write;
    //function reg for shr
    reg startShift;
    reg shiftBits;
    wire [31:0] dataOutput;
   
    initialHash v1(start,clk);
    shr rightShifter(startShift,workingConst[0], shiftBits, dataOutput); 
    
    initial begin 
        workingConst[0] =  32'b01000010100010100010111110011000;   
        workingConst[1] =  32'b01110001001101110100010010010001;   
        workingConst[2] =  32'b10110101110000001111101111001111;   
        workingConst[3] =  32'b11101001101101011101101110100101;   
        workingConst[4] =  32'b00111001010101101100001001011011;   
        workingConst[5] =  32'b01011001111100010001000111110001;    
        workingConst[6] =  32'b10010010001111111000001010100100;   
        workingConst[7] =  32'b10101011000111000101111011010101;   
        workingConst[8] =  32'b11011000000001111010101010011000;    
        workingConst[9] =  32'b00010010100000110101101100000001;   
        workingConst[10] = 32'b00100100001100011000010110111110;   
        workingConst[11] = 32'b01010101000011000111110111000011;   
        workingConst[12] = 32'b01110010101111100101110101110100;   
        workingConst[13] = 32'b10000000110111101011000111111110; 
        workingConst[14] = 32'b10011011110111000000011010100111;
        workingConst[15] = 32'b11000001100110111111000101110100;
        workingConst[16] = 32'b11100100100110110110100111000001;
        workingConst[17] = 32'b11101111101111100100011110000110;
        workingConst[18] = 32'b00001111110000011001110111000110;
        workingConst[19] = 32'b00100100000011001010000111001100;
        workingConst[20] = 32'b00101101111010010010110001101111; 
        workingConst[21] = 32'b01001010011101001000010010101010;
        workingConst[22] = 32'b01011100101100001010100111011100;
        workingConst[23] = 32'b01110110111110011000100011011010; 
        workingConst[24] = 32'b10011000001111100101000101010010;
        workingConst[25] = 32'b10101000001100011100011001101101;
        workingConst[26] = 32'b10110000000000110010011111001000;
        workingConst[27] = 32'b10111111010110010111111111000111;
        workingConst[28] = 32'b11000110111000000000101111110011;
        workingConst[29] = 32'b11010101101001111001000101000111;
        workingConst[30] = 32'b00000110110010100110001101010001;
        workingConst[31] = 32'b00010100001010010010100101100111;
        workingConst[32] = 32'b00100111101101110000101010000101;
        workingConst[33] = 32'b00101110000110110010000100111000;
        workingConst[34] = 32'b01001101001011000110110111111100;
        workingConst[35] = 32'b01010011001110000000110100010011; 
        workingConst[36] = 32'b01100101000010100111001101010100;
        workingConst[37] = 32'b01110110011010100000101010111011;
        workingConst[38] = 32'b10000001110000101100100100101110; 
        workingConst[39] = 32'b10010010011100100010110010000101;
        workingConst[40] = 32'b10100010101111111110100010100001;
        workingConst[41] = 32'b10101000000110100110011001001011;
        workingConst[42] = 32'b11000010010010111000101101110000;
        workingConst[43] = 32'b11000111011011000101000110100011;
        workingConst[44] = 32'b11010001100100101110100000011001; 
        workingConst[45] = 32'b11010110100110010000011000100100;
        workingConst[46] = 32'b11110100000011100011010110000101;
        workingConst[47] = 32'b00010000011010101010000001110000;
        workingConst[48] = 32'b00011001101001001100000100010110;
        workingConst[49] = 32'b00011110001101110110110000001000;
        workingConst[50] = 32'b00100111010010000111011101001100; 
        workingConst[51] = 32'b00110100101100001011110010110101;
        workingConst[52] = 32'b00111001000111000000110010110011;
        workingConst[53] = 32'b01001110110110001010101001001010; 
        workingConst[54] = 32'b01011011100111001100101001001111;
        workingConst[55] = 32'b01101000001011100110111111110011;
        workingConst[56] = 32'b01110100100011111000001011101110;
        workingConst[57] = 32'b01111000101001010110001101101111;
        workingConst[58] = 32'b10000100110010000111100000010100;
        workingConst[59] = 32'b10001100110001110000001000001000;
        workingConst[60] = 32'b10010000101111101111111111111010;
        workingConst[61] = 32'b10100100010100000110110011101011;
        workingConst[62] = 32'b10111110111110011010001111110111;
        workingConst[63] = 32'b11000110011100010111100011110010;       
    end
    
   integer i;
   reg [31:0] check;
    always@(posedge clk)begin 
        if(write)begin 
            workingConst[0] <=  32'b01000010100010100010111110011000;   
            workingConst[1] <=  32'b01110001001101110100010010010001;   
            workingConst[2] <=  32'b10110101110000001111101111001111;   
            workingConst[3] <=  32'b11101001101101011101101110100101;   
            workingConst[4] <=  32'b00111001010101101100001001011011;   
            workingConst[5] <=  32'b01011001111100010001000111110001;    
            workingConst[6] <=  32'b10010010001111111000001010100100;   
            workingConst[7] <=  32'b10101011000111000101111011010101;   
            workingConst[8] <=  32'b11011000000001111010101010011000;    
            workingConst[9] <=  32'b00010010100000110101101100000001;   
            workingConst[10] <= 32'b00100100001100011000010110111110;   
            workingConst[11] <= 32'b01010101000011000111110111000011;   
            workingConst[12] <= 32'b01110010101111100101110101110100;   
            workingConst[13] <= 32'b10000000110111101011000111111110; 
            workingConst[14] <= 32'b10011011110111000000011010100111;
            workingConst[15] <= 32'b11000001100110111111000101110100;
            workingConst[16] <= 32'b11100100100110110110100111000001;
            workingConst[17] <= 32'b11101111101111100100011110000110;
            workingConst[18] <= 32'b00001111110000011001110111000110;
            workingConst[19] <= 32'b00100100000011001010000111001100;
            workingConst[20] <= 32'b00101101111010010010110001101111; 
            workingConst[21] <= 32'b01001010011101001000010010101010;
            workingConst[22] <= 32'b01011100101100001010100111011100;
            workingConst[23] <= 32'b01110110111110011000100011011010; 
            workingConst[24] <= 32'b10011000001111100101000101010010;
            workingConst[25] <= 32'b10101000001100011100011001101101;
            workingConst[26] <= 32'b10110000000000110010011111001000;
            workingConst[27] <= 32'b10111111010110010111111111000111;
            workingConst[28] <= 32'b11000110111000000000101111110011;
            workingConst[29] <= 32'b11010101101001111001000101000111;
            workingConst[30] <= 32'b00000110110010100110001101010001;
            workingConst[31] <= 32'b00010100001010010010100101100111;
            workingConst[32] <= 32'b00100111101101110000101010000101;
            workingConst[33] <= 32'b00101110000110110010000100111000;
            workingConst[34] <= 32'b01001101001011000110110111111100;
            workingConst[35] <= 32'b01010011001110000000110100010011; 
            workingConst[36] <= 32'b01100101000010100111001101010100;
            workingConst[37] <= 32'b01110110011010100000101010111011;
            workingConst[38] <= 32'b10000001110000101100100100101110; 
            workingConst[39] <= 32'b10010010011100100010110010000101;
            workingConst[40] <= 32'b10100010101111111110100010100001;
            workingConst[41] <= 32'b10101000000110100110011001001011;
            workingConst[42] <= 32'b11000010010010111000101101110000;
            workingConst[43] <= 32'b11000111011011000101000110100011;
            workingConst[44] <= 32'b11010001100100101110100000011001; 
            workingConst[45] <= 32'b11010110100110010000011000100100;
            workingConst[46] <= 32'b11110100000011100011010110000101;
            workingConst[47] <= 32'b00010000011010101010000001110000;
            workingConst[48] <= 32'b00011001101001001100000100010110;
            workingConst[49] <= 32'b00011110001101110110110000001000;
            workingConst[50] <= 32'b00100111010010000111011101001100; 
            workingConst[51] <= 32'b00110100101100001011110010110101;
            workingConst[52] <= 32'b00111001000111000000110010110011;
            workingConst[53] <= 32'b01001110110110001010101001001010; 
            workingConst[54] <= 32'b01011011100111001100101001001111;
            workingConst[55] <= 32'b01101000001011100110111111110011;
            workingConst[56] <= 32'b01110100100011111000001011101110;
            workingConst[57] <= 32'b01111000101001010110001101101111;
            workingConst[58] <= 32'b10000100110010000111100000010100;
            workingConst[59] <= 32'b10001100110001110000001000001000;
            workingConst[60] <= 32'b10010000101111101111111111111010;
            workingConst[61] <= 32'b10100100010100000110110011101011;
            workingConst[62] <= 32'b10111110111110011010001111110111;
            workingConst[63] <= 32'b11000110011100010111100011110010;  
        
        end
        else if(read)begin 
            for(i=0; i<64; i=i+1)begin 
               test[i] = workingConst[i];
            
            
            end
        
        end
    end
endmodule
