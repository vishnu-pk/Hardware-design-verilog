module Part2(SW, LEDR, HEX5, HEX4);
input [9:0] SW;
output [9:0] LEDR;
output [6:0] HEX5, HEX4;
wire [5:0] Sum, Sum1;
wire [4:0] A, B, S, U, V;
wire [6:0] bcd,X, Y, Z;
wire C, coutn;


assign A = SW[9:5];
assign B = SW[4:0];
//Y = A + B;

fivefa ffa1(A,B,S,C)  ;
// Y -20 
//assign bcd = {C , S};

assign gr = 0; //(bcd < 20);

/*
assign Sum[4] = (S[4]^gr);
assign Sum[3] = (S[3]^gr);
assign Sum[2] = (S[2]^gr);
assign Sum[1] = (S[1]^gr);
assign Sum[0] = (S[0]^gr);
*/


assign bcd ={C, S};
//assign LEDR[9:4] = bcd;

assign Sum[5] = bcd[5] ^ gr;
assign Sum[4] = bcd[4] ^ gr;
assign Sum[3] = bcd[3] ^ gr;
assign Sum[2] = bcd[2] ^ gr;
assign Sum[1] = bcd[1] ^ gr;
assign Sum[0] = bcd[0] ^ gr;

sixfa sixfa1(Sum,{5'b00000, gr}, Sum1, coutn);


minus20 m1(Sum1, Z);

//btod btod1(Z, U, V);

//checknine inputs2(A, B, er1); 
assign U = {1'b0,1'b0,Z[5],Z[4]};
assign V = Z[3:0];

decoder d1(U, X); //U

decoder d2(V, Y); //V

assign HEX4 =Y;
assign HEX5 =X;

//assign LEDR [9:4] = bcd;
//assign LEDR [0] = gr;
//assign LEDR[2] = C;
endmodule

//5 -bit full adder 
module fivefa(a,b,s,c);
input [4:0] a,b;
output [4:0] s;
output c;
wire cin;
wire [4:0] carry;

assign cin =0;

fa fa1(a[0], b[0], cin, s[0],carry[0]);
fa fa2(a[1], b[1], carry[0], s[1],carry[1]);
fa fa3(a[2], b[2], carry[1], s[2],carry[2]);
fa fa4(a[3], b[3], carry[2], s[3],carry[3]);
fa fa5(a[4], b[4], carry[3], s[4],carry[4]);

assign c = carry[4];

endmodule

// 1 - bit full adder
module fa(a,b,cin,s,cout);
input a,b,cin;
output s, cout;

assign s = cin ^ (a ^ b);
assign cout = (a & b) | (cin & (a ^ b));
endmodule  

// 1 - bit full adder
module fs(a,b,cin,s,cout);
input a,b,cin;
output s, cout;

assign s = cin ^ (a ^ b);
assign cout = (~a &  cin) | (~a & b) | (b & cin);
endmodule 


module minus20(a,o);
input [5:0] a;
output [5:0] o;
wire [5:0] b, carry;
wire cin ;
wire [5:0] o1;
assign cin =0;

assign b = 6'b101100;//2's compliment of 20

fa fs1(a[0], b[0], cin, o1[0], carry[0]);
fa fs2(a[1], b[1], carry[0], o1[1], carry[1]);
fa fs3(a[2], b[2], carry[1], o1[2], carry[2]);
fa fs4(a[3], b[3], carry[2], o1[3], carry[3]);
fa fs5(a[4], b[4], carry[3], o1[4], carry[4]);
fa fs6(a[5], b[5], carry[4], o1[5], carry[5]);


assign o = o1;

endmodule

module decoder (bcd, seg);

input [3:0] bcd;
assign a = bcd[3];
assign b = bcd[2];
assign c = bcd[1];
assign d = bcd[0];

output [6:0] seg;

assign seg[0] = (~a & ~b & ~c & d) | (~a & b &  ~c & ~d) | (a & ~b & c & d) | (a & b & ~c & d); //a
assign seg[1] = (b & c & ~d) | (a & c & d) | (a & b & ~d) | (~a & b & ~c & d) ;//b
assign seg[2] = (a & b & ~d) | (a & b & c) | (~a & ~b & c & ~d);//c
assign seg[3] = (b & c & d) | (~a & ~b & ~c & d) | (~a & b & ~c & ~d) | (a & ~b & c & ~d);//d
assign seg[4] = (~a & d) | (~b & ~c & d) | (~a & b & ~c) ;//e
assign seg[5] = (~a & ~b & d) | (~a & ~b & c) | (~a & c & d) | (a & b & ~c & d);//f
assign seg[6] = (~a & ~b & ~c) | (~a & b & c & d) | (a & b & ~c & ~d);//g


endmodule

module sixfa(a,b,s,c);
input [5:0] a,b;
output [5:0] s;
output c;
wire cin;
wire [5:0] carry;

assign cin =0;

fs sfa1(a[0], b[0], cin, s[0],carry[0]);
fs sfa2(a[1], b[1], carry[0], s[1],carry[1]);
fs sfa3(a[2], b[2], carry[1], s[2],carry[2]);
fs sfa4(a[3], b[3], carry[2], s[3],carry[3]);
fs sfa5(a[4], b[4], carry[3], s[4],carry[4]);
fs sfa6(a[5], b[5], carry[4], s[5],carry[5]);

assign c = carry[5];

endmodule

/*
module btod (bcd, Y , Z);
input [4:0] bcd;
output [3:0] Y, Z;
wire A,B,C,D,E,F;

assign A = 0;
assign B = bcd[4];
assign C = bcd[3];
assign D = bcd[2];
assign E = bcd[1];
assign F = bcd[0];
//Most Significant bit
assign Y[3] = 0;
assign Y[2] = (A & C) | (A & B);
assign Y[1] = (~A & B & D) | (~A & B & C) | (B & C & D) | (A & ~B & ~C);
assign Y[0] = (A & ~B & ~C) | (A & ~C & E) | (A & ~C & D) | (~A & ~B & C & E) | (~A & ~B & C & D) | (~A & C & D & E) | (~A & B & ~C & ~D) | (A & B & C & ~D);
//Least Significant bit
assign Z[3] = (~A & ~B & C & ~D & ~E) | (~A & B & ~C & ~D & E) | (~A & B & C & D & ~E) | (A & ~B & ~C & D & E) | (A & B & ~C & ~D & ~E) | (A & B & C & ~D & E);
assign Z[2] = (~A & ~B & ~C & D) | (~B & C & D & E) | (~A & B & C & ~D) | (B & C & ~D & ~E) | (A & ~B & D & ~E) | (A & ~B & ~C & ~D & E) | (A & B & ~C & D & E) | (~A & B & ~D & ~E);
assign Z[1] = (~A & ~B & ~C & E) | (~A & ~C & D & E) | (A & ~B & ~C & ~E) | (~A & C & D & ~E) | (A & ~B & C & E) | (A & C & D & E) | (~A & ~B & C & D & ~E) | (~A & B & ~C & ~D & ~E) | (~A & B & C & ~D & E) | (A & B & C & ~D & ~E);
assign Z[0] = F; 
endmodule
*/