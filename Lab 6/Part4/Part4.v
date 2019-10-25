module Part4(SW,LEDR,CLOCK_50,KEY,HEX0, HEX1, HEX2, HEX3);
input [9:0] SW;
input CLOCK_50;
input [1:0] KEY;
output [9:0] LEDR;
output [7:0] HEX0, HEX1, HEX2, HEX3;


wire [7:0] a,b;

wire [7:0] aout, bout, h0,h1,h2,h3;

wire [15:0] c, cout;


assign a = SW[7:0];

DFlipFlop dff1(a,KEY[1],KEY[0],aout,SW[9]);
DFlipFlop dff2(a,KEY[1],KEY[0],bout,SW[8]);



mult8 m1(c,aout,bout);


assign LEDR = c;


DFlipFlop1 dff3(c,KEY[1],KEY[0],cout);


decoder d1(cout[3:0],h0);
decoder d2(cout[7:4],h1);
decoder d3(cout[11:8],h2);
decoder d4(cout[15:12],h3);

assign HEX0 = h0;
assign HEX1 = h1;
assign HEX2 = h2;
assign HEX3 = h3;

endmodule 


module DFlipFlop1(
data  , // Data Input
clk    , // Clock Input
reset , // Reset input 
q         // Q output
);
input [15:0] data; 
input clk, reset ; 
output q;
 
reg [15:0] q;
 
always @ ( posedge clk or negedge reset)
if (~reset) begin
   q <= 1'b0;
end  else begin
   q <= data;
end
 
endmodule


module DFlipFlop(
data  , // Data Input
clk    , // Clock Input
reset , // Reset input 
q     ,    // Q output
enable		// Enable
);
input [7:0] data; 
input clk, reset,enable ; 
output q;
 
reg [7:0] q;
 
always @ ( posedge clk or negedge reset)
if (~reset) begin
   q <= 1'b0;
end  else if (enable) begin
   q <= data;
end	else	begin
	q <= q;
end	
 
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

module mult8(p,x,y);
output [15:0]p;
input [7:0]x,y;
reg [15:0]p=0;
reg [7:0]a;
integer i;

always @(x , y)
begin
a=x;

for(i=0;i<8;i=i+1)
begin
if(y[i])
begin
p<=p+a;
a=a<<1;
end
else
a=a<<1;

end

end

endmodule
