`timescale 1ns / 1ps

module register_file_tb;

reg clk;
reg reg_write;
reg [4:0] rs1;
reg [4:0] rs2;
reg [4:0] rd;
reg [31:0] write_data;
wire [31:0] read_data1;
wire [31:0] read_data2;

register_file uut (
    .clk(clk),
    .reg_write(reg_write),
    .rs1(rs1),
    .rs2(rs2),
    .rd(rd),
    .write_data(write_data),
    .read_data1(read_data1),
    .read_data2(read_data2)
);

initial begin
    clk = 0;
    forever #5 clk = ~clk;
end

initial begin
    reg_write = 0;
    rs1 = 0;
    rs2 = 0;
    rd = 0;
    write_data = 0;
    #10;

    // x1 = 10 저장
    reg_write = 1;
    rd = 5'd1;
    write_data = 32'd10;
    #10;

    // x2 = 20 저장
    rd = 5'd2;
    write_data = 32'd20;
    #10;

    // x1, x2 읽기
    reg_write = 0;
    rs1 = 5'd1;
    rs2 = 5'd2;
    #10;

    // x0에 99를 써보려고 함
    reg_write = 1;
    rd = 5'd0;
    write_data = 32'd99;
    #10;

    // x0 읽기
    reg_write = 0;
    rs1 = 5'd0;
    #10;

    $finish;
end

endmodule