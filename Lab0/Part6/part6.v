module part6(SW, HEX0, HEX1, HEX2, HEX3, HEX4, HEX5);
input [9:0] SW;
output [6:0] HEX0, HEX1, HEX2, HEX3, HEX4, HEX5;
//output [9:0] LEDR;
wire [2:0] A,B,C,D,S;

assign A = SW[9]; 
assign B = SW[8];
assign C = SW[7];
/*
assign LEDR[7:6] = A;
assign LEDR[5:4] = B;
assign LEDR[3:2] = C;
assign LEDR[1:0] = D;
assign LEDR[9:8] = S;
*/
wire [6:0] W,W1,W2,W3,W4,W5;
wire [2:0] Y,connector;

mux_1 mux1(
.AA(A),
.BB(B),
.CC(C),
.YY(Y)
);
 
//assign LEDR[9:8] = Y;
assign connector = Y;

part4 decoder1(
.U(connector),
.V(W)
);

for_hex1(connector,W1);
for_hex2(connector,W2);
for_hex3(connector,W3);
for_hex4(connector,W4);
for_hex5(connector,W5);

assign HEX0 = W;
assign HEX1 = W1;
assign HEX2 = W2;
assign HEX3 = W3;
assign HEX4 = W4;
assign HEX5 = W5;

endmodule 


module part4(U, V);
//input [9:0] SW;
//output [6:0] HEX0;

input [2:0] U;
output [6:0] V;
//wire [1:0] U;
//assign U = SW[1:0];
//assign c[1:0] = U[1:0];


wire [6:0] dtop0_out,dbottom0_out,dmid0_out,dmid1_out,drear_out;

assign d = 7'b0100001;
assign e = 7'b0000110;
assign one = 7'b1111001;
assign zero = 7'b1000000;
assign b = 7'b1111111;
assign b1 = 7'b1111111;


decode2to7 dtop0(
.I0(d),
.I1(e),
.S(U[0]),
.Y(dtop0_out)
);

decode2to7 dbottom0(
.I0(one),
.I1(zero),
.S(U[0]),
.Y(dbottom0_out)
);

decode2to7 dmid0(
.I0(dtop0_out),
.I1(dbottom0_out),
.S(U[1]),
.Y(dmid0_out)
);

decode2to7 drear1(
.I0(b),
.I1(b1),
.S(U[1]),
.Y(drear_out)
);

decode2to7 dmid1(
.I0(dmid0_out),
.I1(drear_out),
.S(U[2]),
.Y(dmid1_out)
);


assign V = dmid1_out;

endmodule 

module decode2to7(I0,I1,S,Y);
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
	//assign m[7] = (~S & I0[7]) | (S & I1[7]);
 
	assign Y = m;
	
endmodule 



//MUX
module mux_1(AA,BB,CC,YY);
input [2:0] AA,BB,CC;
output [2:0] YY;


wire [2:0] mtop0_out, mbottom0_out, mmid0_out,mmid1_out, mrear0_out,c, off1;
assign c[2] = AA;
assign c[1] = BB;
assign c[0] = CC;

assign off1 = 3'b100;

