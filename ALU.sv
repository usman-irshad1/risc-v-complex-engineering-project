`timescale 1ns / 1ps
module ALU #(
  parameter ins_width = 32,
  parameter opcode_width = 7,
  parameter fun1 = 3,
  parameter fun2 = 7
)(
  input logic [3:0] ALU_control,
  input logic [ins_width-1:0] data1,
  input logic [ins_width-1:0] data2,
  output logic signed [ins_width-1:0] dataW,
  output logic zero
);

always_comb begin
  dataW = 0;
  zero = 0;

  case (ALU_control)
    4'b0000: begin
      dataW = data1 & data2; // AND, ANDI
    end
    4'b0001: begin
      dataW = data1 | data2; // OR, ORI
    end
    4'b0010: begin
      dataW = data1 + data2; // ADD, ADDI
    end
    4'b0011: begin
      dataW = ($signed(data1) < $signed(data2)) ? 1 : 0; // SLT, SLTI
    end
    4'b0100: begin
      dataW = data1 << data2[4:0]; // SLL, SLLI
    end
    4'b0101: begin
      dataW = data1 >> data2[4:0]; // SRL, SRLI
    end
    4'b0110: begin
      dataW = $signed(data1) - $signed(data2); // SUB
      if (dataW == 0) begin
        zero = 1;
      end
    end
    4'b0111: begin
      dataW = data1 ^ data2; // XOR, XORI
    end
    4'b1010: begin
      dataW = (data1 < data2) ? 1 : 0; // SLTU, SLTIU
    end
    4'b1011: begin
      dataW = $signed(data1) >>> data2[4:0]; // SRA, SRAI
    end
    4'b1000: begin
      if (data1 == data2) begin // BEQ
        zero = 1;
      end
    end
    4'b1001: begin
      if (data1 != data2) begin // BNE
        zero = 1;
      end
    end
    4'b1110: begin
      if ($signed(data1) < $signed(data2)) begin // BLT
        zero = 1;
      end
    end
    4'b1111: begin
      if ($signed(data1) >= $signed(data2)) begin // BGE
        zero = 1;
      end
    end
    4'b1100: begin
      if (data1 < data2) begin // BLTU
        zero = 1;
      end
    end
    4'b1101: begin
      if (data1 >= data2) begin // BGEU
        zero = 1;
      end
    end
    default: begin
      dataW = 0;
      zero = 0;
    end
  endcase
end

endmodule
