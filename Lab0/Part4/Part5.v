module Part5(SW, HEX0);
input [9:0] SW;
output [6:0] HEX0;

assign A = SW[7:6];
assign B = SW[5:4];
assign C = SW[3:2];
assign D = SW[1:0];
assign S = SW[9:8];

mux mux_1(A,B,C,D,S,Y);

decoder decode_1(Y,O);

assign HEX0 = O;

endmodule

module decode_1(U, V);
input [1:0] U;
output [6:0] V;
wire [1:0] c;
assign c[1:0] = U[1:0];

wire [7:0] dtop0_out,dbottom0_out,dmid0_out;


decoder dtop0(
.I0(7'b0100001),
.I1(7'b0000110),
.S(c[0]),
.Y(dtop0_out)
);

decoder dbottom0(
.I0(7'b1111001),
.I1(7'b1000000),
.S(c[0]),
.Y(dbottom0_out)
);

decoder dmid0(
.I0(dtop0_out),
.I1(dbottom0_out),
.S(c[1]),
.Y(dmid0_out)
);

assign HEX0[6:0] = mid0_out;

endmodule 

module decoder(I0,I1,S,Y);
input [7:0] I0,I1;
input S;
output [7:0] Y;
wire [7:0] m;

	assign m[0] = (~S & I0[0]) | (S & I1[0]);
	assign m[1] = (~S & I0[1]) | (S & I1[1]);
	assign m[2] = (~S & I0[2]) | (S & I1[2]);
	assign m[3] = (~S & I0[3]) | (S & I1[3]);
	assign m[4] = (~S & I0[4]) | (S & I1[4]);
	assign m[5] = (~S & I0[5]) | (S & I1[5]);
	assign m[6] = (~S & I0[6]) | (S & I1[6]);
 
	assign Y = m;
	
endmodule 

module mux_1(A,B,C,D,S,Y);
input [1:0] A,B,C,D,S;
output [1:0] Y;
wire [1:0] mtop0_out, mbottom0_out, mmid0_out;
mux4to2 mtop0(
.I0(A),
.I1(B),
.S(S[0]),
.Y(mtop0_out)
);

mux4to2 mbottom0(
.I0(C),
.I1(D),
.S(S[0]),
.Y(mbottom0_out)
);

mux4to2 mmid0(
.I0(mtop0_out),
.I1(mbottom0_out),
.S(S[1]),
.Y(mmid0_out)
);

assign Y = mmid0_out;

endmodule 


module mux4to2(I0,I1,S,Y);
input [1:0] I0,I1;
input S;
output [1:0] Y;
wire [1:0] m;

	assign m[0] = (~S & I0[0]) | (S & I1[0]);
	assign m[1] = (~S & I0[1]) | (S & I1[1]);

 
	assign Y = m;
	
endmodule 
