`timescale 1ns / 1ps

module multiplication_module #(parameter DATA_W = 32
)(
    input  logic [3:0]  ALU_control,  
    input  logic [DATA_W-1:0] data1,   
    input  logic [DATA_W-1:0] data2,   
    input  logic [2:0]  fun11,         
    output logic [DATA_W-1:0] hi,      
    output logic [DATA_W-1:0] lo       
);

logic signed [DATA_W-1:0] s_data1, s_data2;
logic signed [2*DATA_W-1:0] s_mult;
logic [2*DATA_W-1:0] u_mult;

assign s_data1 = data1;
assign s_data2 = data2;

always_comb begin
    hi = 0;
    lo = 0;

    case(ALU_control)
        4'b1000: begin // MUL instructions
            case(fun11)
                3'b000: begin 
                    lo = data1 * data2;
                    hi = 0;
                end
                3'b001: begin // MULH 
                    s_mult = s_data1 * s_data2;
                    lo = s_mult[31:0];
                    hi = s_mult[63:32];
                end
                3'b010: begin // MULHSU 
                    s_mult = s_data1 * data2;
                    lo = s_mult[31:0];
                    hi = s_mult[63:32];
                end
                3'b011: begin // MULHU 
                    u_mult = data1 * data2;
                    lo = u_mult[31:0];
                    hi = u_mult[63:32];
                end
                default: begin
                    lo = 0;
                    hi = 0;
                end
            endcase
        end
        4'b1001: begin //disicon instructions
            case(fun11)
                3'b100: begin // DIV (signed)
                    if (data2 != 0)
                        lo = s_data1 / s_data2;
                   
                end
                3'b101: begin // DIVU 
                    if (data2 != 0)
                        lo = data1 / data2;
                end
                3'b110: begin // REM 
                    if (data2 != 0)
                        lo = s_data1 % s_data2;
                end
                3'b111: begin // REMU 
                    if (data2 != 0)
                        lo = data1 % data2;
                end
                default: begin
                    lo = 0;
                    hi = 0;
                end
            endcase
        end
        default: begin
            lo = 0;
            hi = 0;
        end
    endcase
end

endmodule
