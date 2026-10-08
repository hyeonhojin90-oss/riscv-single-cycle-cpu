
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2026/07/29 19:23:54
// Design Name: 
// Module Name: control_unit_tb
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

module control_unit_tb;

reg [6:0] opcode;

wire branch;
wire mem_read;
wire mem_to_reg;
wire [1:0] alu_op;
wire mem_write;
wire alu_src;
wire reg_write;

control_unit uut (
    .opcode(opcode),
    .branch(branch),
    .mem_read(mem_read),
    .mem_to_reg(mem_to_reg),
    .alu_op(alu_op),
    .mem_write(mem_write),
    .alu_src(alu_src),
    .reg_write(reg_write)
);

initial begin
    $monitor("\n time=%0t\nopcode= %b \n branch= %b \n mem_read= %b \n mem_to_reg = %b \n alu_op = %b \n mem_write= %b \n alu_src= %b \n reg_write  = %b \n ",
         $time, opcode, branch, mem_read, mem_to_reg, alu_op, mem_write, alu_src, reg_write);

    opcode = 7'b0110011; // R-type
    #20;

    opcode = 7'b0010011; // I-type ALU
    #20;

    opcode = 7'b0000011; // Load
    #20;

    opcode = 7'b0100011; // Store
    #20;

    opcode = 7'b1100011; // Branch
    #20;

    opcode = 7'b1111111; // Unknown/default
    #20;

    $finish;
end

endmodule
