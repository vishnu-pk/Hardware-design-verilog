module Part2(SW,KEY,HEX0,HEX1,HEX2,HEX3,LEDR);
input [9:0] SW;
input [1:0] KEY;
output [6:0] HEX0,HEX1,HEX2,HEX3;
output [9:0] LEDR;

wire clock,enable,reset;
wire [15:0] bcd;
wire [6:0] d0,d1,d2,d3;

assign clock = KEY[0];
assign enable = SW[1];
assign reset = SW[0];

reg [15:0] counter_up;

always @(posedge clock or posedge reset)
begin
if(reset)
 counter_up <= 16'h0;
else if (enable)
 counter_up <= counter_up + 16'b00000001;
end
 
assign bcd = counter_up;

decoder h0(bcd[3:0],d0);
decoder h1(bcd[7:4],d1);
decoder h2(bcd[11:8],d2);
decoder h3(bcd[15:12],d3);

assign HEX0 = d0;
assign HEX1 = d1;
assign HEX2 = d2;
assign HEX3 = d3;
endmodule

/*
module upcounter(input clk,input [7:0]out,input enable, reset, output[7:0] counter
    );
reg [7:0] counter_up;

// up counter
always @(posedge clk or posedge reset)
begin
if(reset)
 counter_up <= 8'h0;
else if (enable)
 counter_up <= out + 8'h1;
end 
assign counter = counter_up;
endmodule
*/
//module up()

module decoder(bcd,z);
input [3:0] bcd;
output [6:0] z;
reg [6:0] z;

always @*
case (bcd)
4'b0000 :      	//Hexadecimal 0
z = 7'b1000000;
4'b0001 :    		//Hexadecimal 1
z = 7'b1111001;
4'b0010 :  		// Hexadecimal 2
z = 7'b0100100 ; 
4'b0011 : 		// Hexadecimal 3
z = 7'b0110000;
4'b0100 :		// Hexadecimal 4
z = 7'b0011001 ;
4'b0101 :		// Hexadecimal 5
z = 7'b0010010 ;  
4'b0110 :		// Hexadecimal 6
z = 7'b0000010 ;
4'b0111 :		// Hexadecimal 7
z = 7'b1111000;
4'b1000 :     		 //Hexadecimal 8
z = 7'b0000000;
4'b1001 :    		//Hexadecimal 9
z = 7'b0011000 ;
4'b1010 :  		// Hexadecimal A
z = 7'b0001000 ; 
4'b1011 : 		// Hexadecimal B
z = 7'b0000011;
4'b1100 :		// Hexadecimal C
z = 7'b1000110 ;
4'b1101 :		// Hexadecimal D
z = 7'b0100001 ;
4'b1110 :		// Hexadecimal E
z = 7'b0000110 ;
4'b1111 :		// Hexadecimal F
z = 7'b0001110 ;
endcase


endmodule
