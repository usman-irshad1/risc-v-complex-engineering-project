`timescale 1ns / 1ps

module top_tb;

    logic clock;
    logic reset;

    // Outputs from DUT
    logic [31:0] pc;
    logic [4:0]  r1, r2, rd;
    logic [31:0] ins, data1, data2, immediate_32, wb_data;
    logic [6:0]  opcode, fun21;
    logic [2:0]  fun11;
    logic [3:0]  ALU_control;
    logic [1:0]  ALU_op;
    logic        zero, memread, memwrite, mem_to_reg, regwrite, ALU_source, branch;
    logic [31:0] hi, lo;

    // Instantiate DUT
    top dut (
        .clock(clock), .reset(reset), .pc(pc),
        .r1(r1), .r2(r2), .rd(rd), .ins(ins),
        .data1(data1), .data2(data2), .immediate_32(immediate_32),
        .opcode(opcode), .fun11(fun11), .fun21(fun21),
        .wb_data(wb_data), .zero(zero), .memread(memread),
        .memwrite(memwrite), .mem_to_reg(mem_to_reg),
        .regwrite(regwrite), .ALU_source(ALU_source),
        .ALU_op(ALU_op), .ALU_control(ALU_control),
        .branch(branch), .hi(hi), .lo(lo)
    );

    // Clock generator (10ns period)
    always #5 clock = ~clock;

    // --- CONSOLE DISPLAY LOGIC ---
    initial begin
        $display("\n--------------------------------------------------------------");
        $display("Time\t PC\t\t Instruction\t WB_Data\t DestReg");
        $display("--------------------------------------------------------------");
        
        // Monitor will print whenever one of these values changes
        $monitor("%0t\t %h\t %h\t %h\t x%0d", 
                 $time, pc, ins, wb_data, rd);
    end

    // Detailed Debug Display (runs every clock cycle)
    always @(posedge clock) begin
        if (!reset && regwrite) begin
            $display("[WriteBack] Time: %0t | Reg x%0d updated with Value: %h", $time, rd, wb_data);
        end
    end

    initial begin
        // Initialize
        clock = 0;
        reset = 1;
        #20;
        reset = 0;

        // Run long enough for the pipeline to finish the hex code provided
        #300; 

        $display("--------------------------------------------------------------");
        $display("Simulation Finished");
        $stop;
    end

endmodule