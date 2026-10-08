`timescale 1ns / 1ps

module data_memory(
    input clk,
    input mem_read,
    input mem_write,
    input [31:0] address,
    input [31:0] write_data,
    input [2:0] funct3,
    output [31:0] read_data

    );

reg [31:0] memory [0:255];

always @(posedge clk) begin
    if (mem_write) begin
        case (funct3) 
        3'b000:begin
            memory[address[9:2]][7:0] <= write_data[7:0];
            end
        3'b001:begin
            memory[address[9:2]][15:0] <= write_data[15:0];
            end
        3'b010: begin
            memory[address[9:2]]<=write_data;
            end
    endcase
    end
    end
    
always @(* ) begin 
    if (mem_read) begin 
        case (funct3) 
        3'b000: begin // lb (8bit)
            read_data={{24{memory[address[9:2]][7]}}, memory[address[9:2]][7:0] };
            end
        3'b001: begin // lh (l6bit)
            read_data={{16{memory[address[9:2]][7]}}, memory[address[9:2]][15:0] };
            end
        3'b010: begin // lw (32bit)
            read_data=memory[address[9:2]];
            end 
        3'b100: begin // lb unsigned
            read_data = {24'b0, memory[address[9:2]][7:0]};
            end
        3'b101: begin // lh unsigned
            read_data = {16'b0, memory[address[9:2]][15:0]};
            end
        default: begin
            read_data = 32'd0;
            end
            
            endcase
        end
        
        else begin 
            read_data = 32'b0; // mem_read = 0 , read_data 0할당
            end
       end
            
            
        
// 쓰기 store  : clk 상승엣지에 맞춰 저장
//읽기 load   : 주소와 mem_read가 바뀌면 바로 read_data가 바뀜          
            
      



    
    
    
endmodule


// funct3 000 = sb (8bit)
// funct3 001= sh (16bit)
// funct3 010= sw  (32bit) 