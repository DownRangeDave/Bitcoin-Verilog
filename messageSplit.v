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
#(parameter delayparam=0)
(
    input clk,
    input rst,
    input [1023:0] message,
    output  [31:0] sha
    );
    reg [31:0] holder [2**6-1:0];
    reg [31:0] secondholder [2**6-1:0];
    reg [31:0] thirdHolder [2**6-1:0];
    wire [511:0] firstBlock;
    wire [511:0] secondBlock;
    reg [511:0] thirdBlock;
    wire [31:0] alphaOutput;//used for functions 1 
    wire [31:0] betaOutput;//used for functions 2
    wire [31:0] alphaOutputblk2;//used for functions 1 
    wire [31:0] betaOutputblk2;//used for functions 2
    wire [31:0] alphaOutputblk3;//used for functions 1 
    wire [31:0] betaOutputblk3;//used for functions 2
    reg start;
    reg startCompression;
    assign firstBlock = message [1023:512];
    assign secondBlock = message[511:0];
    
    reg [31:0] workingConst [2**6-1:0];
    integer i;
    reg [5:0] A;//case
    integer delay;
    reg [31:0] firstBlockHolder;
    reg [31:0] secondBlockHolder;
    reg [31:0] thirdBlockHolder;
    reg [31:0] a;
    reg [31:0] b;
    reg [31:0] c;
    reg [31:0] d;
    reg [31:0] e;
    reg [31:0] f;
    reg [31:0] g;
    reg [31:0] h;
    reg [31:0] a2;
    reg [31:0] b2;
    reg [31:0] c2;
    reg [31:0] d2;
    reg [31:0] e2;
    reg [31:0] f2;
    reg [31:0] g2;
    reg [31:0] h2;
    reg [31:0] T1;
    reg [31:0] T2;
    reg [1:0] secondthrough;
    reg [31:0] word;
    reg [255:0] bigEndian;
    reg [255:0] littleEndian;
    integer pos;
    initial begin A=0; pos=0; word = holder[pos]; secondthrough=0;end 
    Function1 firstBlockfunc(clk,start,holder[i-15],alphaOutput);
    Function2 firstBlockfunc2(clk,start,holder[i-2],betaOutput);
    
    Function1 secondBlockfunc1(clk,start,secondholder[i-15],alphaOutputblk2);
    Function2 secondBlockfunc2(clk,start,secondholder[i-2],betaOutputblk2);
    
    Function1 thirdBlockfunc1(clk,start,thirdHolder[i-15],alphaOutputblk3);
    Function2 thirdBlockfunc2(clk,start,thirdHolder[i-2],betaOutputblk3);
    
    wire [31:0] outputFirst;
    wire [31:0] outputSecond;
    wire [31:0] outputBoth;
    TemporaryWord words(clk,startCompression,e,f,g,h,workingConst[pos],word,a,b,c,outputFirst,outputSecond,outputBoth);

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
                
		//Block Split
                1:begin //copy words from blocks into ram
                    holder[i]<=firstBlock[511-(i*32)-:32];
                    secondholder[i]<=secondBlock[511-(i*32)-:32];
                    A<=2;
                    delay<=0;
                end
                2:begin //moves i to next position 
                    if(i<15) begin 
                        A<=1;
                        i<=i+1;
                    end
                    else begin //when it becomes 15 and has done all 0-15 slots 
                        A<=3;
                        i<=i+1;
                        start<=1; //starts block functions
                    end
                
                end
		
		//Block Fill
                3:begin 
                    firstBlockHolder<=betaOutput+holder[i-7]+alphaOutput+holder[i-16];//sets place holder
                    secondBlockHolder<=betaOutputblk2+secondholder[i-7]+alphaOutputblk2+secondholder[i-16];
                    if(delay==delayparam)begin 
                        A<=4;
                        delay<=0;
                    end
                    else begin delay<=delay+1; end
                
                end
                4:begin 
                    holder[i]<=firstBlockHolder;
                    secondholder[i]<=secondBlockHolder;
                    A<=5;
                    delay<=0; 
                end 
                5:begin 
                     if(i<63) begin 
                        A<=3;
                        i<=i+1;
                    end
                    else begin //when it becomes 64 and has done all 16-64 slots 
                        A<=6;
                        start<=0;
                    end
                end
                
                6:begin //begin compression 
                    //initialize constant values and hash values
                    a <= 32'b01101010000010011110011001100111;
                    b <= 32'b10111011011001111010111010000101;
                    c <= 32'b00111100011011101111001101110010;
                    d <= 32'b10100101010011111111010100111010;
                    e <= 32'b01010001000011100101001001111111;
                    f <= 32'b10011011000001010110100010001100;
                    g <= 32'b00011111100000111101100110101011;
                    h <= 32'b01011011111000001100110100011001;
                    a2 <= 32'b01101010000010011110011001100111;
                    b2 <= 32'b10111011011001111010111010000101;
                    c2 <= 32'b00111100011011101111001101110010;
                    d2 <= 32'b10100101010011111111010100111010;
                    e2 <= 32'b01010001000011100101001001111111;
                    f2 <= 32'b10011011000001010110100010001100;
                    g2 <= 32'b00011111100000111101100110101011;
                    h2 <= 32'b01011011111000001100110100011001;
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
                    workingConst[10]<= 32'b00100100001100011000010110111110;   
                    workingConst[11]<= 32'b01010101000011000111110111000011;   
                    workingConst[12]<= 32'b01110010101111100101110101110100;   
                    workingConst[13]<= 32'b10000000110111101011000111111110; 
                    workingConst[14]<= 32'b10011011110111000000011010100111;
                    workingConst[15]<= 32'b11000001100110111111000101110100;
                    workingConst[16]<= 32'b11100100100110110110100111000001;
                    workingConst[17]<= 32'b11101111101111100100011110000110;
                    workingConst[18]<= 32'b00001111110000011001110111000110;
                    workingConst[19]<= 32'b00100100000011001010000111001100;
                    workingConst[20]<= 32'b00101101111010010010110001101111; 
                    workingConst[21]<= 32'b01001010011101001000010010101010;
                    workingConst[22]<= 32'b01011100101100001010100111011100;
                    workingConst[23]<= 32'b01110110111110011000100011011010; 
                    workingConst[24]<= 32'b10011000001111100101000101010010;
                    workingConst[25]<= 32'b10101000001100011100011001101101;
                    workingConst[26]<= 32'b10110000000000110010011111001000;
                    workingConst[27]<= 32'b10111111010110010111111111000111;
                    workingConst[28]<= 32'b11000110111000000000101111110011;
                    workingConst[29]<= 32'b11010101101001111001000101000111;
                    workingConst[30]<= 32'b00000110110010100110001101010001;
                    workingConst[31]<= 32'b00010100001010010010100101100111;
                    workingConst[32]<= 32'b00100111101101110000101010000101;
                    workingConst[33]<= 32'b00101110000110110010000100111000;
                    workingConst[34]<= 32'b01001101001011000110110111111100;
                    workingConst[35]<= 32'b01010011001110000000110100010011; 
                    workingConst[36]<= 32'b01100101000010100111001101010100;
                    workingConst[37]<= 32'b01110110011010100000101010111011;
                    workingConst[38]<= 32'b10000001110000101100100100101110; 
                    workingConst[39]<= 32'b10010010011100100010110010000101;
                    workingConst[40]<= 32'b10100010101111111110100010100001;
                    workingConst[41]<= 32'b10101000000110100110011001001011;
                    workingConst[42]<= 32'b11000010010010111000101101110000;
                    workingConst[43]<= 32'b11000111011011000101000110100011;
                    workingConst[44]<= 32'b11010001100100101110100000011001; 
                    workingConst[45]<= 32'b11010110100110010000011000100100;
                    workingConst[46]<= 32'b11110100000011100011010110000101;
                    workingConst[47]<= 32'b00010000011010101010000001110000;
                    workingConst[48]<= 32'b00011001101001001100000100010110;
                    workingConst[49]<= 32'b00011110001101110110110000001000;
                    workingConst[50]<= 32'b00100111010010000111011101001100; 
                    workingConst[51]<= 32'b00110100101100001011110010110101;
                    workingConst[52]<= 32'b00111001000111000000110010110011;
                    workingConst[53]<= 32'b01001110110110001010101001001010; 
                    workingConst[54]<= 32'b01011011100111001100101001001111;
                    workingConst[55]<= 32'b01101000001011100110111111110011;
                    workingConst[56]<= 32'b01110100100011111000001011101110;
                    workingConst[57]<= 32'b01111000101001010110001101101111;
                    workingConst[58]<= 32'b10000100110010000111100000010100;
                    workingConst[59]<= 32'b10001100110001110000001000001000;
                    workingConst[60]<= 32'b10010000101111101111111111111010;
                    workingConst[61]<= 32'b10100100010100000110110011101011;
                    workingConst[62]<= 32'b10111110111110011010001111110111;
                    workingConst[63]<= 32'b11000110011100010111100011110010;  
                    
                    i<=0;
                    startCompression<=1; 
			        pos<=0;
                    A<=7;
                    delay<=0;
                end
                7:begin //Select word from block
                    if(secondthrough==0)begin 
                        word<=holder[pos];
                    end
                    else if(secondthrough==1) begin 
                        word<=secondholder[pos];
                    end
                    else begin //secondthrough==2
                        word<=thirdHolder[pos];
                    end
                    A<=8;
                end
                8:begin //Save computed temporary words from functions
                    T1<=outputFirst;
                    T2<=outputSecond;
                    A<=9;
                end
                9:begin //Move hash values down one
                    h=g;
                    g=f;
                    f=e;
                    e=d;
                    d=c;
                    c=b;
                    b=a;
                    A<=10;
                end
                10:begin 
                    if(pos<64)begin //Compression
			            a<=T1+T2;
			            e<=e+T1;
                        pos<=pos+1;
                        if(pos!=63)begin
                            A<=7;
                        end
                    end 
                    else begin //Add final hash values to original hash values for computing second block
                        secondthrough<=secondthrough+1;
                        A<=11;
                        pos<=0;
                        a<=a+a2;
                        b<=b+b2;
                        c<=c+c2;
                        d<=d+d2;
                        e<=e+e2;
                        f<=f+f2;
                        g<=g+g2;
                        h<=h+h2;
                    end
                end
                11:begin 
                    if(secondthrough==1)begin //Copies final hash values to original hash values
                        a2<=a;
                        b2<=b;
                        c2<=c;
                        d2<=d;
                        e2<=e;
                        f2<=f;
                        g2<=g;
                        h2<=h;
                        A<=7;
                    end
                    else if(secondthrough==2) begin //populates thirdBlock
                        A<=12; 
                        thirdBlock<={a,b,c,d,e,f,g,h,1'b1,246'b0,1'b1,8'b0}; 
                        i<=0;
                    end
                    else begin //secondthrough==3
                        A<=17;
                    end
                
                end
                12:begin  //Separate thirdBlock into 32 bit words
                    thirdHolder[i]<=thirdBlock[511-(i*32)-:32];
                    A<=13;

                end
                13:begin
                    if(i<16)begin 
                        A<=12;
                        i<=i+1;
                    end 
                    else begin 
                        A<=14;
                        start<=1;
                    end 
                end

                14:begin //thirdBlock Fill
                    thirdBlockHolder<=betaOutputblk3+thirdHolder[i-7]+alphaOutputblk3+thirdHolder[i-16];
                    if(delay==delayparam)begin 
                        A<=15;
                        delay<=0;
                    end
                    else begin delay<=delay+1; end
                end
                15:begin
                    thirdHolder[i]<=thirdBlockHolder;
                    A<=16;
                end
                16:begin
                    if(i<63)begin
                        A<=14;
                        i<=i+1;
                    end
                    else begin 
                        A<=6; //Start 2nd hash compression
                        start<=0;
                    end
                end
                17:begin
                    bigEndian<={a,b,c,d,e,f,g,h};
                    A<=18;
                end
                18:begin
                    $display("%h",bigEndian);
                    littleEndian<={h[7:0],h[15:8],h[23:16],h[31:24],g[7:0],g[15:8],g[23:16],g[31:24],f[7:0],f[15:8],f[23:16],f[31:24],e[7:0],e[15:8],e[23:16],e[31:24],d[7:0],d[15:8],d[23:16],d[31:24],c[7:0],c[15:8],c[23:16],c[31:24],b[7:0],b[15:8],b[23:16],b[31:24],a[7:0],a[15:8],a[23:16],a[31:24]};
                    A<=19;
                end
                19:begin
                    $display("%h",littleEndian);
                    A<=20;
                end
            endcase 
        end   
    end
endmodule
