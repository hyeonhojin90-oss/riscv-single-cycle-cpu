`timescale 1ns / 1ps

module control_unit(
    input [6:0] opcode,
    output reg branch,
    output reg jump_jal,
    output reg jump_jalr,
    output reg lui,
    output reg auipc,
    output reg mem_read,
    output reg mem_to_reg,
    output reg [1:0] alu_op,
    output reg mem_write,
    output reg alu_src,
    output reg reg_write
);

always @(*) begin
    case (opcode)

        // R-type
        7'b0110011: begin
            branch     = 0;
            jump_jal   = 0;
            jump_jalr  = 0;
            mem_read   = 0;
            mem_to_reg = 0;
            alu_op     = 2'b10;
            mem_write  = 0;
            alu_src    = 0;
            reg_write  = 1;
        end

        // Load
        7'b0000011: begin
            branch     = 0;
            jump_jal   = 0;
            jump_jalr  = 0;
            mem_read   = 1;
            mem_to_reg = 1;
            alu_op     = 2'b00;
            mem_write  = 0;
            alu_src    = 1;
            reg_write  = 1;
        end

        // S-type : store
        7'b0100011: begin
            branch     = 0;
            jump_jal   = 0;
            jump_jalr  = 0;
            mem_read   = 0;
            mem_to_reg = 0;
            alu_op     = 2'b00;
            mem_write  = 1;
            alu_src    = 1;
            reg_write  = 0;
        end

        // B-type:  branch
        7'b1100011: begin
            branch     = 1;
            jump_jal   = 0;
            jump_jalr  = 0;
            mem_read   = 0;
            mem_to_reg = 0;
            alu_op     = 2'b01;
            mem_write  = 0;
            alu_src    = 0;
            reg_write  = 0;
        end

        // I-type : jalr ¿Ü 
        7'b0010011: begin
            branch     = 0;
            jump_jal   = 0;
            jump_jalr  = 0;
            mem_read   = 0;
            mem_to_reg = 0;
            alu_op     = 2'b11;
            mem_write  = 0;
            alu_src    = 1;
            reg_write  = 1;
        end

        // J-type: JAL
        7'b1101111: begin
            branch     = 0;
            jump_jal   = 1;
            jump_jalr  = 0;
            mem_read   = 0;
            mem_to_reg = 0;
            alu_op     = 2'b00;
            mem_write  = 0;
            alu_src    = 0;
            reg_write  = 1;
        end

        // I-type: JALR
        7'b1100111: begin
            branch     = 0;
            jump_jal   = 0;
            jump_jalr  = 1;
            mem_read   = 0;
            mem_to_reg = 0;
            alu_op     = 2'b00;
            mem_write  = 0;
            alu_src    = 0;
            reg_write  = 1;
        end
        
        // u-type: LUI
        7'b0110111: begin
            branch     = 0;
            jump_jal   = 0;
            jump_jalr  = 0;
            lui        = 1;
            auipc      = 0;
            mem_read   = 0;
            mem_to_reg = 0;
            alu_op     = 2'b00;
            mem_write  = 0;
            alu_src    = 0;
            reg_write  = 1;
         end

        // u-tpye:  AUIPC
        7'b0010111: begin
            branch     = 0;
            jump_jal   = 0;
            jump_jalr  = 0;
            lui        = 0;
            auipc      = 1;
            mem_read   = 0;
            mem_to_reg = 0;
            alu_op     = 2'b00;
            mem_write  = 0;
            alu_src    = 1;
            reg_write  = 1;
        end
        
        

        default: begin
            branch     = 0;
            jump_jal   = 0;
            jump_jalr  = 0;
            mem_read   = 0;
            mem_to_reg = 0;
            alu_op     = 2'b00;
            mem_write  = 0;
            alu_src    = 0;
            reg_write  = 0;
        end

    endcase
end

endmodule