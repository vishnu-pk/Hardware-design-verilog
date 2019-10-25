// Part 1

/*module Lab1 (SW, LEDR);

	input [9:0] SW;
	output [9:0] LEDR;
	assign LEDR = SW;
	
endmodule 
*/

// Part 2

/*
module Lab1(SW, LEDR);
	
	input [9:0] SW;
	wire [3:0] x, y, m;
	wire s;
	output [9:0] LEDR;
	assign x[3:0]= SW[3:0];
	assign y[3:0]= SW[7:4];
	assign s = SW[9];
	assign m[0] = (~s & x[0]) | (s & y[0]);
	assign m[1] = (~s & x[1]) | (s & y[1]);
	assign m[2] = (~s & x[2]) | (s & y[2]);
	assign m[3] = (~s & x[3]) | (s & y[3]);
	assign LEDR[7:4] = m[3:0];
	
endmodule 
*/

//Part 3


module Lab1 (SW, LEDR);
input [9:0] SW;
output [9:0] LEDR;
wire [7:0] top0_out,bottom0_out,mid0_out;

mux16to8 top0(
.I0(8'hAA),
.I1(8'h55),
.S(SW[0]),
.Y(top0_out)
);

mux16to8 bottom0(
.I0(8'hF0),
.I1(8'h0F),
.S(SW[0]),
.Y(bottom0_out)
);

mux16to8 mid0(
.I0(top0_out),
.I1(bottom0_out),
.S(SW[1]),
.Y(mid0_out)
);

assign LEDR[7:0] = mid0_out;

endmodule 

module mux16to8(I0,I1,S,Y);
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
	assign m[7] = (~S & I0[7]) | (S & I1[7]);
 
	assign Y = m;
	
endmodule 
