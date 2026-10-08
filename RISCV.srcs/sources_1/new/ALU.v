module ALU (
    input [31:0] a,
    input [31:0] b,
    input [3:0] alu_control,
    output reg [31:0] result,
    output zero 
    );
    
    always @(*) begin
    case (alu_control) 
    //R-TYPE
    4'b0000: result=a+b; // +
    4'b0001: result=a-b; // - 
    4'b0010: result=a&b; // and
    4'b0011: result=a|b; // or 
    4'b0100: result=a^b; // xor
    4'b0111: result= (a<b) ? 32'd1 : 32'd0; // set less than unsigned (sltu)
    4'b0101: result= ($signed(a)<$signed(b)) ? 32'd1 : 32'd0; // slt
    4'b0110: result= a<<b[4:0]; // Shift Left Logical (sll)
    4'b1000: result= a>>b[4:0]; // Shift Right Logical (srl)
    4'b1001: result= $signed(a)>>>b[4:0]; // Shift Right Arithmetic
    default: result= 32'd0;
    
    endcase
    end
   
    
    assign zero = (result == 32'd0 ) ;
    
 
  endmodule
     