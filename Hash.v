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
    input wire [639:0] header,
    input wire [255:0] initialHashValues,
    input wire [2047:0] constantValues,
    output reg status
    );
    reg [1023:0] msg = 0;
    reg [2047:0] block [1:0];
    reg [0:1] blockCount;
    reg [31:0] binaryAddition [8:0];
    integer i, j, k, m;
    always @ (*) begin 
        status = 0;
        //Test for invalid header
        if (header === 640'bx) begin
        $display("FAIL");
        end
        else begin
            msg[1023:384] = header[639:0];
            for(i=0; i<1; i=i+1) begin
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
                //Split message into blocks based on blockCount
	        for(j=0; j<blockCount; j=j+1) begin
		    block[j][2047:1536] = msg[((512*blockCount)-(512*j))-1-:512];
		    //Fill block
		    for(k=16; k<64; k=k+1)begin
			    binaryAddition[0] = equationCompute(0,17,19,10,block[j][(2047-(32*(k-2)))-:32]);
			    binaryAddition[1] =  block[j][2047-(32*(k-7))-:32];
			    binaryAddition[2] = equationCompute(0,7,18,3,block[j][(2047-(32*(k-15)))-:32]);
			    binaryAddition[3] =  block[j][2047-(32*(k-16))-:32];
			    block[j][2047-(32*k)-:32] = binaryAddition[0]+binaryAddition[1]+binaryAddition[2]+binaryAddition[3];
		    end
	        end
                $display("Block 0:", "%b", block[0]);
                $display("Block 1:", "%b", block[1]);

            end
        end
        status = 1;
        end
	function [31:0] equationCompute;
		input computeType;
		input [5:0] shiftVal1, shiftVal2, shiftVal3;
		input [31:0] word;
		reg [31:0] data [3:0];
		begin
			data[0] = rightShift(shiftVal1, word);
			data[1] = rightShift(shiftVal2, word);
			if(computeType == 0)begin
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
		reg [31:0] copy;
		begin
			copy = 0;
			case(shiftVal)
				7:begin
					copy[31:32-7] = word[7-1:0];
				end
				18:begin
					copy[31:32-18] = word[18-1:0];
				end
				17:begin
					copy[31:32-17] = word[17-1:0];
				end
				19:begin
					copy[31:32-19] = word[19-1:0];
				end
				2:begin
					copy[31:32-2] = word[2-1:0];
				end
				13:begin
					copy[31:32-13] = word[13-1:0];
				end
				22:begin
					copy[31:32-22] = word[22-1:0];
				end
				6:begin
					copy[31:32-6] = word[6-1:0];
				end
				11:begin
					copy[31:32-11] = word[11-1:0];
				end
				25:begin
					copy[31:32-25] = word[25-1:0];
				end
			endcase
			rightShift = (word>>shiftVal)+copy;
		end
	endfunction
endmodule
