`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/11/2025 12:42:27 PM
// Design Name: 
// Module Name: mux_forward_2
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
`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 12/11/2025 12:38:49 PM
// Design Name: 
// Module Name: mux_f_1
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


module mux_f_2(
input logic [31:0] datareg, data_exec, data_mem,
output logic [31:0] output_data,
input logic [1:0] control
    );
    always_comb
    begin
    case (control)
    2'b00:output_data=datareg;
    2'b01:output_data=data_exec;
    2'b10:output_data=data_mem;
    endcase
    end
    
    
    
endmodule
