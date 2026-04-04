`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/03/2025 02:03:50 PM
// Design Name: 
// Module Name: MEM_WB_register
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


module MEM_WB_register(
output logic [31:0] MEM_WB_pc,
output logic [31:0] MEM_WB_instruction,
input logic [31:0] EXEC_MEM_pc,
input logic [31:0] EXEC_MEM_instruction,
input logic clock,
input logic reset,
input logic [4:0] EX_MEM_rd,
output logic [4:0] MEM_WB_rd,

        output logic MEM_WB_memread,
        output logic MEM_WB_memwrite,
        output logic MEM_WB_mem_to_reg,
        output logic MEM_WB_regwrite,
        output logic MEM_WB_ALU_source,
        output logic [1:0 ]MEM_WB_ALU_op,
        output logic MEM_WB_branch,
        output logic MEM_WB_jump,
        
        input logic EX_MEM_memread,
        input logic EX_MEM_memwrite,
        input logic EX_MEM_mem_to_reg,
        input logic EX_MEM_regwrite,
        input logic EX_MEM_ALU_source,
        input logic [1:0 ]EX_MEM_ALU_op,
        input logic EX_MEM_branch,
        input logic EX_MEM_jump
);


always_ff @(posedge clock or posedge reset)
begin
if (reset)
begin
        MEM_WB_memread<=0;
        MEM_WB_memwrite<=0;
        MEM_WB_mem_to_reg<=0;
        MEM_WB_regwrite<=0;
        MEM_WB_ALU_source<=0;
        MEM_WB_ALU_op<=0;
        MEM_WB_branch<=0;
        MEM_WB_jump<=0; 
        MEM_WB_pc <=0;
        MEM_WB_instruction<=0;
       MEM_WB_rd<=0;
end 
else
begin     
        MEM_WB_memread<=0;
        MEM_WB_memwrite<=0;
        MEM_WB_mem_to_reg<=0;
        MEM_WB_regwrite<=0;
        MEM_WB_ALU_source<=0;
        MEM_WB_ALU_op<=0;
        MEM_WB_branch<=0;
        MEM_WB_jump<=0; 
        MEM_WB_pc <=0;
        MEM_WB_instruction<=0;
       MEM_WB_rd<=0;
end
end
endmodule
