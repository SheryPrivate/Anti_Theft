`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/06/2025 10:49:29 PM
// Design Name: 
// Module Name: anti_theft_fsm_tb
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

module anti_theft_fsm_tb;
    reg clk, rst;
    reg ignition, driver_door, passenger_door;
    reg timer_expired, one_hz_enable;
    reg [3:0] T_ARM_DELAY, T_DRIVER_DELAY, T_PASSENGER_DELAY, T_ALARM_ON;
    wire start_timer, status_led, siren_enable;
    wire [3:0] timer_value;

    anti_theft_fsm uut (
        .clk(clk), .rst(rst),
        .ignition(ignition),
        .driver_door(driver_door),
        .passenger_door(passenger_door),
        .T_ARM_DELAY(T_ARM_DELAY),
        .T_DRIVER_DELAY(T_DRIVER_DELAY),
        .T_PASSENGER_DELAY(T_PASSENGER_DELAY),
        .T_ALARM_ON(T_ALARM_ON),
        .timer_expired(timer_expired),
        .one_hz_enable(one_hz_enable),
        .start_timer(start_timer),
        .timer_value(timer_value),
        .status_led(status_led),
        .siren_enable(siren_enable)
    );

    initial clk = 0;
    always #5 clk = ~clk;

    initial begin
        // Initialize times
        T_ARM_DELAY = 4'd6;
        T_DRIVER_DELAY = 4'd8;
        T_PASSENGER_DELAY = 4'd15;
        T_ALARM_ON = 4'd10;

        rst = 1; ignition = 0; driver_door = 0; passenger_door = 0;
        timer_expired = 0; one_hz_enable = 0;
        #20 rst = 0;

        // Simulate LED blink pulse
        forever begin
            #500_000_00 one_hz_enable = ~one_hz_enable; // toggle every 0.5s
        end
    end

    initial begin
        // Door opens
        #30 driver_door = 1; #10 driver_door = 0;
        // Timer expires
        #100 timer_expired = 1; #10 timer_expired = 0;
        // Ignition turns on
        #200 ignition = 1; #50 ignition = 0;
        #500 $finish;
    end
endmodule

