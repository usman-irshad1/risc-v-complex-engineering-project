//`timescale 1ns / 1ps

//module forwarding_testbench;

//    // Testbench signals
//    logic clock;
//    logic reset;

//    // Forwarding signals
//    logic [1:0] signala, signalb;

//    // Example register write signals and destination registers
//    logic regwrite_E, regwrite_M;
//    logic [4:0] rd_E, rd_M, rs1_E, rs2_E;

//    // Instantiate the forwarding unit
//    Forwading_unit fu_inst (
//        .id_exec_regWrite(regwrite_E),
//        .exec_mem_regWrite(regwrite_M),
//        .id_exec_rd(rd_E),
//        .exec_mem_rd(rd_M),
//        .if_id_r1(rs1_E),
//        .if_id_r2(rs2_E),
//        .signala(signala),
//        .signalb(signalb)
//    );

//    // Clock generation
//    always #5 clock = ~clock;

//    // Test scenario
//    initial begin
//        // Initialize signals
//        clock = 0;
//        reset = 1;
//        regwrite_E = 0;
//        regwrite_M = 0;
//        rd_E = 5'b00000;
//        rd_M = 5'b00000;
//        rs1_E = 5'b00000;
//        rs2_E = 5'b00000;

//        // Wait for a few cycles
//        #10;
//        reset = 0;

//        // Test case 1: EX stage writes to register 5, and ID stage reads register 5
//        #10;
//        regwrite_E = 1;
//        rd_E = 5'b00101; // Register 5
//        rs1_E = 5'b00101; // Register 5
//        rs2_E = 5'b00000;
//        #10;

//        // Print forwarding control signals
//        $display("Time: %0t | signala: %b, signalb: %b", $time, signala, signalb);

//        // Test case 2: MEM stage writes to register 5, and ID stage reads register 5
//        #10;
//        regwrite_E = 0;
//        regwrite_M = 1;
//        rd_M = 5'b00101; // Register 5
//        rs1_E = 5'b00101; // Register 5
//        rs2_E = 5'b00000;
//        #10;

//        // Print forwarding control signals
//        $display("Time: %0t | signala: %b, signalb: %b", $time, signala, signalb);

//        // Add more test cases as needed to verify the logic

//        // End simulation
//        #20;
//        $finish;
//    end

//endmodule