mux4to2 mtop0(
.I0(3'b000),
.I1(3'b001),
.S(c[0]),
.Y(mtop0_out)
);

mux4to2 mbottom0(
.I0(3'b010),
.I1(3'b011),
.S(c[0]),
.Y(mbottom0_out)
);


mux4to2 mmid0(
.I0(mtop0_out),
.I1(mbottom0_out),
.S(c[1]),
.Y(mmid0_out)
);

mux4to2 mrear0(
.I0(3'b100),
.I1(3'b101),
.S(c[1]),
.Y(mrear0_out)
);

mux4to2 mmid1(
.I0(mmid0_out),
.I1(mrear0_out),
.S(c[2]),
.Y(mmid1_out)
);


assign YY = mmid1_out;

endmodule 

module mux4to2(I0,I1,S,Y);
input [2:0] I0,I1;
input S;
output [2:0] Y;
wire [2:0] m;

	assign m[0] = (~S & I0[0]) | (S & I1[0]);
	assign m[1] = (~S & I0[1]) | (S & I1[1]);
	assign m[2] = (~S & I0[2]) | (S & I1[2]);

 
	assign Y = m;
	
endmodule 

module for_hex1(U, V);
//input [9:0] SW;
//output [6:0] HEX0;

input [2:0] U;
output [6:0] V;
//wire [1:0] U;
//assign U = SW[1:0];
//assign c[1:0] = U[1:0];


wire [6:0] dtop0_out,dbottom0_out,dmid0_out,dmid1_out;

wire [6:0] d,e,b,b1,one,zero;


assign d = 7'b0100001;
assign e = 7'b0000110;
assign one = 7'b1111001;
assign zero = 7'b1000000;
assign b = 7'b1111111;
assign b1 = 7'b1111111;



decode2to7 dtop0(
.I0(7'b1111111),
.I1(7'b0100001),
.S(U[0]),
.Y(dtop0_out)
);

decode2to7 dbottom0(
.I0(7'b0000110),
.I1(7'b1111001),
.S(U[0]),
.Y(dbottom0_out)
);

decode2to7 dmid0(
.I0(dtop0_out),
.I1(dbottom0_out),
.S(U[1]),
.Y(dmid0_out)
);

decode2to7 dmid1(
.I0(dmid0_out),
.I1(7'b1000000),
.S(U[2]),
.Y(dmid1_out)
);


assign V = dmid1_out;

endmodule 

module for_hex2(U, V);
//input [9:0] SW;
//output [6:0] HEX0;

input [2:0] U;
output [6:0] V;
//wire [1:0] U;
//assign U = SW[1:0];
//assign c[1:0] = U[1:0];


wire [6:0] dtop0_out,dbottom0_out,dmid0_out,dmid1_out;
/*
d = 7'b0100001
e = 7'b0000110
1 = 7'b1111001
0 = 7'b1000000
b = 7'b1111111



*/
decode2to7 dtop0(
.I0(7'b1000000),
.I1(7'b1111111),
.S(U[0]),
.Y(dtop0_out)
);

decode2to7 dbottom0(
.I0(7'b0100001),
.I1(7'b0000110),
.S(U[0]),
.Y(dbottom0_out)
);

decode2to7 dmid0(
.I0(dtop0_out),
.I1(dbottom0_out),
.S(U[1]),
.Y(dmid0_out)
);

decode2to7 dmid1(
.I0(dmid0_out),
.I1(7'b1111001),
.S(U[2]),
.Y(dmid1_out)
);


assign V = dmid1_out;

endmodule 

module for_hex3(U, V);
//input [9:0] SW;
//output [6:0] HEX0;

input [2:0] U;
output [6:0] V;
//wire [1:0] U;
//assign U = SW[1:0];
//assign c[1:0] = U[1:0];


wire [6:0] dtop0_out,dbottom0_out,dmid0_out,dmid1_out;
/*
d = 7'b0100001
e = 7'b0000110
1 = 7'b1111001
0 = 7'b1000000
b = 7'b1111111



*/
decode2to7 dtop0(
.I0(7'b1111001),
.I1(7'b1000000),
.S(U[0]),
.Y(dtop0_out)
);

decode2to7 dbottom0(
.I0(7'b1111111),
.I1(7'b0100001),
.S(U[0]),
.Y(dbottom0_out)
);

decode2to7 dmid0(
.I0(dtop0_out),
.I1(dbottom0_out),
.S(U[1]),
.Y(dmid0_out)
);

decode2to7 dmid1(
.I0(dmid0_out),
.I1(7'b0000110),
.S(U[2]),
.Y(dmid1_out)
);


assign V = dmid1_out;

endmodule 

module for_hex4(U, V);
//input [9:0] SW;
//output [6:0] HEX0;

input [2:0] U;
output [6:0] V;
//wire [1:0] U;
//assign U = SW[1:0];
//assign c[1:0] = U[1:0];


wire [6:0] dtop0_out,dbottom0_out,dmid0_out,dmid1_out;
/*
d = 7'b0100001
e = 7'b0000110
1 = 7'b1111001
0 = 7'b1000000
b = 7'b1111111



*/
decode2to7 dtop0(
.I0(7'b0000110),
.I1(7'b1111001),
.S(U[0]),
.Y(dtop0_out)
);

decode2to7 dbottom0(
.I0(7'b1000000),
.I1(7'b1111111),
.S(U[0]),
.Y(dbottom0_out)
);

decode2to7 dmid0(
.I0(dtop0_out),
.I1(dbottom0_out),
.S(U[1]),
.Y(dmid0_out)
);

decode2to7 dmid1(
.I0(dmid0_out),
.I1(7'b0100001),
.S(U[2]),
.Y(dmid1_out)
);


assign V = dmid1_out;

endmodule 

module for_hex5(U, V);
//input [9:0] SW;
//output [6:0] HEX0;

input [2:0] U;
output [6:0] V;
//wire [1:0] U;
//assign U = SW[1:0];
//assign c[1:0] = U[1:0];


wire [6:0] dtop0_out,dbottom0_out,dmid0_out,dmid1_out;
/*
d = 7'b0100001
e = 7'b0000110
1 = 7'b1111001
0 = 7'b1000000
b = 7'b1111111



*/
decode2to7 dtop0(
.I0(7'b0100001),
.I1(7'b0000110),
.S(U[0]),
.Y(dtop0_out)
);

decode2to7 dbottom0(
.I0(7'b1111001),
.I1(7'b1000000),
.S(U[0]),
.Y(dbottom0_out)
);

decode2to7 dmid0(
.I0(dtop0_out),
.I1(dbottom0_out),
.S(U[1]),
.Y(dmid0_out)
);

decode2to7 dmid1(
.I0(dmid0_out),
.I1(7'b1111111),
.S(U[2]),
.Y(dmid1_out)
);


assign V = dmid1_out;

endmodule 