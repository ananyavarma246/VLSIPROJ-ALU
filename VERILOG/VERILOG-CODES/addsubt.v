`timescale 1ns/1ns

module testbench;

  // Inputs
  reg [3:0] A;
  reg [3:0] B;
  reg M;
  
  // Outputs
  wire [3:0] S;
  wire C;
  
  // Instantiate the addsub module
  addsub uut (
    .A(A),
    .B(B),
    .M(M),
    .S(S),
    .C(C)
  );

  // Clock generation
  reg clk = 0;
  always begin
    #5 clk = ~clk;
  end
  initial 
  begin
    $dumpfile("waveform.vcd");
    $dumpvars(0,testbench);
  end

  // Test vectors
  initial begin
    // Test Case 1: Addition (M = 0)
    A = 4'b0000;
    B = 4'b1010;
    M = 1'b0;
    #10; // Allow some time for the circuit to settle
    $display("Test Case 1 - Addition:");
    $display("A = %b", A);
    $display("B = %b", B);
    $display("M = %b", M);
    $display("S = %b", S);
    $display("C = %b", C);
   

    // Test Case 2: Subtraction (M = 1)
    A = 4'b0011;
    B = 4'b0100;
    M = 1'b1;
    #10; // Allow some time for the circuit to settle
    $display("\nTest Case 2 - Subtraction:");
    $display("A = %b", A);
    $display("B = %b", B);
    $display("M = %b", M);
    $display("S = %b", S);
    $display("C = %b", C);

    // Add more test cases as needed

    $finish;
  end

endmodule
