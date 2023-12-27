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

module enable(
    input en,
    input [3:0] A,
    input [3:0] B,
    output [3:0]C,
    output [3:0]D
);
wire Y1,Y2,Y3,Y4,Y5,Y6,Y7,Y8;

and(D[0],B[0],en);
and(D[1],B[1],en);
and(D[2],B[2],en);
and(D[3],B[3],en);

and(C[0],A[0],en);
and(C[1],A[1],en);
and(C[2],A[2],en);
and(C[3],A[3],en);


endmodule

module comp(
    input [3:0] A,
    input [3:0] B,
    output C1,C2,C3
);

wire Y1,Y2,Y3,Y4,Y5,Y6,Y7,Y8,Y9,Y10,Y11,Y12,Y13,Y14,Y15,Y16,Y17,Y18,Y19,Y20;

// FOR EQUAL 
xnor (Y1,A[0],B[0]);
xnor (Y2,A[1],B[1]);
xnor (Y3,A[2],B[2]);
xnor (Y4,A[3],B[3]);
and(C2,Y1,Y2,Y3,Y4);

// FOR GREATER THAN 
not(Y5,B[0]);
not(Y6,B[1]);
not(Y7,B[2]);
not(Y8,B[3]);

and(Y9,A[3],Y8);
and(Y10,Y4,A[2],Y7);
and(Y11,A[1],Y6,Y3,Y4);
and(Y12,A[0],Y5,Y2,Y3,Y4);
or(C1,Y9,Y10,Y11,Y12);

//FOR LESS THAN
not(Y13,A[0]);
not(Y14,A[1]);
not(Y15,A[2]);
not(Y16,A[3]);

and(Y17,Y16,B[3]);
and(Y18,Y15,B[2],Y4);
and(Y19,B[1],Y14,Y4,Y3);
and(Y20,B[0],Y13,Y4,Y3,Y2);
or(C3,Y17,Y18,Y19,Y20);

endmodule

module full_adder(
    input a,
    input b,
    input cin,
    output s,
    output c);

wire y1,y2,y3;
and(y2,a,b);
xor(y1,a,b);
and(y3,y1,cin);
xor(s,y1,cin);
or(c,y2,y3);

endmodule


module addsub (
    input [3:0] A,
    input [3:0] B,
    input  M,
    output [3:0] S,
    output  C
);

wire Y1,Y2,Y3,Y4,S0,C1,S1,S2,C2,C3,S3;
xor(Y1,B[0],M);
full_adder f0 (A[0],Y1,M,S0,C1);
xor(Y2,B[1],M);
full_adder f1(A[1],Y2,C1,S1,C2);
xor(Y3,B[2],M);
full_adder f2(A[2],Y3,C2,S2,C3);
xor(Y4,B[3],M);
full_adder f3(A[3],Y4,C3,S3,C);

assign S[0]=S0;
assign S[1]=S1;
assign S[2]=S2;
assign S[3]=S3;

endmodule

module and_operation (
    input [3:0] A,
    input [3:0] B,
    output [3:0] C 
);

and(C[0],A[0],B[0]);
and(C[1],A[1],B[1]);
and(C[2],A[2],B[2]);
and(C[3],A[3],B[3]);

endmodule

module alu(
    input S0, S1,
    input [3:0] A,
    input [3:0] B,
    output C1, C2, C3,
    output [3:0] S,
    output [3:0] SS,
    output CAS,
    output CA,
    output [3:0] R
);
  wire D0, D1, D2, D3;
  decoder de0(S0, S1, D0, D1, D2, D3);

  reg en;  
  wire M;  

  or(M,0,S0);

  wire [3:0] C,D,E,F,G,H,I,J;

  enable e0(D0, A, B, C, D);
  addsub adsu0(C, D, M, S, CA);

  enable e1(D1, A, B, E, F);
  addsub adsu1(E, F, M, SS, CAS);

  enable e2(D2, A, B, G, H);
  comp comp0(G,H, C1, C2, C3);

  enable e3(D3, A, B,I,J);
  and_operation an0(I, J, R);

endmodule

module alu_tb;
  reg S0, S1;
  reg [3:0] A, B;
  wire C1, C2, C3;
  wire [3:0] S, SS;
  wire CAS, CA;
  wire [3:0] R;

  alu uut(S0, S1, A, B, C1, C2, C3, S, SS, CAS, CA, R);

  initial 
  begin
    $dumpfile("waveform3.vcd");
    $dumpvars(0,alu_tb);
  end


  initial begin

    S0 = 0;
    S1 = 0;
    A = 4'b1111;
    B = 4'b1111;
    #10;
   
    $display("Test Case 1 - Addition:");
    $display("S0 = %b, S1 = %b", S0, S1);
    $display("A = %b, B = %b", A, B);
    $display("C1 = %b, C2 = %b, C3 = %b", C1, C2, C3);
    $display("S = %b, SS = %b, CAS = %b, CA = %b", S, SS, CAS, CA);
    $display("R = %b", R);

    S0 = 1;
    S1 = 0;
    A = 4'b1000;
    B = 4'b0111;
    #10;
    $display("Test Case 2 - Subtraction:");
    $display("S0 = %b, S1 = %b", S0, S1);
    $display("A = %b, B = %b", A, B);
    $display("C1 = %b, C2 = %b, C3 = %b", C1, C2, C3);
    $display("S = %b, SS = %b, CAS = %b, CA = %b", S, SS, CAS, CA);
    $display("R = %b", R);


    S0 = 0;
    S1 = 1;
    A = 4'b1010;
    B = 4'b0110;
    #10;
    $display("Test Case 2 - Comparator:");
    $display("S0 = %b, S1 = %b", S0, S1);
    $display("A = %b, B = %b", A, B);
    $display("C1 = %b, C2 = %b, C3 = %b", C1, C2, C3);
    $display("S = %b, SS = %b, CAS = %b, CA = %b", S, SS, CAS, CA);
    $display("R = %b", R);

    
    S0 = 1;
    S1 = 1;
    A = 4'b1010;
    B = 4'b0110;
    #10;
    $display("Test Case 2 - Logical And:");
    $display("S0 = %b, S1 = %b", S0, S1);
    $display("A = %b, B = %b", A, B);
    $display("C1 = %b, C2 = %b, C3 = %b", C1, C2, C3);
    $display("S = %b, SS = %b, CAS = %b, CA = %b", S, SS, CAS, CA);
    $display("R = %b", R);

    $finish;
  end

endmodule




