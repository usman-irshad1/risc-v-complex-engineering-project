# Risc V Complex Engineering Project

Complex Engineering Project (CEP) RISC-V processor architecture

## Architecture & Project Modules
This repository contains the hardware description and simulation models developed in SystemVerilog/Verilog using AMD/Xilinx Vivado.

### Primary Verilog & Support Files
- `immediate_gen.sv`
- `pc.sv`
- `pc_immediate.sv`
- `data_mem.mem`
- `ins_file.mem`
- `reg.mem`
- `data_mem.sv`
- `EX_MEM_reg.sv`
- `ins_mem.sv`
- `MEM_WB_register.sv`
- `reg_mem.sv`
- `reg_top_tb.sv`
- `ID_EXEC_reg.sv`
- `IF_ID_register.sv`
- `Reg_top.sv`
- `mul_tets.sv`
- `ALU.sv`
- `ALU_con.sv`
- `mul.sv`
- `mul_mux_1.sv`
- `Mul_output_mux.sv`
- `sll.sv`
- `mux.sv`
- `mux_1.sv`
- `mux_2.sv`
- `mux_f_1.sv`
- `mux_f_2.sv`
- `Control_unit.sv`
- `Forwading_unit.sv`
- `write_back_jump.sv`
- `tb_top_func_synth.v`
- `top_tb.sv`
- `TOP.sv`

## Build & Simulation Instructions
1. Open **AMD/Xilinx Vivado** (or ModelSim / Icarus Verilog).
2. Create a new Vivado RTL Project.
3. Add the Verilog/SystemVerilog source files located in this repository.
4. Set the top-level module (e.g. `TOP.sv` or top module) as the Top Module.
5. Run Behavioral Simulation via `xsim` or launch Synthesis/Implementation.

## Author & Maintainer
- **Author**: Mohammad Usman Irshad
- **GitHub Profile**: [@usman-irshad1](https://github.com/usman-irshad1)
