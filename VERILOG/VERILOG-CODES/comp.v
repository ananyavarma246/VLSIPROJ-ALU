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

