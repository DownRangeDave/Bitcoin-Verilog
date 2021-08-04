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
    reg [1023:0] block;
    always @ (*) begin 
        status = 0;
        block = header;
        //Test for invalid header
        if (header === 640'bx) begin
        $display("FAIL");
        end
        else begin
            $display("Header         : ", "%h", header);
            $display("Block          : ", "%b", block);
            $display("Hash Values    : ", "%b", initialHashValues);
            $display("Constant Values: ", "%b", constantValues);
        end
        status = 1;
        end
endmodule
