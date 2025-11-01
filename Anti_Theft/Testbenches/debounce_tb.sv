`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/05/2025 03:59:47 PM
// Design Name: 
// Module Name: debounce_tb
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


module debounce_tb;
    logic clk, rst, noisy_in;
    logic clean_out;

    debounce uut (
        .reset_in(rst),
        .clock_in(clk),
        .noisy_in(noisy_in),
        .clean_out(clean_out)
    );

    initial clk = 0;
    always #5 clk = ~clk; // 100MHz

    always @(posedge clk)
        $display("Time: %t | CLK pulse", $time);

    initial begin
        $monitor("Time: %t | rst=%b | noisy_in=%b | clean_out=%b", $time, rst, noisy_in, clean_out);

        rst = 1; noisy_in = 0;
        #100;
        rst = 0;

        noisy_in = 1; #50;
        noisy_in = 0; #50;
        noisy_in = 1; #50;

        noisy_in = 1;
        #12_000_000;

        noisy_in = 0;
        #12_000_000;

        $finish;
    end
endmodule
