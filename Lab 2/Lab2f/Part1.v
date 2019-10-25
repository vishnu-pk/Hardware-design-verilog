module Part1(SW, LEDR, HEX0, HEX1);
input [9:0] SW;
output [9:0] LEDR;
output [6:0] HEX0, HEX1;
wire [3:0] A, B, S, U, V, Sum, Sum1;
wire CIN, COUT, er1,gr;
wire [4:0] bcd;
wire [6:0] X, Y, G, H;

assign A [3:0] = SW[3:0];
assign B [3:0] = SW[7:4];
assign CIN = SW [8];

fourfa ffa1(A, B, CIN, S, COUT);


assign  gr = (B>A)&(CIN==1);
assign LEDR[7] = gr;
assign Sum[3] = (S[3]^gr);
assign Sum[2] = (S[2]^gr);
assign Sum[1] = (S[1]^gr);
assign Sum[0] = (S[0]^gr);
assign Sum1 = Sum+gr;
assign bcd ={COUT, Sum1};
btod btod1(bcd, U, V);

//checknine inputs2(A, B, er1); 

decoder d1(U, X);

decoder d2(V, Y);

assign LEDR[3:0] = S;
assign LEDR[4] = COUT;
assign LEDR[9] = er1;
assign HEX0 =Y;
assign HEX1 =X;
//decoder input1(A, G);
//decoder input2(B, H);
//assign HEX5 = G;
//assign HEX3 = H;
endmodule

module fourfa(a, b1, cin, s, cout);
input [3:0] a, b1;
input cin;
output [3:0] s;
output cout;
wire [3:0] carry, b, sum;

assign b[3] = (cin ^ b1[3]);
assign b[2] = (cin ^ b1[2]);
assign b[1] = (cin ^ b1[1]);
assign b[0] = (cin ^ b1[0]);

fa fa1(a[0], b[0], cin, sum[0], carry[0]);
fa fa2(a[1], b[1], carry[0], sum[1], carry[1]);
fa fa3(a[2], b[2], carry[1], sum[2], carry[2]);
fa fa4(a[3], b[3], carry[2], sum[3], carry[3]);

assign s [3:0] = sum [3:0];
assign cout = carry[3];


endmodule

module checknine (a, b, o);
input [3:0] a, b;
output o;

//ac + ab
assign o = ((a[3] & a[1]) | (a[3] & a[2])) | ((b[3] & b[1]) | (b[3] & b[2])); 

endmodule

module fa(a,b,cin,s,cout);
input a,b,cin;
output s, cout;

assign s = cin ^ (a ^ b);
assign cout = (a & b) | (cin & (a ^ b));
endmodule 

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


module mux2to1(I0,I1,S,Y);
input [3:0] I0,I1;
input S;
output [3:0] Y;

assign Y = ({4{~S}}&I0) | ({4{S}}&I1);

endmodule 

module decoder (bcd, seg);

input [3:0] bcd;
assign a = bcd[3];
assign b = bcd[2];
assign c = bcd[1];
assign d = bcd[0];

output [6:0] seg;

assign seg[0] = (b & (~c) & (~d)) | ((~a) & (~b) & (~c) & d); //a
assign seg[1] = (b & (~c) & d) | (b & c & (~d));//b
assign seg[2] = (~b) & (~d) & c;//c
assign seg[3] = (b & ~c & ~d) | (b & c & d) | (~a & ~b & ~c & d);//d
assign seg[4] = (d) | (b & ~c);//e
assign seg[5] = (~b & c) | (c & d) | (~a & ~b & d);//f
assign seg[6] = (~a & ~b & ~c) | (b & c & d);//g


endmodule
