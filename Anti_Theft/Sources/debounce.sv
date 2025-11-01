`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 08/05/2025 03:58:32 PM
// Design Name: 
// Module Name: debounce
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



`timescale 1ns / 1ps

module debounce (
    input  logic reset_in,
    input  logic clock_in,
    input  logic noisy_in,
    output logic clean_out
);
    logic [19:0] count;
    logic new_input;

    initial begin
        $display("debounce module is active at time: %t", $time);
    end

    always_ff @(posedge clock_in) begin
        if (reset_in) begin
            new_input <= noisy_in;
            clean_out <= noisy_in;
            count <= 0;
        end else if (noisy_in != new_input) begin
            new_input <= noisy_in;
            count <= 0;
        end else if (count >= 1000000) begin
            clean_out <= new_input;
            $display(">> clean_out SET at time: %t ns", $time);
        end else begin
            count <= count + 1;
            if (count % 200000 == 0)
                $display("Time: %t ns, count: %d", $time, count);
        end
    end
endmodule

