`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/06/2025 10:43:01 PM
// Design Name: 
// Module Name: timer_tb
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

module timer_tb;
    reg clk, rst, start;
    reg [3:0] duration;
    wire expired, one_hz_enable;

    timer uut (
        .clk(clk), .rst(rst), .start(start),
        .duration(duration),
        .expired(expired),
        .one_hz_enable(one_hz_enable)
    );

    initial clk = 0;
    always #5 clk = ~clk; // 100MHz

    initial begin
        rst = 1; start = 0; duration = 4;
        #20 rst = 0;

        // Start a 4-second countdown
        #10 start = 1;
        #10 start = 0;

        // Wait long enough to expire
        #50_000_000;

        $finish;
    end
endmodule

