`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/20/2021 08:38:34 PM
// Design Name: 
// Module Name: clockDivider
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


module clockDivider(
    input clk,
    output reg clkout
    );
    integer i;
    initial clkout=0;
    always@(posedge clk)begin 
        if(i==50000)begin 
            clkout<=~clkout;
            i<=0;
        end
        else begin 
            i<=i+1;
        end
    end 
endmodule
