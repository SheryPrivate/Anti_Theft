`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/06/2025 09:36:26 PM
// Design Name: 
// Module Name: timer
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


module timer (
    input  logic       clk,
    input  logic       rst,
    input  logic       start,
    input  logic [3:0] duration,       // in seconds
    output logic       expired,
    output logic       one_hz_enable
);

    logic [24:0] clk_count;
    logic [3:0]  sec_count;

    // Generate 1Hz pulse
    always_ff @(posedge clk or posedge rst) begin
        if (rst || start)
            clk_count <= 0;
        else if (clk_count == 25_000_000 - 1)
            clk_count <= 0;
        else
            clk_count <= clk_count + 1;
    end

    assign one_hz_enable = (clk_count == 25_000_000 - 1);

    // Countdown logic
    always_ff @(posedge clk or posedge rst) begin
        if (rst) begin
            sec_count <= 0;
            expired <= 0;
        end
        else if (start) begin
            sec_count <= duration;
            expired <= 0;
        end
        else if (one_hz_enable && sec_count > 0) begin
            sec_count <= sec_count - 1;
            if (sec_count == 1)
                expired <= 1;
        end
    end

endmodule

