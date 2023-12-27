
module testbench;
    reg [3:0] A;
    reg  [3:0] B;
    wire [3:0] C;
    
    and_operation uut (
        .A(A),
        .B(B),
        .C(C)
    );
      initial 
  begin
    $dumpfile("waveform1.vcd");
    $dumpvars(0,testbench);
  end

    initial begin
        // Test case 1
        A = 4'b1101;
        B = 4'b1011;
        #10; 
        $display("A = %b, B = %b, C = %b", A, B, C);
        #10;
        A = 4'b1100;
        B = 4'b1011;
        #10; 
        $display("A = %b, B = %b, C = %b", A, B, C);
        
        $finish;
    end
endmodule
