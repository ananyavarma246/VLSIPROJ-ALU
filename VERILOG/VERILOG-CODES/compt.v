module testbench;

  reg [3:0] A;
  reg [3:0] B;
  wire C1, C2, C3;

  // Instantiate the comparator module
  comp uut (
    .A(A),
    .B(B),
    .C1(C1),
    .C2(C2),
    .C3(C3)
  );
  initial 
  begin
    $dumpfile("waveform2.vcd");
    $dumpvars(0,testbench);
  end

  initial begin
    // Test case 1: A is greater than B
    A = 4'b1100;
    B = 4'b1010;
    #100 $display("A = %b, B = %b, C1 = %b, C2 = %b, C3 = %b", A, B, C1, C2, C3);

    // Test case 2: A is equal to B
    A = 4'b0101;
    B = 4'b0101;
    #100 $display("A = %b, B = %b, C1 = %b, C2 = %b, C3 = %b", A, B, C1, C2, C3);

    // Test case 3: A is less than B
    A = 4'b0010;
    B = 4'b1100;
    #100 $display("A = %b, B = %b, C1 = %b, C2 = %b, C3 = %b", A, B, C1, C2, C3);

    // Finish simulation
    $finish;
  end

endmodule
