module Part2(SW,KEY,HEX0,HEX1,HEX2,HEX3,HEX4,HEX5,LEDR);
input [9:0] SW;
input [1:0] KEY;
output [6:0] HEX0,HEX1,HEX2,HEX3,HEX4,HEX5;
output [9:0] LEDR;

wire clock,key0;
wire [9:0] pass;
wire [6:0] z5,z4,z3,z2,z1,z0;
wire[1:0] c1,c2;

reg reset;

assign clock = ~KEY[1];
assign key0 = ~KEY[0];
assign pass[9:0] = SW[9:0];

assign LEDR[0] = reset;
assign LEDR[1] = clock;

always @(posedge key0)
begin
reset <= ~reset;
end


compute com1(clock,pass,reset,c1);

Dflipflop dff1(c1,clock,reset,c2);
decoder5 d1(c2,z5);
decoder4 d2(c2,z4);
decoder3 d3(c2,z3);
decoder2 d4(c2,z2);
decoder1 d5(c2,z1);
decoder0 d6(c2,z0);

assign HEX5 = z5;
assign HEX4 = z4;
assign HEX3 = z3;
assign HEX2 = z2;
assign HEX1 = z1;
assign HEX0 = z0;

endmodule

module compute(clock,pass,reset,c);
input clock,reset;
input[9:0] pass;
output [1:0] c;


reg [1:0] c;
reg [9:0] password = 10'b1010101010;
always @(posedge clock or posedge reset)
begin 

	//if (reset)
	//c<= 2'b00;
	//else 
	begin
		case (pass)
		10'b1010101010 :begin      	//Hexadecimal d
		if (reset)
		c<= 2'b00;// 00 - LOCKED 01- UNLOCk 10-ALARM
		else 
		c<= 2'b01;
		end
		
		default :
		begin
		if (reset)
		c<=2'b00;
		else
		c<= 2'b10; 
		end
		endcase
	end
end


endmodule

module decoder5 (bcd,z);
input [1:0] bcd;
output [6:0] z;

reg [6:0] z;
always @ (*)
case (bcd)
2'b00 :      	//Hexadecimal L
z = 7'b1000111;
2'b01 :    		//Hexadecimal U
z = 7'b1000001;
2'b10 :  		// Hexadecimal A
z = 7'b0001000 ; 

endcase
endmodule

module decoder4 (bcd,z);
input [1:0] bcd;
output [6:0] z;

reg [6:0] z;
always @ (*)
case (bcd)
2'b00 :      	//Hexadecimal O
z = 7'b1000000;
2'b01 :    		//Hexadecimal N
z = 7'b0101011;
2'b10 :  		// Hexadecimal L
z = 7'b1000111 ; 

endcase
endmodule  

module decoder3 (bcd,z);
input [1:0] bcd;
output [6:0] z;

reg [6:0] z;
always @ (*)
case (bcd)
2'b00 :      	//Hexadecimal C
z = 7'b1000110;
2'b01 :    		//Hexadecimal L
z = 7'b1000111;
2'b10 :  		// Hexadecimal A
z = 7'b0001000 ; 

endcase
endmodule 

module decoder2 (bcd,z);
input [1:0] bcd;
output [6:0] z;

reg [6:0] z;
always @ (*)
case (bcd)
2'b00 :      	//Hexadecimal K
z = 7'b0001001;
2'b01 :    		//Hexadecimal O
z = 7'b1000000;
2'b10 :  		// Hexadecimal R
z = 7'b0101111 ; 

endcase
endmodule 

module decoder1 (bcd,z);
input [1:0] bcd;
output [6:0] z;

reg [6:0] z;
always @ (*)
case (bcd)
2'b00 :      	//Hexadecimal E
z = 7'b0000110;
2'b01 :    		//Hexadecimal C
z = 7'b1000110;
2'b10 :  		// Hexadecimal M
z = 7'b0110000 ; 

endcase
endmodule 

module decoder0 (bcd,z);
input [1:0] bcd;
output [6:0] z;

reg [6:0] z;
always @ (*)
case (bcd)
2'b00 :      	//Hexadecimal D
z = 7'b0100001;
2'b01 :    		//Hexadecimal K
z = 7'b0001001;
2'b10 :  		// Hexadecimal -
z = 7'b1111111 ; 

endcase
endmodule 

module Dflipflop(D,clk,async_reset,Q);
input [1:0] D; // Data input 
input clk; // clock input 
input async_reset; // asynchronous reset high level
output reg [1:0]Q; // output Q 
always @(posedge clk or posedge async_reset) 
begin
 if(async_reset==1'b1)
  Q <= 2'b0; 
 else 
  Q <= D; 
end 
endmodule
