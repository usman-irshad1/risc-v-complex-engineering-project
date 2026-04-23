module Forwading_unit(
    input logic id_exec_regWrite,   
    input logic exec_mem_regWrite, 
    input logic [4:0] id_exec_rd,   
    input logic [4:0] exec_mem_rd,  
    input logic [4:0] if_id_r1,     
    input logic [4:0] if_id_r2,      
    output logic [1:0] signala, signalb
);

    always_comb begin
        signala = 2'b00;
        signalb = 2'b00;

       
        if (id_exec_regWrite && (id_exec_rd != 5'b0) && (id_exec_rd == if_id_r1)) 
            signala = 2'b01;
        if (id_exec_regWrite && (id_exec_rd != 5'b0) && (id_exec_rd == if_id_r2)) 
            signalb = 2'b01;

        
        if (exec_mem_regWrite && (exec_mem_rd != 5'b0)) begin
            if ((exec_mem_rd == if_id_r1) && (signala == 2'b00)) 
                signala = 2'b10;
            if ((exec_mem_rd == if_id_r2) && (signalb == 2'b00)) 
                signalb = 2'b10;
        end
    end
endmodule