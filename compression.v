`timescale 1ns / 1ps
//Speed up compression
module compression(
    input clk,
    input rst,
    input secondThrough,
    input hashCount,
    input [2047:0] firstBlock,
    input [2047:0] secondBlock,
    output reg [255:0] outputHash,
    output reg firstDone
    );
    reg [31:0] constantValues [63:0];
    reg [31:0] hashValues [7:0] [0:1];
    reg [31:0] tempWords [1:0];
    reg [63:0] func3DWords [2:0];
    reg [31:0] func3Words [2:0];
    reg [63:0] func4DWords [2:0];
    reg [31:0] func4Words [2:0];
    reg [31:0] choice;
    reg [31:0] majority [2:0];
    reg blockCount;
    integer A;
    integer i;
    
	//constantValues does not need to be reset on secondThrough
    always@(posedge rst or secondThrough)begin
        hashValues[0][0] = 32'b01101010000010011110011001100111;
        hashValues[1][0] = 32'b10111011011001111010111010000101;
        hashValues[2][0] = 32'b00111100011011101111001101110010;
        hashValues[3][0] = 32'b10100101010011111111010100111010;
        hashValues[4][0] = 32'b01010001000011100101001001111111;
        hashValues[5][0] = 32'b10011011000001010110100010001100;
        hashValues[6][0] = 32'b00011111100000111101100110101011;
        hashValues[7][0] = 32'b01011011111000001100110100011001;
        hashValues[0][1] = 32'b01101010000010011110011001100111;
        hashValues[1][1] = 32'b10111011011001111010111010000101;
        hashValues[2][1] = 32'b00111100011011101111001101110010;
        hashValues[3][1] = 32'b10100101010011111111010100111010;
        hashValues[4][1] = 32'b01010001000011100101001001111111;
        hashValues[5][1] = 32'b10011011000001010110100010001100;
        hashValues[6][1] = 32'b00011111100000111101100110101011;
        hashValues[7][1] = 32'b01011011111000001100110100011001;
        constantValues[0] <= 32'b01000010100010100010111110011000;   
        constantValues[1] <= 32'b01110001001101110100010010010001;   
        constantValues[2] <= 32'b10110101110000001111101111001111;   
        constantValues[3] <= 32'b11101001101101011101101110100101;   
        constantValues[4] <= 32'b00111001010101101100001001011011;   
        constantValues[5] <= 32'b01011001111100010001000111110001;    
        constantValues[6] <= 32'b10010010001111111000001010100100;   
        constantValues[7] <= 32'b10101011000111000101111011010101;   
        constantValues[8] <= 32'b11011000000001111010101010011000;    
        constantValues[9] <= 32'b00010010100000110101101100000001;   
        constantValues[10] <= 32'b00100100001100011000010110111110;   
        constantValues[11] <= 32'b01010101000011000111110111000011;   
        constantValues[12] <= 32'b01110010101111100101110101110100;   
        constantValues[13] <= 32'b10000000110111101011000111111110; 
        constantValues[14] <= 32'b10011011110111000000011010100111;
        constantValues[15] <= 32'b11000001100110111111000101110100;
        constantValues[16] <= 32'b11100100100110110110100111000001;
        constantValues[17] <= 32'b11101111101111100100011110000110;
        constantValues[18] <= 32'b00001111110000011001110111000110;
        constantValues[19] <= 32'b00100100000011001010000111001100;
        constantValues[20] <= 32'b00101101111010010010110001101111; 
        constantValues[21] <= 32'b01001010011101001000010010101010;
        constantValues[22] <= 32'b01011100101100001010100111011100;
        constantValues[23] <= 32'b01110110111110011000100011011010; 
        constantValues[24] <= 32'b10011000001111100101000101010010;
        constantValues[25] <= 32'b10101000001100011100011001101101;
        constantValues[26] <= 32'b10110000000000110010011111001000;
        constantValues[27] <= 32'b10111111010110010111111111000111;
        constantValues[28] <= 32'b11000110111000000000101111110011;
        constantValues[29] <= 32'b11010101101001111001000101000111;
        constantValues[30] <= 32'b00000110110010100110001101010001;
        constantValues[31] <= 32'b00010100001010010010100101100111;
        constantValues[32] <= 32'b00100111101101110000101010000101;
        constantValues[33] <= 32'b00101110000110110010000100111000;
        constantValues[34] <= 32'b01001101001011000110110111111100;
        constantValues[35] <= 32'b01010011001110000000110100010011; 
        constantValues[36] <= 32'b01100101000010100111001101010100;
        constantValues[37] <= 32'b01110110011010100000101010111011;
        constantValues[38] <= 32'b10000001110000101100100100101110; 
        constantValues[39] <= 32'b10010010011100100010110010000101;
        constantValues[40] <= 32'b10100010101111111110100010100001;
        constantValues[41] <= 32'b10101000000110100110011001001011;
        constantValues[42] <= 32'b11000010010010111000101101110000;
        constantValues[43] <= 32'b11000111011011000101000110100011;
        constantValues[44] <= 32'b11010001100100101110100000011001; 
        constantValues[45] <= 32'b11010110100110010000011000100100;
        constantValues[46] <= 32'b11110100000011100011010110000101;
        constantValues[47] <= 32'b00010000011010101010000001110000;
        constantValues[48] <= 32'b00011001101001001100000100010110;
        constantValues[49] <= 32'b00011110001101110110110000001000;
        constantValues[50] <= 32'b00100111010010000111011101001100; 
        constantValues[51] <= 32'b00110100101100001011110010110101;
        constantValues[52] <= 32'b00111001000111000000110010110011;
        constantValues[53] <= 32'b01001110110110001010101001001010; 
        constantValues[54] <= 32'b01011011100111001100101001001111;
        constantValues[55] <= 32'b01101000001011100110111111110011;
        constantValues[56] <= 32'b01110100100011111000001011101110;
        constantValues[57] <= 32'b01111000101001010110001101101111;
        constantValues[58] <= 32'b10000100110010000111100000010100;
        constantValues[59] <= 32'b10001100110001110000001000001000;
        constantValues[60] <= 32'b10010000101111101111111111111010;
        constantValues[61] <= 32'b10100100010100000110110011101011;
        constantValues[62] <= 32'b10111110111110011010001111110111;
        constantValues[63] <= 32'b11000110011100010111100011110010;
        i<=0;
        blockCount<=0;
        A<=0;
    end
    always@(posedge clk)begin
        case(A)
            0:begin
                tempWords[0]<=hashValues[7][1]+constantValues[i];
                tempWords[1]<=(hashValues[0][1]&hashValues[1][1])|(hashValues[0][1]&hashValues[2][1])|(hashValues[1][1]&hashValues[2][1]); //Majority function
                //Prep for rotate right
                func3DWords[0]<={{2'b0}, hashValues[0][1],{30{1'b0}}};
                func3DWords[1]<={{13'b0}, hashValues[0][1],{19{1'b0}}};
                func3DWords[2]<={{22'b0}, hashValues[0][1],{10{1'b0}}};
                func4DWords[0]<={{6'b0}, hashValues[4][1],{26{1'b0}}};
                func4DWords[1]<={{11'b0}, hashValues[4][1],{21{1'b0}}};
                func4DWords[2]<={{25'b0}, hashValues[4][1],{7{1'b0}}};
                //Choice function
                choice[31]<= hashValues[4][1][31] ? hashValues[5][1][31] : hashValues[6][1][31];
                choice[30]<= hashValues[4][1][30] ? hashValues[5][1][30] : hashValues[6][1][30];
                choice[29]<= hashValues[4][1][29] ? hashValues[5][1][29] : hashValues[6][1][29];
                choice[28]<= hashValues[4][1][28] ? hashValues[5][1][28] : hashValues[6][1][28];
                choice[27]<= hashValues[4][1][27] ? hashValues[5][1][27] : hashValues[6][1][27];
                choice[26]<= hashValues[4][1][26] ? hashValues[5][1][26] : hashValues[6][1][26];
                choice[25]<= hashValues[4][1][25] ? hashValues[5][1][25] : hashValues[6][1][25];
                choice[24]<= hashValues[4][1][24] ? hashValues[5][1][24] : hashValues[6][1][24];
                choice[23]<= hashValues[4][1][23] ? hashValues[5][1][23] : hashValues[6][1][23];
                choice[22]<= hashValues[4][1][22] ? hashValues[5][1][22] : hashValues[6][1][22];
                choice[21]<= hashValues[4][1][21] ? hashValues[5][1][21] : hashValues[6][1][21];
                choice[20]<= hashValues[4][1][20] ? hashValues[5][1][20] : hashValues[6][1][20];
                choice[19]<= hashValues[4][1][19] ? hashValues[5][1][19] : hashValues[6][1][19];
                choice[18]<= hashValues[4][1][18] ? hashValues[5][1][18] : hashValues[6][1][18];
                choice[17]<= hashValues[4][1][17] ? hashValues[5][1][17] : hashValues[6][1][17];
                choice[16]<= hashValues[4][1][16] ? hashValues[5][1][16] : hashValues[6][1][16];
                choice[15]<= hashValues[4][1][15] ? hashValues[5][1][15] : hashValues[6][1][15];
                choice[14]<= hashValues[4][1][14] ? hashValues[5][1][14] : hashValues[6][1][14];
                choice[13]<= hashValues[4][1][13] ? hashValues[5][1][13] : hashValues[6][1][13];
                choice[12]<= hashValues[4][1][12] ? hashValues[5][1][12] : hashValues[6][1][12];
                choice[11]<= hashValues[4][1][11] ? hashValues[5][1][11] : hashValues[6][1][11];
                choice[10]<= hashValues[4][1][10] ? hashValues[5][1][10] : hashValues[6][1][10];
                choice[9]<= hashValues[4][1][9] ? hashValues[5][1][9] : hashValues[6][1][9];
                choice[8]<= hashValues[4][1][8] ? hashValues[5][1][8] : hashValues[6][1][8];
                choice[7]<= hashValues[4][1][7] ? hashValues[5][1][7] : hashValues[6][1][7];
                choice[6]<= hashValues[4][1][6] ? hashValues[5][1][6] : hashValues[6][1][6];
                choice[5]<= hashValues[4][1][5] ? hashValues[5][1][5] : hashValues[6][1][5];
                choice[4]<= hashValues[4][1][4] ? hashValues[5][1][4] : hashValues[6][1][4];
                choice[3]<= hashValues[4][1][3] ? hashValues[5][1][3] : hashValues[6][1][3];
                choice[2]<= hashValues[4][1][2] ? hashValues[5][1][2] : hashValues[6][1][2];
                choice[1]<= hashValues[4][1][1] ? hashValues[5][1][1] : hashValues[6][1][1];
                choice[0]<= hashValues[4][1][0] ? hashValues[5][1][0] : hashValues[6][1][0];
                //Move hashValues down
                hashValues[7][1]<=hashValues[6][1];
                hashValues[6][1]<=hashValues[5][1];
                hashValues[5][1]<=hashValues[4][1];
                hashValues[4][1]<=hashValues[3][1];
                hashValues[3][1]<=hashValues[2][1];
                hashValues[2][1]<=hashValues[1][1];
                hashValues[1][1]<=hashValues[0][1];
                A<=1;
            end
            
            1:begin
                //Add back in to lower half word to complete rotate right
                func3Words[0]<=func3DWords[0][63:32]+func3DWords[0][31:0];
                func3Words[1]<=func3DWords[1][63:32]+func3DWords[1][31:0];
                func3Words[2]<=func3DWords[2][63:32]+func3DWords[2][31:0];
                func4Words[0]<=func4DWords[0][63:32]+func4DWords[0][31:0];
                func4Words[1]<=func4DWords[1][63:32]+func4DWords[1][31:0];
                func4Words[2]<=func4DWords[2][63:32]+func4DWords[2][31:0];
                
                A<=2;
            end
            2:begin
                tempWords[0]<=tempWords[0]+(func4Words[0]^func4Words[1]^func4Words[2])+choice+(blockCount ? secondBlock[(2047-(i*32))-:32] : firstBlock[(2047-(i*32))-:32]);
                tempWords[1]<=tempWords[1]+(func3Words[0]^func3Words[1]^func3Words[2]);
                
                A<=3;
            end
            3:begin
                hashValues[4][1]<=hashValues[4][1]+tempWords[0];
                hashValues[0][1]<=tempWords[0]+tempWords[1];
                
                A<=4;
            end
            4:begin
                if(i>=63) begin
                    hashValues[0][0]<=hashValues[0][0]+hashValues[0][1];
                    hashValues[1][0]<=hashValues[1][0]+hashValues[1][1];
                    hashValues[2][0]<=hashValues[2][0]+hashValues[2][1];
                    hashValues[3][0]<=hashValues[3][0]+hashValues[3][1];
                    hashValues[4][0]<=hashValues[4][0]+hashValues[4][1];
                    hashValues[5][0]<=hashValues[5][0]+hashValues[5][1];
                    hashValues[6][0]<=hashValues[6][0]+hashValues[6][1];
                    hashValues[7][0]<=hashValues[7][0]+hashValues[7][1];
                    A<=5;
                end
                else begin
                    i<=i+1;
                    A<=0;
                end
            end
            5:begin
                hashValues[0][1]<=hashValues[0][0];
                hashValues[1][1]<=hashValues[1][0];
                hashValues[2][1]<=hashValues[2][0];
                hashValues[3][1]<=hashValues[3][0];
                hashValues[4][1]<=hashValues[4][0];
                hashValues[5][1]<=hashValues[5][0];
                hashValues[6][1]<=hashValues[6][0];
                hashValues[7][1]<=hashValues[7][0];
                if(blockCount==0&hashCount==0)begin 
                    i<=0;
                    blockCount<=1;
                    A<=0;
                end
                else begin
                    if(hashCount==0)begin
                        outputHash<={hashValues[0][0],hashValues[1][0],hashValues[2][0],hashValues[3][0],hashValues[4][0],hashValues[5][0],hashValues[6][0],hashValues[7][0]};
                        firstDone<=1;
                    end
                    else outputHash<={hashValues[7][0][7:0],hashValues[7][0][15:8],hashValues[7][0][23:16],hashValues[7][0][31:24],hashValues[6][0][7:0],hashValues[6][0][15:8],hashValues[6][0][23:16],hashValues[6][0][31:24],hashValues[5][0][7:0],hashValues[5][0][15:8],hashValues[5][0][23:16],hashValues[5][0][31:24],hashValues[4][0][7:0],hashValues[4][0][15:8],hashValues[4][0][23:16],hashValues[4][0][31:24],hashValues[3][0][7:0],hashValues[3][0][15:8],hashValues[3][0][23:16],hashValues[3][0][31:24],hashValues[2][0][7:0],hashValues[2][0][15:8],hashValues[2][0][23:16],hashValues[2][0][31:24],hashValues[1][0][7:0],hashValues[1][0][15:8],hashValues[1][0][23:16],hashValues[1][0][31:24],hashValues[0][0][7:0],hashValues[0][0][15:8],hashValues[0][0][23:16],hashValues[0][0][31:24]};
                    A<=6;
                end
            end
            6:begin
                $display($time);
                $display("%h",outputHash);
                A<=7;
            end
        endcase
    end
endmodule
