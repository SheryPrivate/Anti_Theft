`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/06/2025 10:48:14 PM
// Design Name: 
// Module Name: siren_generator_tb
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


module siren_generator_tb;
    reg clk, rst, enable;
    wire speaker_out;

    siren_generator uut (
        .clk(clk), .rst(rst),
        .enable(enable),
        .speaker_out(speaker_out)
    );

    initial clk = 0;
    always #5 clk = ~clk;

    initial begin
        rst = 1; enable = 0;
        #20 rst = 0;

        // Enable siren
        #10 enable = 1;

        #200_000_000 $finish; // Run long enough to see tone change
    end
endmodule

