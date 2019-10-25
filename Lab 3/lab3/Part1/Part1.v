// A gated RS latch
module Part1 (KEY, SW, LEDR);
input [9:0] SW;
input [1:0] KEY;
output [9:0] LEDR;
//input Clk, R, S;
//output Q;
wire R, S, Clk;
wire R_g, S_g, Qa, Qb /* synthesis keep */ ;
assign R = SW[0];
assign S = SW[1];
assign Clk = KEY[0];
and (R_g, R, Clk);
and (S_g, S, Clk);
nor (Qa, R_g, Qb);
nor (Qb, S_g, Qa);
assign Q = Qa;
assign LEDR[9] = Q;
endmodule	
