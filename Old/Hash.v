`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/03/2021 08:47:19 PM
// Design Name: 
// Module Name: Hash
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


module Hash(
    input clk,
    input wire [639:0] header,
    input wire [255:0] initialHashValues,
    input wire [2047:0] constantValues,
    output wire [255:0] outdata,
    output wire status
    );
    reg stat;
    reg [255:0] oldHashValues;
    reg [255:0] hashValues;
    reg [1023:0] msg;
    reg [2047:0] block [1:0];
    reg [1:0] blockCount, i, j, add;
    reg [31:0] binaryAddition [4:0];
    reg [31:0] compressTemp [1:0];
    reg [6:0] k;
    reg [5:0] m;
    assign status = stat;
    assign outdata = hashValues;
    always @ (*) begin 
        stat = 0;
        //Test for invalid header
        if (header === 640'bx) begin
            $display("FAIL");
        end
        else begin
            msg = 0; //Clear input
            msg[1023:384] = header[639:0]; //Add header to input
            
            //SHA256 Computation
            for(i=0; i<2; i=i+1) begin
                hashValues = initialHashValues;
                oldHashValues = initialHashValues;
                if(i==0) begin
                    msg[383] = 1; //Separator
                    //Message Length
                    msg[7] = 1;
                    msg[9] = 1;
                    blockCount = 2;
                end 
                if(i==1) begin
                    msg[255] = 1; //Separator
                    msg[8] = 1; //Message Length
                    blockCount = 1;
                end
                
                //Loop by number of blocks
                for(j=0; j<blockCount; j=j+1) begin
                    block[j][2047:1536] = msg[((512*blockCount)-(512*j))-1-:512]; //Split message into blocks based on blockCount
                    //Fill rest of block
                    for(k=16; k<64; k=k+1)begin
                        binaryAddition[0] = equationCompute(0,17,19,10,block[j][(2047-(32*(k-2)))-:32]);
                        binaryAddition[1] =  block[j][2047-(32*(k-7))-:32];
                        binaryAddition[2] = equationCompute(0,7,18,3,block[j][(2047-(32*(k-15)))-:32]);
                        binaryAddition[3] =  block[j][2047-(32*(k-16))-:32];
                        block[j][2047-(32*k)-:32] = binaryAddition[0]+binaryAddition[1]+binaryAddition[2]+binaryAddition[3];
                    end
                        
                    //Creating temp words for compression
                    for(k=0; k<64; k=k+1 )begin
                        
                        //compressTemp[0]
                        binaryAddition[0] = equationCompute(1,6,11,25,hashValues[(255-(32*4))-:32]);
                        binaryAddition[2] = hashValues[(255-(32*7))-:32];
                        binaryAddition[3] = constantValues[(2047-(32*k))-:32];
                        binaryAddition[4] = block[j][(2047-(32*k))-:32];
                        //Choice operation
                        for(m=0; m<32; m=m+1)begin
                            if((hashValues[(255-(32*4)-m)-:1])==1)begin
                                binaryAddition[1][31-m] = hashValues[(255-(32*5)-m)-:1];
                            end
                            if((hashValues[(255-(32*4)-m)-:1])==0)begin
                                binaryAddition[1][31-m] = hashValues[(255-(32*6)-m)-:1];
                            end
                        end 
                        compressTemp[0] = binaryAddition[0] + binaryAddition[1] + binaryAddition[2] + binaryAddition[3] + binaryAddition[4];
                        
                        //compressTemp[1]
                        binaryAddition[0] = equationCompute(1,2,13,22,hashValues[255-:32]);
                        //Majority operation
                        for(m=0; m<32; m=m+1) begin
                            add = hashValues[(255-m)-:1] + hashValues[(255-(32*1)-m)-:1] + hashValues[(255-(32*2)-m)-:1];
                            if(add == 2 | add == 3) begin
                                binaryAddition[1][31-m] = 1;
                            end
                            else begin
                                binaryAddition[1][31-m] = 0;
                            end
                        end
                        compressTemp[1] = binaryAddition[0] + binaryAddition[1];
                        
                        //Compression
                        //Move hashValues 1 down
                        for(m=7; m>0; m=m-1) begin
                            hashValues[(255-(32*m))-:32] = hashValues[(255-(32*(m-1)))-:32];
                        end
                        //First hash value is the result of compressTemp[0] + compressTemp[1]
                        hashValues[255-:32] = compressTemp[0] + compressTemp[1];
                        //compressTemp[0] gets added to the 4th hashValue
                        hashValues[(255-(32*4))-:32] = hashValues[(255-(32*4))-:32] + compressTemp[0];
                    end
                    
                    //Add Hash Values to old Hash Values
                    for(m=0; m<8; m=m+1) begin
                        hashValues[(255-(32*m))-:32] = hashValues[(255-(32*m))-:32] + oldHashValues[(255-(32*m))-:32];
                        oldHashValues[(255-(32*m))-:32] = hashValues[(255-(32*m))-:32];
                    end
                end
               
                if(i==0) begin
                    msg = 0; //Clear msg
                    msg[511:256] = hashValues; //Add 1st computed hash to input of second hash
                end
                if(i==1) begin
                    //Convert endian
                    hashValues = {hashValues[7:0], hashValues[15:8], hashValues[23:16], hashValues[31:24], hashValues[39:32], hashValues[47:40], hashValues[55:48], hashValues[63:56], hashValues[71:64], hashValues[79:72], hashValues[87:80], hashValues[95:88], hashValues[103:96], hashValues[111:104], hashValues[119:112], hashValues[127:120], hashValues[135:128], hashValues[143:136], hashValues[151:144], hashValues[159:152], hashValues[167:160], hashValues[175:168], hashValues[183:176], hashValues[191:184], hashValues[199:192], hashValues[207:200], hashValues[215:208], hashValues[223:216], hashValues[231:224], hashValues[239:232], hashValues[247:240], hashValues[255:248]};
                    //$display("%h", hashValues);
                end
            end
        stat = 1;
        end
    end
    
    function [31:0] equationCompute;
        input computeType;
		input [5:0] shiftVal1, shiftVal2, shiftVal3;
		input [31:0] word;
		reg [31:0] data [3:0];
	    begin
		    data[0] = rightShift(shiftVal1, word);
		    data[1] = rightShift(shiftVal2, word);
		    if(computeType == 0) begin
		        data[2] = word>>shiftVal3; //Normal Shift
		    end
		    else begin
		        data[2] = rightShift(shiftVal3, word);
		    end
		    equationCompute = data[0]^data[1]^data[2]; //XOR
	    end
	endfunction
	
	function [31:0] rightShift;
	    input [5:0] shiftVal;
	    input [31:0] word;
	    reg [63:0] copy;
	    begin
		    copy = 0;
		    copy[63:32] = word;
		    copy = copy>>shiftVal;
		    rightShift = copy[63:32]+copy[31:0];
	    end
	endfunction
endmodule