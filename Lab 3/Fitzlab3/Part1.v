// 
module Part1(KEY,SW,LEDR);
input [9:0] SW;
input [1:0] KEY;
output [9:0] LEDR;
wire clock;
wire [7:0] O,A,x;
wire [7:0] Q;

assign clock = KEY[1];
assign A = SW[7:0];
assign I = SW[9];
mux mux1(A,x,I,O);

reg8 d8bit1(clock,O,Q);

assign LEDR[7:0] = Q[7:0];
assign x = Q;

endmodule

module reg8 (CLK, D, Q);
input CLK;
input [7:0] D;
output [7:0] Q;
reg [7:0] Q;
always @(posedge CLK)
Q = D;

endmodule

module mux (I0,I1,S,Y);
input [7:0] I0,I1;
input S;
output [7:0] Y;
wire [7:0] o;

	assign o[0] = (~S & I0[0]) | (S & I1[0]);
	assign o[1] = (~S & I0[1]) | (S & I1[1]);
	assign o[2] = (~S & I0[2]) | (S & I1[2]);
	assign o[3] = (~S & I0[3]) | (S & I1[3]);
	assign o[4] = (~S & I0[4]) | (S & I1[4]);
	assign o[5] = (~S & I0[5]) | (S & I1[5]);
	assign o[6] = (~S & I0[6]) | (S & I1[6]);
	assign o[7] = (~S & I0[7]) | (S & I1[7]);
 
assign Y[7:0] = o[7:0]; 
	
endmodule
