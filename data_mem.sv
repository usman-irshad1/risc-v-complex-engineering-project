`timescale 1ns / 1ps

module data_mem#(
    parameter ins_width = 32,
    parameter ins_depth = 19,
    parameter pc_width = 5,
    parameter opcode_width = 7,
    parameter r_width = 5,
    parameter fun1 = 3,
    parameter fun2 = 7,
    parameter immediate_len = 12
)(
    output logic [ins_width-1:0] rd,
    input logic [ins_width-1:0] r2,
    input logic clock,
    input logic memread,
    input logic memwrite,
    input logic [ins_width-1:0] dataW 
);

logic [ins_width-1:0] data [0:4095]; 
logic [31:0] adress;

initial begin
    $readmemh("data_mem.mem", data); 
end

always_comb begin
    if (memread) begin 
        rd = data[dataW[11:2]]; 
    end
end

always_ff @(posedge clock)
begin
    if (memwrite) begin 

        data[dataW[11:2]] = r2; 
    end
end
always @(posedge clock) begin
    if (memread) 
        $display("[DataMem] Reading from Address %h, Value returned: %h", dataW, rd);
    if (memwrite)
        $display("[DataMem] Writing to Address %h, Value stored: %h", dataW, r2);
end
endmodule