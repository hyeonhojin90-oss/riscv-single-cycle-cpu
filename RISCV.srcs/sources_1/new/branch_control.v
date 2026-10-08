`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2026/08/10 16:48:19
// Design Name: 
// Module Name: branch
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


module branch_control(
    input zero,
    input branch,
    input [31:0] read_data1,
    input [31:0] read_data2,
    input [2:0] funct3,
    output reg pc_src
       );
       
always @(*) begin
    pc_src = 1'b0;
    
    if (branch) begin
        case (funct3)
            3'b000: begin //beq
            pc_src= zero;
            end
    
            3'b001: begin // bne
            pc_src= ~zero;
            end
    
            3'b100: begin
            pc_src = ($signed(read_data1) < $signed(read_data2));    // blt : branch less than
            end

            3'b101: begin
                pc_src = ($signed(read_data1) >= $signed(read_data2));   // bge : branch greater or equal
            end

            3'b110: begin
                pc_src = (read_data1 < read_data2);         // bltu : blt unsigned
            end

            3'b111: begin
                pc_src = (read_data1 >= read_data2);        // bgeu : bge unsigned
            end

            default: begin
                pc_src = 1'b0;
            end
        endcase
    end
end

endmodule



