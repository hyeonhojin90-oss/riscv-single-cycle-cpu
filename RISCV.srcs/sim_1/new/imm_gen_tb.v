


`timescale 1ns / 1ps

module imm_gen_tb;

reg [31:0] instruction;
wire [31:0] imm;

imm_gen uut (
    .instruction(instruction),
    .imm(imm)
);

initial begin
    // I-type: addi, imm = 8
    // instruction[31:20] = 12'd8
    // opcode = 0010011
    instruction = {12'd8, 5'd4, 3'b000, 5'd5, 7'b0010011};
    #20;

    // I-type: lw, imm = 12
    // opcode = 0000011
    instruction = {12'd12, 5'd4, 3'b010, 5'd5, 7'b0000011};
    #20;

    // S-type: sw, imm = 16
    // imm[11:5], rs2, rs1, funct3, imm[4:0], opcode
    instruction = {7'b0000000, 5'd5, 5'd4, 3'b010, 5'b10000, 7'b0100011};
    #20;

    // B-type: beq, imm = 8
    // imm bits are split: imm[12], imm[10:5], rs2, rs1, funct3, imm[4:1], imm[11], opcode
    instruction = {1'b0, 6'b000100, 5'd2, 5'd1, 3'b000, 4'b0100, 1'b0, 7'b1100011};
    #20;

    // I-type: addi, imm = -8
    instruction = {12'b111111111000, 5'd4, 3'b000, 5'd5, 7'b0010011};
    #20;

    $finish;
end

endmodule


