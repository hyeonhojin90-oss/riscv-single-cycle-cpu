`timescale 1ns / 1ps



module alu_control(

input [1:0] alu_op,
input [2:0] funct3,
input funct7_5,
output reg [3:0] alu_control

    );
    
always @(*) begin
    case (alu_op)

        // lw, sw: add
        2'b00: begin
            alu_control = 4'b0000;
        end

        // beq: subtract
        2'b01: begin
            alu_control = 4'b0001;
        end

        // R-type ///////////////////
        2'b10: begin
            case (funct3)

            3'b000: begin
            if (funct7_5 == 1'b1)
                alu_control = 4'b0001; // SUB
            else
                alu_control = 4'b0000; // ADD
            end

            3'b001: begin
                alu_control = 4'b0110; // SLL
                end

            3'b010: begin
                alu_control = 4'b0101; // SLT
                end

            3'b011: begin
                alu_control = 4'b0111; // SLTU
                end

            3'b100: begin
                alu_control = 4'b0100; // XOR
                end

            3'b101: begin
                if (funct7_5 == 1'b1)
                    alu_control = 4'b1001; // SRA
                else
                    alu_control = 4'b1000; // SRL
                end

            3'b110: begin
                alu_control = 4'b0011; // OR
            end

            3'b111: begin
                alu_control = 4'b0010; // AND
            end

            default: begin
                alu_control = 4'b0000;
            end

        endcase
    end
        
        // i type ///////////////////
        2'b11: begin
    case (funct3)

        3'b000: begin
                alu_control = 4'b0000; // ADDi
        end

        3'b001: begin
            alu_control = 4'b0110; // SLLi
        end

        3'b010: begin
            alu_control = 4'b0101; // SLTi
        end

        3'b011: begin
            alu_control = 4'b0111; // SLTiU
        end

        3'b100: begin
            alu_control = 4'b0100; // XORi
        end

        3'b101: begin
            if (funct7_5 == 1'b1)
                alu_control = 4'b1001; // SRAi
            else
                alu_control = 4'b1000; // SRLi
        end

        3'b110: begin
            alu_control = 4'b0011; // ORi
        end

        3'b111: begin
            alu_control = 4'b0010; // ANDi
        end

        default: begin
            alu_control = 4'b0000;
        end

    endcase
end

        default: begin
            alu_control = 4'b0000;
        end

    endcase
end
endmodule


//funct7_5의 경우 funct3이 000일때 즉 R-TYPE일 때 +인지 -인지 판단용으로 필요하다.
// R,I TYPE의 경우 alu_op가 10인지 11인지의 유무이고 alu source가 1인지 0인지에 따라 달라짐.