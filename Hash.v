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
    reg [1023:0] block = 0;
    reg [0:1] blockCount;
    integer i, j, k, m;
    always @ (*) begin 
        status = 0;
        //Test for invalid header
        if (header === 640'bx) begin
        $display("FAIL");
        end
        else begin
            block[1023:384] = header[639:0];
            ///*
            $display("Header         : ", "%b", header);
            $display("block          : ", "%b", block);
            $display(block[384]);
            $display("Hash Values    : ", "%b", initialHashValues);
            $display("Constant Values: ", "%b", constantValues);
            //*/
            for(i=0; i<2; i=i+1) begin
                if(i==0) begin
                    block[383] = 1; //Separator
                    //Message Length
                    block[7] = 1;
                    block[9] = 1;
                    blockCount = 2;
                end
                if(i==1) begin
                    block[255] = 1; //Separator
                    block[8] = 1; //Message Length
                    blockCount = 1;
                end
            end
            $display("block          : ", "%b", block);
            for(i=0; i<blockCount; i=i+1) begin
            end
        end
        status = 1;
        end
endmodule
