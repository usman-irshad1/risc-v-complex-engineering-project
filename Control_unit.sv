`timescale 1ns / 1ps
 module Control_unit#(parameter ins_width = 32, ins_depth=19, pc_width = 32, opcode_width=7, r_width=5, fun1=3, fun2=7, immediate_len=12)(
       input logic [opcode_width-1:0] opcode,
        output logic memread,
        output logic memwrite,
        output logic mem_to_reg,
        output logic regwrite,
        output logic ALU_source,
        output logic [1:0 ]ALU_op,
        output logic branch,
        output logic jump
        );
        
        always_comb
        begin
        if (opcode==7'b0110011)//r type
        begin
        memread=0;
        memwrite=0;
        mem_to_reg=0;
        regwrite=1;
        ALU_source=0;
        ALU_op=2'b10;
        branch=0;
        jump=0;
        end
        else if (opcode==7'b0010011) //i type
        begin
        memread=0;
        memwrite=0;
        mem_to_reg=0;
        regwrite=1;
        ALU_source=1;
         ALU_op=2'b10;
         branch=0;
         jump=0;

        end
       else if (opcode==7'b0100011) //store word
        begin
        memread=0;
        memwrite=1;
        mem_to_reg=0;
        regwrite=0;
        ALU_source=1;
          ALU_op=2'b00;
          branch=0;
          jump=0;

        end
        else if (opcode==7'b0000011) //load word
        begin
        memread=1;
        memwrite=0;
        mem_to_reg=1;
        regwrite=1;
        ALU_source=1;
         ALU_op=2'b00;
         branch=0;
         jump=0;

        end
        else if (opcode==7'b1100011)
        begin
        memread=0;
        memwrite=0;
        mem_to_reg=0;
        regwrite=0;
        ALU_source=0;
         ALU_op=2'b01;
         branch=1;
         jump=0;
        end
        
        
        else if (opcode==7'b1101111) //jumping
        begin
        memread=0;
        memwrite=0;
        mem_to_reg=0;
        regwrite=1;
        ALU_source=1;
        ALU_op=2'b00;
        branch=0;
        jump=1;
        end
        end
        
endmodule
