module Instruction_memory#(
    parameter ins_width = 32, 
    ins_depth=32, 
    pc_width = 32, 
    opcode_width=7, 
    r_width=5, 
    fun1=3, 
    fun2=7, 
    immediate_len=12
)(
    input logic [ins_width-1:0] pc_byte_address, 
    output logic [r_width-1:0] r1, 
    output logic [r_width-1:0] r2,
    output logic [r_width-1:0] rd,
    output logic [ins_width-1:0] ins,
    output logic [opcode_width-1:0] opcode,
    output logic [fun1-1:0] fun11,
    output logic [fun2-1:0] fun21
);

logic [ins_width-1:0] ins_block[ins_depth-1:0];
logic [4:0] word_index; 

assign word_index = pc_byte_address[6:2]; 

initial begin
    $readmemh("ins_file.mem",ins_block); 
end

always_comb
begin
    opcode=ins_block[word_index][6:0];
    r1=ins_block[word_index][19:15];
    r2=ins_block[word_index][24:20];
    rd=ins_block[word_index][11:7];
    fun11=ins_block[word_index][14:12];
    fun21=ins_block[word_index][31:25];
    ins=ins_block[word_index];
end

endmodule