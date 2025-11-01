`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/06/2025 09:24:38 PM
// Design Name: 
// Module Name: time_parameters
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


module time_parameters (
    input  logic       clk,
    input  logic       rst,
    input  logic [1:0] param_select,
    input  logic [3:0] time_value,
    input  logic       reprogram,
    output logic [3:0] T_ARM_DELAY,
    output logic [3:0] T_DRIVER_DELAY,
    output logic [3:0] T_PASSENGER_DELAY,
    output logic [3:0] T_ALARM_ON
);

    logic [3:0] memory [3:0];

    always_ff @(posedge clk or posedge rst) begin
        if (rst) begin
            memory[0] <= 4'd6;   // T_ARM_DELAY
            memory[1] <= 4'd8;   // T_DRIVER_DELAY
            memory[2] <= 4'd15;  // T_PASSENGER_DELAY
            memory[3] <= 4'd10;  // T_ALARM_ON
        end
        else if (reprogram) begin
            memory[param_select] <= time_value;
        end
    end

    assign T_ARM_DELAY        = memory[0];
    assign T_DRIVER_DELAY     = memory[1];
    assign T_PASSENGER_DELAY  = memory[2];
    assign T_ALARM_ON         = memory[3];

endmodule

