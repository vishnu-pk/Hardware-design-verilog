module Part5(SW,LEDR,KEY,HEX0,HEX1,HEX2,HEX3,HEX4,HEX5);
input [9:0] SW;
input [1:0] KEY;
output [9:0] LEDR;
output [6:0] HEX0,HEX1,HEX2,HEX3,HEX4,HEX5;
wire [7:0] O,A,x,S;
wire [7:0] Q;
wire CIN,COUT;
wire [6:0] de1,de2,de3,de4,de5,de6;

assign CIN=0;
assign A = SW[7:0];
//assign B = SW[7:4];
//assign CIN = SW [8];
assign clock = KEY[1];
assign resetbutton = KEY[0];

reg8 d8bit1(resetbutton,clock,A,Q);


fourfa ffa1(A,Q,CIN,S,COUT);

decoder d1(A[3:0],de1);
decoder d2(A[7:4],de2);
decoder d3(Q[3:0],de3);
decoder d4(Q[7:4],de4);
decoder d5(S[3:0],de5);
decoder d6(S[7:4],de6);


assign HEX0 = de3;
assign HEX1 = de4;
assign HEX2 = de1;
assign HEX3 = de2;
assign HEX4 = de5;
assign HEX5 = de6;



//assign LEDR[3:0] = S;
assign LEDR[0] = COUT;


endmodule

//Full adder 8 bits 
module fourfa(a,b,cin,s,cout);
input [7:0] a,b;
input cin;
output [7:0] s;
output cout;
wire [7:0] carry, sum;


fa fa1(a[0], b[0], cin, sum[0],carry[0]);
fa fa2(a[1], b[1], carry[0], sum[1],carry[1]);
fa fa3(a[2], b[2], carry[1], sum[2],carry[2]);
fa fa4(a[3], b[3], carry[2], sum[3],carry[3]);
fa fa5(a[4], b[4], carry[3], sum[4],carry[4]);
fa fa6(a[5], b[5], carry[4], sum[5],carry[5]);
fa fa7(a[6], b[6], carry[5], sum[6],carry[6]);
fa fa8(a[7], b[7], carry[6], sum[7],carry[7]);

assign cout = carry[7];
assign s = sum;

endmodule
//Full adder Single Bit
module fa(a,b,cin,s,cout);
input a,b,cin;
output s, cout;

assign s = cin ^ (a ^ b);
assign cout = (a & b) | (cin & (a ^ b));
endmodule  

//DECODER for 7-segment display (4 bit to hex)
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

//8-bit D Flipflop
module reg8 (reset, CLK, D, Q);
input reset;
input CLK;
input [7:0] D;
output [7:0] Q;
reg [7:0] Q;
always @(posedge CLK)
if (~reset)
Q = 0;
else
Q = D;
endmodule
