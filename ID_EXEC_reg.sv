module Generic_pipeline_reg_reg #(
    parameter pc_w  = 32,
    parameter ins_w = 32,
    parameter imm_w = 32,
    parameter reg_w = 5,
    parameter alu_w = 32,
    parameter op_w  = 7
)(
    input  logic clock,
    input  logic reset,
    input  logic stall,      
    input  logic flush,      

    input  logic [op_w-1:0]  opcode,
    output logic [op_w-1:0]  out_opcode,

    input  logic [pc_w-1:0]  pc,
    input  logic [ins_w-1:0] instruction,
    output logic [pc_w-1:0]  out_pc,
    output logic [ins_w-1:0] out_instruction,

    input  logic [imm_w-1:0] immediate,
    output logic [imm_w-1:0] out_immediate,

    input  logic [reg_w-1:0] r1, r2, rd,
    output logic [reg_w-1:0] out_r1, out_r2, out_rd,

    input  logic [imm_w-1:0] r2_value,
    output logic [imm_w-1:0] out_r2_value,

    input  logic [alu_w-1:0] ALU_result,
    output logic [alu_w-1:0] out_ALU_result,

    output logic             out_memread,
    output logic             out_memwrite,
    output logic             out_mem_to_reg,
    output logic             out_regwrite,
    output logic             out_ALU_source,
    output logic [1:0]       out_ALU_op,
    output logic             out_branch,
    output logic             out_jump,

    input  logic             memread,
    input  logic             memwrite,
    input  logic             mem_to_reg,
    input  logic             regwrite,
    input  logic             ALU_source,
    input  logic [1:0]       ALU_op,
    input  logic             branch,
    input  logic             jump
);

always_ff @(posedge clock or posedge reset)
begin
    if (reset || flush) 
    begin
        out_pc           <= 0;
        out_instruction  <= 0;
        out_r1           <= 0;
        out_r2           <= 0;
        out_rd           <= 0;
        out_memread      <= 0;
        out_mem_to_reg   <= 0;
        out_regwrite     <= 0;
        out_ALU_source   <= 0;
        out_ALU_op       <= 0;
        out_branch       <= 0;
        out_jump         <= 0;
        out_immediate    <= 0;
        out_memwrite     <= 0; 
        out_ALU_result   <= 0;
        out_opcode       <= 0;
        out_r2_value     <= 0;
    end
    else if (!stall)   
    begin
        out_opcode       <= opcode;
        out_ALU_result   <= ALU_result;
        out_immediate    <= immediate;
        out_pc           <= pc;
        out_instruction  <= instruction;
        out_r1           <= r1;
        out_r2           <= r2;
        out_rd           <= rd;
        out_r2_value     <= r2_value;
        out_memread      <= memread;
        out_memwrite     <= memwrite;
        out_mem_to_reg   <= mem_to_reg;
        out_regwrite     <= regwrite;
        out_ALU_source   <= ALU_source;
        out_ALU_op       <= ALU_op;
        out_branch       <= branch;
        out_jump         <= jump;
    end
  
end

endmodule