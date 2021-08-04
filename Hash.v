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
    integer i, j, k, m;
    always @ (*) begin 
        status = 0;
        //Test for invalid header
        if (header === 640'bx) begin
        $display("FAIL");
        end
        else begin
            msg[1023:384] = header[639:0];
            /*
            $display("Header         : ", "%b", header);
            $display("msg          : ", "%b", msg);
            $display("Hash Values    : ", "%b", initialHashValues);
            $display("Constant Values: ", "%b", constantValues);
            */
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
            end
            $display("block          : ", "%b", block);
            for(i=0; i<blockCount; i=i+1) begin
            end
        end
        status = 1;
        end
endmodule
