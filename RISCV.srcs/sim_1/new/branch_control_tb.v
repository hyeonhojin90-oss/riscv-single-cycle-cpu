`timescale 1ns / 1ps

module branch_control_tb;

reg branch;
reg [2:0] funct3;
reg [31:0] read_data1;
reg [31:0] read_data2;
reg zero;
wire pc_src;

branch_control uut (
    .branch(branch),
    .funct3(funct3),
    .read_data1(read_data1),
    .read_data2(read_data2),
    .zero(zero),
    .pc_src(pc_src)
);

initial begin
    $monitor("time=%0t branch=%b funct3=%b read1=%d read2=%d zero=%b pc_src=%b",
             $time, branch, funct3, read_data1, read_data2, zero, pc_src);

    branch = 0;
    funct3 = 3'b000;
    read_data1 = 32'd5;
    read_data2 = 32'd5;
    zero = 1;
    #20;

    branch = 1;

    //beq(o)
    funct3 = 3'b000;
    read_data1 = 32'd5;
    read_data2 = 32'd5;
    zero = 1;
    #20;

    // beq(x)
    funct3 = 3'b000;
    read_data1 = 32'd5;
    read_data2 = 32'd3;
    zero = 0;
    #20;

    // bne (x)
    funct3 = 3'b001;
    read_data1 = 32'd5;
    read_data2 = 32'd5;
    zero = 1;
    #20;

    // bne (x)
    funct3 = 3'b001;
    read_data1 = 32'd5;
    read_data2 = 32'd5;
    zero = 1;
    #20;

    // BLT signed: -1 < 1 (o)
    funct3 = 3'b100;
    read_data1 = 32'hFFFFFFFF;
    read_data2 = 32'd1;
    
    #20;

    // BGE signed: -1 >= 1 (x)
    funct3 = 3'b101;
    read_data1 = 32'hFFFFFFFF;
    read_data2 = 32'd1;
    
    #20;

    // BLTU unsigned: 4294967295 < 1 (x)
    funct3 = 3'b110;
    read_data1 = 32'hFFFFFFFF;
    read_data2 = 32'd1;
    
    #20;

    // BGEU unsigned: 4294967295 >= 1 Âü
    funct3 = 3'b111;
    read_data1 = 32'hFFFFFFFF;
    read_data2 = 32'd1;
    
    #20;

    $finish;
end

endmodule