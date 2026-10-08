`timescale 1ns / 1ps


module instruction_memory(
    input [31:0] address,
    output [31:0] instruction

    );

reg [31:0] memory [0:255];

initial begin
    $readmemh("C:/Users/20222967/RISCV/instruction.hex.txt", memory);

   end

assign instruction= memory[address[9:2]]; //address는 결국 pc의 주소
    
endmodule
