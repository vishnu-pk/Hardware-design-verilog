module Part3(SW,LEDR);
input [9:0] SW;
output [9:0] LEDR;
wire [3:0] A, B, S;
wire CIN, COUT;

assign A = SW[3:0];
assign B = SW[7:4];
assign CIN = SW [8];

fourfa ffa1(A,B,CIN,S,COUT);

assign LEDR[3:0] = S;
assign LEDR[5] = COUT;
endmodule

module fourfa(a,b,cin,s,cout);
input [3:0] a,b;
input cin;
output [3:0] s;
output cout;
wire [3:0] carry, sum;

fa fa1(a[0], b[0], cin, sum[0],carry[0]);
fa fa2(a[1], b[1], carry[0], sum[1],carry[1]);
fa fa3(a[2], b[2], carry[1], sum[2],carry[2]);
fa fa4(a[3], b[3], carry[2], sum[3],carry[3]);

assign cout = carry[3];
assign s = sum;

endmodule

module fa(a,b,cin,s,cout);
input a,b,cin;
output s, cout;

assign s = cin ^ (a ^ b);
assign cout = (a & b) | (cin & (a ^ b));
endmodule  
