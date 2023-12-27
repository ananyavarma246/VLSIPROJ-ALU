module decoder(
    input S0,
    input S1,
    output D0,D1,D2,D3
);
wire Y1,Y2;
not(Y1,S0);
not(Y2,S1);
and(D0,Y1,Y2);
and(D1,S0,Y2);
and(D2,Y1,S1);
and(D3,S0,S1);

endmodule

`timescale 1ns/1ps

module testbench;

  // Inputs
  reg S0, S1;
  
  // Outputs
  wire D0, D1, D2, D3;
  
  // Instantiate the decoder module
  decoder uut (
    .S0(S0),
    .S1(S1),
    .D0(D0),
    .D1(D1),
    .D2(D2),
    .D3(D3)
  );

  // Clock generation
  reg clk = 0;
  always #5 clk = ~clk;

  // Stimulus
  initial begin
    // Test Case 1
    S0 = 0;
    S1 = 0;
    #10;
    
    // Test Case 2
    S0 = 0;
    S1 = 1;
    #10;
    
    // Test Case 3
    S0 = 1;
    S1 = 0;
    #10;
    
    // Test Case 4
    S0 = 1;
    S1 = 1;
    #10;
    
    // Finish simulation
    $finish;
  end

  // Monitor
  always @(posedge clk) begin
    $display("S0=%b, S1=%b, D0=%b, D1=%b, D2=%b, D3=%b", S0, S1, D0, D1, D2, D3);
  end

endmodule
