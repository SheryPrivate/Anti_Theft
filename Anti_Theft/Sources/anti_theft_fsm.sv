`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/06/2025 09:46:03 PM
// Design Name: 
// Module Name: anti_theft_fsm
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


module anti_theft_fsm (
    input  logic       clk,
    input  logic       rst,
    input  logic       ignition,
    input  logic       driver_door,
    input  logic       passenger_door,
    input  logic [3:0] T_ARM_DELAY,
    input  logic [3:0] T_DRIVER_DELAY,
    input  logic [3:0] T_PASSENGER_DELAY,
    input  logic [3:0] T_ALARM_ON,
    input  logic       timer_expired,
    input  logic       one_hz_enable,

    output logic       start_timer,
    output logic [3:0] timer_value,
    output logic       status_led,
    output logic       siren_enable
);

    // FSM states
    typedef enum logic [3:0] {
        S_ARMED_IDLE,       // Armed, waiting
        S_ARM_DELAY,        // Waiting before armed
        S_TRIGGERED,        // Door opened, countdown to alarm
        S_SOUND_ALARM,      // Siren ON
        S_DISARMED          // Alarm off, safe state
    } state_t;

    state_t state, next_state;

    // LED blink support
    logic led_blink;
    always_ff @(posedge clk or posedge rst) begin
        if (rst)
            led_blink <= 0;
        else if (one_hz_enable)
            led_blink <= ~led_blink;
    end

    // State register
    always_ff @(posedge clk or posedge rst) begin
        if (rst)
            state <= S_ARMED_IDLE;
        else
            state <= next_state;
    end

    // Output and next-state logic
    always_comb begin
        // Default values
        next_state  = state;
        start_timer = 0;
        timer_value = 0;
        siren_enable = 0;
        status_led = 0;

        case (state)
            //---------------------------------------------------
            S_ARMED_IDLE: begin
                status_led = led_blink; // Blink when armed
                if (ignition)
                    next_state = S_DISARMED;
                else if (driver_door) begin
                    start_timer = 1;
                    timer_value = T_DRIVER_DELAY;
                    next_state = S_TRIGGERED;
                end
                else if (passenger_door) begin
                    start_timer = 1;
                    timer_value = T_PASSENGER_DELAY;
                    next_state = S_TRIGGERED;
                end
            end
            //---------------------------------------------------
            S_TRIGGERED: begin
                status_led = 1; // Solid ON during countdown
                if (ignition)
                    next_state = S_DISARMED;
                else if (timer_expired) begin
                    start_timer = 1;
                    timer_value = T_ALARM_ON;
                    next_state = S_SOUND_ALARM;
                end
            end
            //---------------------------------------------------
            S_SOUND_ALARM: begin
                status_led = 1;
                siren_enable = 1;
                if (ignition)
                    next_state = S_DISARMED;
                else if (timer_expired)
                    next_state = S_ARMED_IDLE;
            end
            //---------------------------------------------------
            S_DISARMED: begin
                status_led = 0;
                siren_enable = 0;
                if (!ignition && driver_door) begin
                    start_timer = 1;
                    timer_value = T_ARM_DELAY;
                    next_state = S_ARMED_IDLE;
                end
            end
            //---------------------------------------------------
            default: next_state = S_ARMED_IDLE;
        endcase
    end
endmodule
