module Part4 (SW,LEDR,KEY);
input [9:0] SW;
input [1:0] KEY;
output [9:0] LEDR;
wire A,resetbutton,P,Q,R;

assign A =SW[9];
assign resetbutton = KEY[0];
assign clock = KEY[1];


reg8 d8bit1(resetbutton,clock,A,P);
reg1 d8bit2(resetbutton,clock,A,Q);
d_latch(A,clock,KEY[0],R);

assign LEDR[9] = P;
assign LEDR[8] = Q;
assign LEDR[7] = R;


endmodule

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

module reg1 (reset, CLK, D, Q);
input reset;
input CLK;
input [7:0] D;
output [7:0] Q;
reg [7:0] Q;
always @(negedge CLK)
if (~reset)
Q = 0;
else
Q = D;
endmodule
module d_latch (  input d,           
                  input CLK,         
                  input rstn,        
                  output reg q);     
 

   always @ (CLK)
      if (!rstn)
         q <= 0;
      else
         q <= d;
endmodule
