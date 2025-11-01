`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/06/2025 09:38:33 PM
// Design Name: 
// Module Name: siren_generator
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


module siren_generator (
    input  logic clk,
    input  logic rst,
    input  logic enable,
    output logic speaker_out
);

    logic [23:0] tone_counter;
    logic current_tone; // 0=440Hz, 1=880Hz
    logic [15:0] tone_div;
    logic [15:0] counter;

    // Alternate tone every ~1s
    always_ff @(posedge clk or posedge rst) begin
        if (rst || !enable) begin
            tone_counter <= 0;
            current_tone <= 0;
        end
        else if (tone_counter == 25_000_000) begin
            tone_counter <= 0;
            current_tone <= ~current_tone;
        end
        else begin
            tone_counter <= tone_counter + 1;
        end
    end

    always_comb begin
        tone_div = (current_tone == 0) ? 56818 : 28409; // for 50MHz
    end

    // Tone generation
    always_ff @(posedge clk or posedge rst) begin
        if (rst || !enable) begin
            counter <= 0;
            speaker_out <= 0;
        end
        else if (counter >= tone_div) begin
            counter <= 0;
            speaker_out <= ~speaker_out;
        end
        else begin
            counter <= counter + 1;
        end
    end

endmodule

