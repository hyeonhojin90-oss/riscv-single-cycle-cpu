`timescale 1ns / 1ps

module tb_AUL;

reg [31:0] a;
reg [31:0] b;
reg [3:0] alu_control;
wire [31:0] result;
wire zero;

ALU uut (
    .a(a),
    .b(b),
    .alu_control(alu_control),
    .result(result),
    .zero(zero)
    
    );
    
    initial begin 
    
    $monitor("time=%0t alu_control=%b a=%d b=%d result=%d signed_result=%d ",
         $time, alu_control, a, b, result,$signed(result));
    
    a=32'd10;
    b=32'd5;
    alu_control=4'b0000; // +
    #20;
    
    a=32'd10;
    b=32'd5;
    alu_control=4'b0001; //-
    #20;
    
    a=32'd10;
    b=32'd10;
    alu_control=4'b0010; //and
    #20;
    
    a = 32'b1010;
    b = 32'b1100;
    alu_control = 4'b0011; //or
    #20;
    
    a = 32'b1100;
    b = 32'b1100;
    alu_control = 4'b0011; // or
    #20;
    
    a = 32'b0011;
    b = 32'b1100;
    alu_control = 4'b0100; // xor 
    #20;
    
    a = 32'h80000000; // 
    b = 32'h00000000; //
    alu_control = 4'b0101; // slt  ( set less than) 
    #20;
    
    a = 32'h80000000; // 
    b = 32'h00000000; //
    alu_control = 4'b0111; // sltu  ( set less than unsigned ) 
    #20;
    
    a = 32'd3;
    b = 32'd2;
    alu_control = 4'b0110; // sll 
    #20;
    
    a = 32'hc0000000;
    b = 32'd2;
    alu_control = 4'b1000; // srl
    #20;
    
    a = 32'hc0000000;
    b = 32'd2;
    alu_control = 4'b1001; // sra
    #20;

    $finish;
end

endmodule
    