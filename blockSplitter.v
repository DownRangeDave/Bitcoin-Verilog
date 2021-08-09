`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/08/2021 04:37:08 PM
// Design Name: 
// Module Name: blockSplitter
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

/*
Save header(640 bits) into msg(1024 bits)
Add separator and message length bits to msg based on "hashCount"
Save block(s) to outputs
*/

module blockSplitter(
    input hashCount,
    input [639:0] header,
    output reg [2047:0] block1,
    output reg [2047:0] block2
    );
    reg [1023:0] msg;
    always @ (*) begin
        msg = 0;
        block1 = 0;
        block2 = 0;
        if(hashCount == 0) begin
            //Fill message
            msg[1023:384] = header[639:0];
            msg[383] = 1; //Separator
            //Message Length
            msg[7] = 1;
            msg[9] = 1;
            //Fill blocks
            block1[2047:1536] = msg[1023-:512];
            block2[2047:1536] = msg[511-:512];
        end
        if(hashCount == 1) begin //May change after finishing first hash
            //Fill Message
            msg[511:256] = header[639-:256];
            msg[255] = 1; //Separator
            msg[8] = 1; //Message Length
            //Fill blocks
            block1[2047:1536] = msg[511-:512];
        end
    end
endmodule
