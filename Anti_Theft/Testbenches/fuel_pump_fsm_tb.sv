`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/06/2025 10:47:01 PM
// Design Name: 
// Module Name: fuel_pump_fsm_tb
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

module fuel_pump_fsm_tb;
    reg clk, rst, ignition_on, hidden_switch, brake_pressed;
    wire fuel_pump_on;

    fuel_pump_fsm uut (
        .clk(clk), .rst(rst),
        .ignition_on(ignition_on),
        .hidden_switch(hidden_switch),
        .brake_pressed(brake_pressed),
        .fuel_pump_on(fuel_pump_on)
    );

    initial clk = 0;
    always #5 clk = ~clk;

    initial begin
        rst = 1; ignition_on = 0; hidden_switch = 0; brake_pressed = 0;
        #20 rst = 0;

        // Turn on ignition
        #20 ignition_on = 1;

        // Press secret combo
        #30 hidden_switch = 1; brake_pressed = 1;

        // Turn ignition off
        #50 ignition_on = 0;

        #100 $finish;
    end
endmodule

