module Part3(SW,KEY,LEDR);
input [9:0] SW;
input[1:0] KEY;
output [9:0] LEDR;
wire A,O,Y,clock;
assign A = SW[0];
assign clock = KEY[1];
Mas Mas1(A,KEY[0],clock,O,Y);

assign LEDR[0] = O;
assign LEDR[1] = Y;
endmodule


module Mas(d,reset,clk,q,qbar);
 input d,clk,reset;
 output q,qbar;
 Master Masterr(d,reset,clk,qx,qbarx);
 Master Slave(qx,reset,!clk,q,qbar);
endmodule

module Master(d,reset,clk,q,qbar);
 input d,reset,clk;
 output reg q,qbar;
 initial
  q = 0;
 always @(posedge clk)begin
  if(~reset)begin
   q <= d;
   qbar <= !d;
  end
  else begin
   q <= 1'bx;
   qbar <= 1'bx;
 end
 end
endmodule