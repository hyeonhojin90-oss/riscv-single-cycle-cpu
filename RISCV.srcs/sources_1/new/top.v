`timescale 1ns / 1ps

module single_cycle_cpu(
    input clk,
    input reset
);

wire [31:0] pc;
wire [31:0] next_pc;
wire [31:0] pc_plus_4;
wire [31:0] branch_target;
wire pc_src;

wire [31:0] instruction;

wire branch;
wire mem_read;
wire mem_to_reg;
wire [1:0] alu_op;
wire mem_write;
wire alu_src;
wire reg_write;

wire [31:0] read_data1;
wire [31:0] read_data2;
wire [31:0] write_back_data;

wire [31:0] imm;

wire [3:0] alu_control_signal;

wire [31:0] alu_input2;
wire [31:0] alu_result;
wire zero;

wire [31:0] memory_read_data;
wire [31:0] memory_write_data;

assign pc_plus_4 = pc + 32'd4;
assign branch_target = pc + imm;
assign pc_src = branch & zero;
assign next_pc = pc_src ? branch_target : pc_plus_4;

assign alu_input2 = alu_src ? imm : read_data2;
assign write_back_data = mem_to_reg ? memory_read_data : alu_result;
assign memory_write_data = read_data2;

pc u_pc (
    .clk(clk),
    .reset(reset),
    .next_pc(next_pc),
    .pc(pc)
);

instruction_memory u_instruction_memory (
    .address(pc),
    .instruction(instruction)
);

control_unit u_control_unit (
    .opcode(instruction[6:0]),
    .branch(branch),
    .mem_read(mem_read),
    .mem_to_reg(mem_to_reg),
    .alu_op(alu_op),
    .mem_write(mem_write),
    .alu_src(alu_src),
    .reg_write(reg_write)
);

register_file u_register_file (
    .clk(clk),
    .reg_write(reg_write),
    .rs1(instruction[19:15]),
    .rs2(instruction[24:20]),
    .rd(instruction[11:7]),
    .write_data(write_back_data),
    .read_data1(read_data1),
    .read_data2(read_data2)
);

imm_gen u_imm_gen (
    .instruction(instruction),
    .imm(imm)
);

alu_control u_alu_control (
    .alu_op(alu_op),
    .funct7_5(instruction[30]),
    .funct3(instruction[14:12]),
    .alu_control(alu_control_signal)
);

ALU u_ALU (
    .a(read_data1),
    .b(alu_input2),
    .alu_control(alu_control_signal),
    .result(alu_result),
    .zero(zero)
);

data_memory u_data_memory (
    .clk(clk),
    .mem_read(mem_read),
    .mem_write(mem_write),
    .address(alu_result),
    .write_data(memory_write_data),
    .read_data(memory_read_data)
);

endmodule