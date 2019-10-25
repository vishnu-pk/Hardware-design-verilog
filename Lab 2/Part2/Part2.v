module Part2(SW, HEX0, HEX1);

input [9:0] SW;
output [6:0] HEX0, HEX1;

wire [3:0] AA , BB;
wire [6:0] X , Y;
//btod btod1(SW[4:0],A,B);
//mux2to1 mhex1(4'b0000, 4'b0001,A[0], Y);

btod btod1(SW[3:0], AA,BB);
decoder hex0(BB,X);
decoder hex1(AA,Y);
assign HEX0 = X;
assign HEX1 = Y;



endmodule 

module btod (bcd, Y , Z);
input [3:0] bcd;
output [3:0] Y, Z;
wire A,B,C,D,E,F;

assign A = 0;
assign B = 0;
assign C = bcd[3];
assign D = bcd[2];
assign E = bcd[1];
assign F = bcd[0];

assign Y[3] = 0;
assign Y[2] = (A & C) | (B & D);
assign Y[1] = (~A & B & D) | (~A & B & C) | (B & C & D) | (A & ~B & ~C);
assign Y[0] = (A & ~B & ~C) | (A & ~C & E) | (A & ~C & D) | (~A & ~B & C & E) | (~A & ~B & C & D) | (~A & C & D & E) | (~A & B & ~C & ~D) | (A & B & C & ~D);

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
