`timescale 1ns/1ps

module tb_Generic_pipeline_reg_reg;

logic clock;
logic reset;

logic [6:0] opcode;
logic [6:0] out_opcode;

logic [31:0] pc;
logic [31:0] out_pc;

logic [31:0] instruction;
logic [31:0] out_instruction;

logic [31:0] immediate;
logic [31:0] out_immediate;

logic [4:0] r1, r2, rd;
logic [4:0] out_r1, out_r2, out_rd;

logic [31:0] r2_value;
logic [31:0] out_r2_value;

logic [31:0] ALU_result;
logic [31:0] out_ALU_result;

logic memread;
logic memwrite;
logic mem_to_reg;
logic regwrite;
logic ALU_source;
logic [1:0] ALU_op;
logic branch;
logic jump;

logic out_memread;
logic out_memwrite;
logic out_mem_to_reg;
logic out_regwrite;
logic out_ALU_source;
logic [1:0] out_ALU_op;
logic out_branch;
logic out_jump;

Generic_pipeline_reg_reg DUT(
    .opcode(opcode),
    .out_opcode(out_opcode),

    .pc(pc),
    .instruction(instruction),
    .out_pc(out_pc),
    .out_instruction(out_instruction),

    .immediate(immediate),
    .out_immediate(out_immediate),

    .clock(clock),
    .reset(reset),

    .r1(r1),
    .r2(r2),
    .rd(rd),
    .out_r1(out_r1),
    .out_r2(out_r2),
    .out_rd(out_rd),

    .r2_value(r2_value),
    .out_r2_value(out_r2_value),

    .ALU_result(ALU_result),
    .out_ALU_result(out_ALU_result),

    .out_memread(out_memread),
    .out_memwrite(out_memwrite),
    .out_mem_to_reg(out_mem_to_reg),
    .out_regwrite(out_regwrite),
    .out_ALU_source(out_ALU_source),
    .out_ALU_op(out_ALU_op),
    .out_branch(out_branch),
    .out_jump(out_jump),

    .memread(memread),
    .memwrite(memwrite),
    .mem_to_reg(mem_to_reg),
    .regwrite(regwrite),
    .ALU_source(ALU_source),
    .ALU_op(ALU_op),
    .branch(branch),
    .jump(jump)
);

initial clock = 0;
always #5 clock = ~clock;

initial begin
    reset = 1;
    opcode = 0;
    pc = 0;
    instruction = 0;
    immediate = 0;
    r1 = 0;
    r2 = 0;
    rd = 0;
    r2_value = 0;
    ALU_result = 0;
    memread = 0;
    memwrite = 0;
    mem_to_reg = 0;
    regwrite = 0;
    ALU_source = 0;
    ALU_op = 0;
    branch = 0;
    jump = 0;

    #15 reset = 0;

    opcode = 7'h33;
    pc = 32'h1000_0040;
    instruction = 32'h00C585B3;
    immediate = 32'h00000010;
    r1 = 5'd5;
    r2 = 5'd6;
    rd = 5'd7;
    r2_value = 32'hAAAA5555;
    ALU_result = 32'hDEADBEEF;

    memread = 1;
    memwrite = 0;
    mem_to_reg = 1;
    regwrite = 1;
    ALU_source = 1;
    ALU_op = 2'b10;
    branch = 0;
    jump = 0;

    #20;

    opcode = 7'h03;
    pc = 32'h1000_0080;
    instruction = 32'h0005A503;
    immediate = 32'h00000020;
    r1 = 5'd8;
    r2 = 5'd9;
    rd = 5'd10;
    r2_value = 32'h12345678;
    ALU_result = 32'hCAFEBABE;

    memread = 0;
    memwrite = 1;
    mem_to_reg = 0;
    regwrite = 0;
    ALU_source = 0;
    ALU_op = 2'b01;
    branch = 1;
    jump = 0;

    #20;

    $stop;
end

endmodule
