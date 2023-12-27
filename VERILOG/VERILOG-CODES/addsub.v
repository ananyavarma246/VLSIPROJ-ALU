module full_adder(
    input a,
    input b,
    input cin,
    output s,
    output c);

wire y1,y2,y3;
xor(y1,a,b);
and(y2,a,b);
xor(s,y1,cin);
and(y3,y1,cin);
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
