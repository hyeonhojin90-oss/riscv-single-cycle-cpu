`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2026/08/09 19:06:16
// Design Name: 
// Module Name: pc_tb
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

module pc_tb;

reg clk;
reg reset;
reg [31:0] next_pc;
wire [31:0] pc;

pc uut (
    .clk(clk),
    .reset(reset),
    .next_pc(next_pc),
    .pc(pc)
);

initial begin
    clk = 0;
    forever #5 clk = ~clk;
end

initial begin
    reset = 1;
    next_pc = 32'd0;
    #20;

    reset = 0;

    next_pc = 32'd4;
    #10;

    next_pc = 32'd8;
    #10;

    next_pc = 32'd12;
    #10;

    next_pc = 32'd16;
    #10;

    $finish;
end

endmodule