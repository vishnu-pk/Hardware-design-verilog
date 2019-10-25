module mux1(SW,LEDR);

input [9:0] SW; // slide switches
output [9:0] LEDR; // red LEDs
wire [7:0] x,y,m;
assign s= SW[9];
assign x [3:0] = SW[7:4];
assign y [3:0] = SW[3:0];
assign m [3:0] = (~s & x[3:0]) | (s & y[3:0]);
assign LEDR [3:0] = m[3:0];
assign LEDR [9:4] = 0;

endmodule 