module enable(
    input en,
    input [3:0] A,
    input [3:0] B,
    output [3:0]C,
    output [3:0]D
);

and(D[0],B[0],en);
and(D[1],B[1],en);
and(D[2],B[2],en);
and(D[3],B[3],en);

and(C[0],A[0],en);
and(C[1],A[1],en);
and(C[2],A[2],en);
and(C[3],A[3],en);


endmodule

`timescale 1ns/1ps

module testbench;

  // Inputs
  reg en;
  reg [3:0] A;
  reg [3:0] B;
  
  // Outputs
  wire [3:0] C;
  wire [3:0] D;
  
  // Instantiate the enable module
  enable uut (
    .en(en),
    .A(A),
    .B(B),
    .C(C),
    .D(D)
  );

  // Clock generation
  reg clk = 0;
  always #5 clk = ~clk;

  // Stimulus
  initial begin
    // Test Case 1
    en = 0;
    A = 4'b1010;
    B = 4'b1100;
    #10;
    
    // Test Case 2
    en = 1;
    A = 4'b0011;
    B = 4'b1110;
    #10;
    
    // Add more test cases here as needed
    
    // Finish simulation
    $finish;
  end

  // Monitor
  always @(posedge clk) begin
    $display("en=%b, A=%b, B=%b, C=%b, D=%b", en, A, B, C, D);
  end

endmodule
