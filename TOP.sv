`timescale 1ns / 1ps

module top(
    input  logic        clock,
    input  logic        reset,
    output logic [31:0] pc, 
    output logic [4:0]  r1,
    output logic [4:0]  r2,
    output logic [4:0]  rd,
    output logic [31:0] ins,
    output logic [31:0] data1,
    output logic [31:0] data2,
    output logic [31:0] immediate_32,
    output logic [6:0]  opcode,
    output logic [2:0]  fun11,
    output logic [6:0]  fun21,
    output logic [31:0] wb_data,
    output logic        zero,
    output logic        memread,
    output logic        memwrite,
    output logic        mem_to_reg,
    output logic        regwrite,
    output logic        ALU_source,
    output logic [1:0]  ALU_op,
    output logic [3:0]  ALU_control,
    output logic        branch,
    output logic [31:0] hi,
    output logic [31:0] lo
);

    // --- Internal Signals ---
    logic [31:0] pc_F, next_pc_F, pc_plus4_F, instr_F;
    logic [31:0] pc_D, instr_D, data1_D, data2_D, imm_D;
    logic [4:0]  rd_D, rs1_D, rs2_D;
    logic [6:0]  opcode_D;
    logic [2:0]  fun11_D;
    logic [6:0]  fun21_D;
    logic        memread_D, memwrite_D, mem_to_reg_D, regwrite_D, alu_src_D, branch_D, jump_D;
    logic [1:0]  alu_op_D;

    logic [31:0] pc_E, imm_E, data1_E, data2_E, instr_E_slice;
    logic [4:0]  rd_E, rs1_E, rs2_E;
    logic [6:0]  opcode_E;
    logic        memread_E, memwrite_E, mem_to_reg_E, regwrite_E, alu_src_E, branch_E, jump_E;
    logic [1:0]  alu_op_E;
    logic [31:0] alu_result_E, final_result_E, branch_target_E;
    logic [3:0]  alu_control_E;
    logic        zero_E;
    logic [2:0]  fun11_E;
    logic [6:0]  fun21_E;

    logic [31:0] pc_branch_M, alu_result_M, write_data_M, zero_flag_container_M;
    logic [4:0]  rd_M;
    logic        zero_M, memread_M, memwrite_M, mem_to_reg_M, regwrite_M, branch_M, jump_M;
    logic [31:0] mem_read_data_M;

    logic [31:0] mem_data_W, alu_result_W, wb_final_data;
    logic [4:0]  rd_W;
    logic        mem_to_reg_W, regwrite_W, jump_W;

    logic [1:0] signala, signalb;
    logic [31:0] alu_operand1_E_selected, alu_operand2_E_selected, alu_final_operand2;
    logic stall_pc, stall_if_id, flush_id_ex, flush_if_id;

    // --- 1. FETCH STAGE ---
    program_counter pc_inst (
        .pc(pc_F), .clock(clock), .reset(reset),
        .stall(stall_pc), .next_pc(next_pc_F)
    );

    pc_adder pc_4_inst (.pc(pc_F), .pc_4(pc_plus4_F));

    Instruction_memory instr_mem_inst (.pc_byte_address(pc_F), .ins(instr_F));

    Generic_pipeline_reg_reg #(32, 32, 32, 5, 32, 7) IF_ID_REG (
        .clock(clock), .reset(reset),
        .stall(stall_if_id), .flush(flush_if_id),
        .pc(pc_F), .instruction(instr_F),
        .out_pc(pc_D), .out_instruction(instr_D)
    );

    // --- 2. DECODE STAGE ---
    assign opcode_D = instr_D[6:0];
    assign rs1_D    = instr_D[19:15];
    assign rs2_D    = instr_D[24:20];
    assign rd_D     = instr_D[11:7];
    assign fun11_D  = instr_D[14:12];
    assign fun21_D  = instr_D[31:25];

    Control_unit con_unit_inst (
        .opcode(opcode_D), .memread(memread_D), .memwrite(memwrite_D), .mem_to_reg(mem_to_reg_D), 
        .regwrite(regwrite_D), .ALU_source(alu_src_D), .ALU_op(alu_op_D), 
        .branch(branch_D), .jump(jump_D)
    );

    reg_file regfile_inst (
        .r1(rs1_D), .r2(rs2_D), .rd(rd_W),
        .dataW(wb_final_data), .data1(data1_D), .data2(data2_D),
        .clock(clock), .regwrite(regwrite_W), .hi(hi), .lo(lo)
    );

    immediate_gen imm_inst (.ins(instr_D), .immediate(imm_D));

    Generic_pipeline_reg_reg #(32, 32, 32, 5, 32, 7) ID_EX_REG (
        .clock(clock), .reset(reset), .stall(1'b0), .flush(flush_id_ex),
        .pc(pc_D), .instruction(instr_D), .opcode(opcode_D), .immediate(imm_D),
        .r1(rs1_D), .r2(rs2_D), .rd(rd_D), .r2_value(data2_D), .ALU_result(data1_D),
        .memread(memread_D), .memwrite(memwrite_D), .mem_to_reg(mem_to_reg_D), 
        .regwrite(regwrite_D), .ALU_source(alu_src_D), .ALU_op(alu_op_D), 
        .branch(branch_D), .jump(jump_D),
        .out_pc(pc_E), .out_instruction(instr_E_slice), .out_opcode(opcode_E),
        .out_immediate(imm_E), .out_r1(rs1_E), .out_r2(rs2_E), .out_rd(rd_E),
        .out_r2_value(data2_E), .out_ALU_result(data1_E),
        .out_memread(memread_E), .out_memwrite(memwrite_E), .out_mem_to_reg(mem_to_reg_E), 
        .out_regwrite(regwrite_E), .out_ALU_source(alu_src_E), .out_ALU_op(alu_op_E), 
        .out_branch(branch_E), .out_jump(jump_E)
    );

    // --- 3. EXECUTE STAGE ---
    assign fun11_E = instr_E_slice[14:12];
    assign fun21_E = instr_E_slice[31:25];

    Forwading_unit fuec_inst (
        .id_exec_regWrite(regwrite_M), .exec_mem_regWrite(regwrite_W),
        .id_exec_rd(rd_M), .exec_mem_rd(rd_W),
        .if_id_r1(rs1_E), .if_id_r2(rs2_E),
        .signala(signala), .signalb(signalb)
    );

    // Forwarding for ALU Operand 1
    mux_f_1 for1_inst (.datareg(data1_E), .data_exec(alu_result_M), .data_mem(wb_final_data), .control(signala), .output_data(alu_operand1_E_selected));
    
    // Forwarding for ALU Operand 2 (Selected first to support Store Data forwarding)
    mux_f_2 for2_inst (.datareg(data2_E), .data_exec(alu_result_M), .data_mem(wb_final_data), .control(signalb), .output_data(alu_operand2_E_selected));

    // Mux to choose between Forwarded Register or Immediate
    MUX_1 alu_src_mux (.data_from_reg2(alu_operand2_E_selected), .immediate(imm_E), .ALU_source(alu_src_E), .data2(alu_final_operand2));

    alu_control alu_con_inst (.ALU_op(alu_op_E), .fun21(fun21_E), .fun11(fun11_E), .ALU_control(alu_control_E));
    
    ALU alu_inst (.data1(alu_operand1_E_selected), .data2(alu_final_operand2), .dataW(alu_result_E), .ALU_control(alu_control_E), .zero(zero_E));

    mul_mux mul_mux_inst (.ALU_control(alu_control_E), .alu_1(alu_result_E), .opcode(opcode_E), .mul_1(32'b0), .alu_result_final(final_result_E));

    pc_immediate pc_immediate_inst (.pc_1(pc_E), .dataW(imm_E), .pc_i(branch_target_E));

    

    Generic_pipeline_reg_reg #(32, 32, 32, 5, 32, 7) EX_MEM_REG (
        .clock(clock), .reset(reset), .stall(1'b0), .flush(1'b0),
        .pc(branch_target_E), .ALU_result(final_result_E), 
        .r2_value(alu_operand2_E_selected), // Passing forwarded rs2 value for Store
        .rd(rd_E),
        .immediate({31'b0, zero_E}), .memread(memread_E), .memwrite(memwrite_E), 
        .mem_to_reg(mem_to_reg_E), .regwrite(regwrite_E), .branch(branch_E), .jump(jump_E),
        .out_pc(pc_branch_M), .out_ALU_result(alu_result_M), .out_r2_value(write_data_M),
        .out_rd(rd_M), .out_immediate(zero_flag_container_M), .out_memread(memread_M), 
        .out_memwrite(memwrite_M), .out_mem_to_reg(mem_to_reg_M), .out_regwrite(regwrite_M), 
        .out_branch(branch_M), .out_jump(jump_M)
    );

    // --- 4. MEMORY STAGE ---
    assign zero_M = zero_flag_container_M[0];

    data_mem dmem_inst (
        .rd(mem_read_data_M), .r2(write_data_M), .clock(clock),
        .memwrite(memwrite_M), .memread(memread_M), .dataW(alu_result_M)
    );

    Hazard_unit hdu_inst (
        .rs1_D(rs1_D), .rs2_D(rs2_D), .rd_E(rd_E), .memread_E(memread_E),
        .branch_M(branch_M), .zero_M(zero_M), .jump_M(jump_M),
        .stall_pc(stall_pc), .stall_if_id(stall_if_id), 
        .flush_id_ex(flush_id_ex), .flush_if_id(flush_if_id)
    );

    mux_3 pc_sel_mux (
        .pc_1(pc_plus4_F), .pc_jump(pc_branch_M), .pc(next_pc_F),
        .zero(zero_M), .branch(branch_M), .jump(jump_M)
    );

    Generic_pipeline_reg_reg #(32, 32, 32, 5, 32, 7) MEM_WB_REG (
        .clock(clock), .reset(reset), .stall(1'b0), .flush(1'b0),
        .ALU_result(alu_result_M), .r2_value(mem_read_data_M), .rd(rd_M),
        .mem_to_reg(mem_to_reg_M), .regwrite(regwrite_M), .jump(jump_M),
        .out_ALU_result(alu_result_W), .out_r2_value(mem_data_W), .out_rd(rd_W),
        .out_mem_to_reg(mem_to_reg_W), .out_regwrite(regwrite_W), .out_jump(jump_W)
    );

    // --- 5. WRITE BACK STAGE ---
    MUX_2 wb_mux (.alu_data(alu_result_W), .mem_data(mem_data_W), .mem_to_reg(mem_to_reg_W), .wb_data(wb_final_data), .pc_4(32'b0), .jump(jump_W));

    // --- Output Assignments ---
    assign rd = rd_W; 
    assign wb_data = wb_final_data;
    assign pc = pc_F;
    assign ins = instr_F;
    assign data1 = data1_D;
    assign data2 = data2_D;
    assign opcode = opcode_D;
    assign r1 = rs1_D;
    assign r2 = rs2_D;
    assign immediate_32 = imm_D;
    assign memread = memread_D;
    assign memwrite = memwrite_D;
    assign regwrite = regwrite_W;
    assign zero = zero_E;

endmodule