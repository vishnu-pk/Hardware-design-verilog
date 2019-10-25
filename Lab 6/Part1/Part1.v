module Part1(SW,LEDR,KEY,HEX5,HEX4,HEX1,HEX0);
input [9:0] SW;
input [1:0] KEY;
output [7:0] HEX5,HEX4,HEX1,HEX0;
output [9:0] LEDR;


wire [7:0] A;
wire [7:0] h0,h1,h4,h5;

assign A = SW[7:0];
wire [8:0] c;
reg [8:0] d;	

DFlipFlop(d,KEY[1],KEY[0],c);
adder   a1(A,c,KEY[1],d);



decoder d1(A[7:4],h5);
decoder d2(A[3:0],h4);

decoder d3(c[7:4],h1);
decoder d4(c[3:0],h0);

assign HEX5 = h5;
assign HEX4 = h4;
assign HEX1 = h1;
assign HEX0 = h0;


endmodule


module decoder(bcd,z);
input [3:0] bcd;
output [7:0] z;
reg [7:0] z;

always @*
case (bcd)
4'b0000 :      	//Hexadecimal 0
z = 8'b11000000;
4'b0001 :    		//Hexadecimal 1
z = 8'b11111001;
4'b0010 :  		// Hexadecimal 2
z = 8'b10100100 ; 
4'b0011 : 		// Hexadecimal 3
z = 8'b10110000;
4'b0100 :		// Hexadecimal 4
z = 8'b10011001 ;
4'b0101 :		// Hexadecimal 5
z = 8'b10010010 ;  
4'b0110 :		// Hexadecimal 6
z = 8'b10000010 ;
4'b0111 :		// Hexadecimal 7
z = 8'b11111000;
4'b1000 :     		 //Hexadecimal 8
z = 8'b10000000;
4'b1001 :    		//Hexadecimal 9
z = 8'b10011000 ;
4'b1010 :  		// Hexadecimal A
z = 8'b10001000 ; 
4'b1011 : 		// Hexadecimal B
z = 8'b10000011;
4'b1100 :		// Hexadecimal C
z = 8'b11000110 ;
4'b1101 :		// Hexadecimal D
z = 8'b10100001 ;
4'b1110 :		// Hexadecimal E
z = 8'b10000110 ;
4'b1111 :		// Hexadecimal F
z = 8'b10001110 ;
endcase


endmodule

module adder (A,B,clock,C);
input [7:0] A,B;
input clock;
output [8:0] C;
reg c;

always @ (posedge clock)
begin 

c <= A + B; 

end



endmodule

module DFlipFlop(
data  , // Data Input
clk    , // Clock Input
reset , // Reset input 
q         // Q output
);
input [15:0] data; 
input clk, reset ; 
output q;
 
reg [8:0] q;
 
always @ ( posedge clk or negedge reset)
if (~reset) begin
   q <= 1'b0;
end  else begin
   q <= data;
end
 
endmodule

