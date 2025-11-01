`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/06/2025 10:19:53 PM
// Design Name: 
// Module Name: time_parameters_tb
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


`timescale 1ns/1ps
module time_parameters_tb;
    reg clk, rst, reprogram;
    reg [1:0] param_select;
    reg [3:0] time_value;
    wire [3:0] T_ARM_DELAY, T_DRIVER_DELAY, T_PASSENGER_DELAY, T_ALARM_ON;

    time_parameters uut (
        .clk(clk), .rst(rst),
        .param_select(param_select),
        .time_value(time_value),
        .reprogram(reprogram),
        .T_ARM_DELAY(T_ARM_DELAY),
        .T_DRIVER_DELAY(T_DRIVER_DELAY),
        .T_PASSENGER_DELAY(T_PASSENGER_DELAY),
        .T_ALARM_ON(T_ALARM_ON)
    );

    initial clk = 0;
    always #5 clk = ~clk; // 100MHz clock

    initial begin
        rst = 1; reprogram = 0; param_select = 0; time_value = 0;
        #20 rst = 0;

        // Change passenger delay to 5
        #10 param_select = 2'b10; time_value = 4'd5; reprogram = 1;
        #10 reprogram = 0;

        // Change alarm on time to 3
        #20 param_select = 2'b11; time_value = 4'd3; reprogram = 1;
        #10 reprogram = 0;

        #100 $finish;
    end
endmodule

