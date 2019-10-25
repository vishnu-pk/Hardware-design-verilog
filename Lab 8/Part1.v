module Part1(SW,LEDR,KEY, HEX0, HEX1, HEX2, HEX3 ,HEX4, HEX5);
input [9:0] SW;
input [1:0] KEY;
output [9:0] LEDR;
output [7:0] HEX0, HEX1, HEX2, HEX3 ,HEX4, HEX5;

wire [3:0] din, dout;
wire [4:0] addr;
wire wren, clock;
wire [7:0] a1,a2,a3,a4;

assign addr = SW[8:4];
assign din = SW[3:0];
assign wren = SW[9];
assign clock = KEY[0];
assign LEDR[9:6] = dout;


ram32x4 (addr, clock, din,wren,dout);

decoder d1(addr[3:0],a1);
decoder d2({3'b000,addr[4]}, a2);
decoder d3(din,a3);
decoder d4(dout,a4);

assign HEX5 = a2;
assign HEX4 = a1;
assign HEX2 = a3;
assign HEX0 = a4;
assign HEX1 = 8'b11111111;
assign HEX3 = 8'b11111111;

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