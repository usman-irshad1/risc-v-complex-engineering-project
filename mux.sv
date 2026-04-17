module mux_3#(parameter pcwidth = 32) (
input zero,
input branch,
    input logic [pcwidth-1:0] pc_1,
    input logic [pcwidth-1:0] pc_jump,
    output logic [pcwidth-1:0] pc,
    input logic jump
    );
   logic[pcwidth-1:0] pc11,pc_ime;
   always_comb
   begin
   pc11=pc_1;
   pc_ime=pc_jump;
   if ((zero==1 && branch ==1)||jump==1)
   begin
   pc=pc_ime;
   end
   else 
   begin
   pc=pc11;
   end
   end
endmodule