`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10/14/2025 06:28:33 PM
// Design Name: 
// Module Name: mux_2
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


module MUX_2 #(
    parameter DATA_W = 32
)(
    input  logic [DATA_W-1:0] alu_data,
    input  logic [DATA_W-1:0] mem_data,
    input  logic mem_to_reg,
    output logic [DATA_W-1:0] wb_data,
    input logic [DATA_W-1:0] pc_4,
    input logic jump
);

always_comb begin
    if (jump==1&&mem_to_reg==0)
    begin
    wb_data=pc_4;
    end
   else if (jump==0&&mem_to_reg==1)      
        wb_data = mem_data;
    else                           
        wb_data = alu_data;
end

endmodule

