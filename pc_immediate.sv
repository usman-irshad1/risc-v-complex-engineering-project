`timescale 1ns / 1ps

module pc_immediate#(
    parameter pc_adress=32, 
    parameter ins_width = 32 
)(
    input logic [pc_adress-1:0] pc_1,
    output logic [pc_adress-1:0] pc_i,
    input logic [ins_width-1:0] dataW
  );

always_comb
  begin
  pc_i=pc_1 + dataW; 
  end
endmodule