module Part2(KEY,SW,LEDR);
input [9:0] SW;
input [1:0] KEY;
output [9:0] LEDR;
wire clock;
wire [7:0] O,A,x,y;
wire [7:0] Q,Q_bar;
wire [1:0] I;

assign clock = KEY[1];
assign A = SW[7:0];
assign I = SW[9:8];
mux mux1(A,x,y,I,O);

reg8 d8bit1(clock,O,Q,Q_bar);

assign LEDR[7:0] = Q[7:0];
assign x = Q;
assign y = Q_bar;
endmodule

module reg8 (CLK, D, Q, Q_bar);
input CLK;
input [7:0] D;
output [7:0] Q,Q_bar;
reg [7:0] Q,Q_bar;
always @(posedge CLK)
begin
Q <= D;
Q_bar <= ~D;
end
endmodule

module mux (I0,I1,notI,S,Y);
input [7:0] I0,I1,notI;
input [1:0] S;
output [7:0] Y;
wire [7:0] top, bottom, mid;

/*
assign notI[0] = ~I1[0];
assign notI[1] = ~I1[1];
assign notI[2] = ~I1[2];
assign notI[3] = ~I1[3];
assign notI[4] = ~I1[4];
assign notI[5] = ~I1[5];
assign notI[6] = ~I1[6];
assign notI[7] = ~I1[7];
*/

mux_element(I1,8'h00,S[1],top);
mux_element(I0, notI, S[1], bottom);
mux_element(top,bottom,S[0],mid);


assign Y = mid;
endmodule




module mux_element (I0,I1,S,Y);
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
