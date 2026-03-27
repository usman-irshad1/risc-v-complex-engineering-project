module program_counter #(
    parameter pcwidth = 32  
) (
  output logic [pcwidth-1:0] pc,
  input  logic [pcwidth-1:0] next_pc, 
  input  logic clock,
  input  logic reset,
  input  logic stall        
);

always_ff @(posedge clock or posedge reset) begin
  if (reset)
    pc <= 0;
  else if (!stall)        
    pc <= next_pc; 
end

endmodule