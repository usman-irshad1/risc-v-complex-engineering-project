module Hazard_unit(
    
    input  logic [4:0] rs1_D,        
    input  logic [4:0] rs2_D,        
    input  logic [4:0] rd_E,         
    input  logic       memread_E,    

    
    input  logic       branch_M,     
    input  logic       zero_M,       
    input  logic       jump_M,       


    output logic       stall_pc,     
    output logic       stall_if_id,  
    output logic       flush_id_ex,  
    output logic       flush_if_id   
);

    
    always_comb begin
     
        stall_pc    = 1'b0;
        stall_if_id = 1'b0;
        flush_id_ex = 1'b0;
        flush_if_id = 1'b0;

    
        if (memread_E && ((rd_E == rs1_D) || (rd_E == rs2_D)) && (rd_E != 5'b0)) begin
            stall_pc    = 1'b1;
            stall_if_id = 1'b1;
            flush_id_ex = 1'b1; 
        end


        if ((branch_M && zero_M) || jump_M) begin
            flush_if_id = 1'b1;
        end
    end



endmodule