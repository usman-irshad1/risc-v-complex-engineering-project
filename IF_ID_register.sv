`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/26/2025 02:10:06 PM
// Design Name: 
// Module Name: IF_ID_register
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


module IF_ID_register(
input logic [31:0] pc,
input logic [31:0] instruction,
output logic [31:0] IF_ID_pc,
output logic [31:0] IF_ID_instruction,
input logic clock,
input logic reset,
output logic [4:0] r1,r2,rd
);
always_ff @(posedge clock or posedge reset)
begin
if (reset)
begin
IF_ID_pc<=0;
IF_ID_instruction<=0;
end
else 
begin
IF_ID_pc<=pc;
IF_ID_instruction<=instruction;
r1<=instruction[19:15];
r2<=instruction[24:20];
rd<=instruction[11:7];
end
end
endmodule
