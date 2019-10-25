module Part2(SW,LEDR,KEY);
input [9:0] SW;
input [1:0] KEY;
output [9:0] LEDR;
wire clock,A,O;

assign clock = KEY[1];
assign A = SW[0];
d_latch(A,clock,KEY[0],O);
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
