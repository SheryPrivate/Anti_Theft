`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/06/2025 09:37:35 PM
// Design Name: 
// Module Name: fuel_pump_fsm
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


module fuel_pump_fsm (
    input  logic clk,
    input  logic rst,
    input  logic ignition_on,
    input  logic hidden_switch,
    input  logic brake_pressed,
    output logic fuel_pump_on
);

    typedef enum logic [1:0] {OFF, WAIT_SECRET, ON} state_t;
    state_t state, next_state;

    // State register
    always_ff @(posedge clk or posedge rst) begin
        if (rst)
            state <= OFF;
        else
            state <= next_state;
    end

    // Next-state logic
    always_comb begin
        next_state = state;
        case (state)
            OFF:
                if (ignition_on)
                    next_state = WAIT_SECRET;
            WAIT_SECRET:
                if (hidden_switch && brake_pressed)
                    next_state = ON;
            ON:
                if (!ignition_on)
                    next_state = OFF;
        endcase
    end

    assign fuel_pump_on = (state == ON);

endmodule

