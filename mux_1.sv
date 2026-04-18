

module MUX_1#(parameter ins_width = 32, opcode_width=7,  immediate_len=12)(
input logic [ins_width-1:0] data_from_reg2,
input logic [ins_width-1:0] immediate,
output logic [ins_width-1:0] data2,
input logic ALU_source
    );
    always_comb
    begin
    if (ALU_source==1'b1)//this will bbe for the I type
    begin
    data2=immediate; //this is sign extending the immediate using the last bit
    end
    else 
    begin 
    data2=data_from_reg2;
    end
    end
endmodule
