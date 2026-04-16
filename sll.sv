`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/22/2025 10:26:36 AM
// Design Name: 
// Module Name: sll
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


module pc_adder#(parameter ins_width=32)(
input logic [ins_width-1:0] pc,
output logic [ins_width-1:0] pc_4
    );
    
    always_comb
    begin
    pc_4=pc+32'd4;
    end
endmodule
