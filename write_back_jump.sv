`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11/09/2025 06:42:43 PM
// Design Name: 
// Module Name: write_back_jump
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


module write_back_jump(
input logic jump,
input logic [4:0] rd,
output logic [4:0]  ra 
    );
   logic [4:0] jump_register=5'b00001; 
 always_comb
 begin
 
 if (jump==1)
 begin
 ra=jump_register;
 end
 else
 begin
 ra=rd;
 end
 end
endmodule
