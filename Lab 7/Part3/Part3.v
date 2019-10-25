module Part3(SW,KEY,LEDR,HEX0,HEX1,HEX2,HEX3);
input [9:0] SW;
input [1:0] KEY;
output [9:0] LEDR;
output [7:0] HEX0,HEX1,HEX2,HEX3;

wire clock;

wire [3:0] y_Q,y_Q1;
wire [7:0] out;
reg [3:0] Y_D,Y_D1;
reg [7:0] d;
parameter A=4'b0000, B=4'b0001, C=4'b0010, D=4'b0011, E=4'b0100, F=4'b0101, G=4'b0110, H=4'b0111, I=4'b1000;

assign clock = KEY[0];
assign w = SW[1];
assign reset = SW[0];


state_update su1(Y_D,clock,reset,y_Q); 
decoder d1 (d,out);

always @ (w,y_Q)

begin: state_table
case(y_Q)
	A: if(!w) Y_D <= B;
	else Y_D <= F;
	B: if(!w) Y_D <= C;
	else Y_D <= F;
	C: if(!w) Y_D <= D;
	else Y_D <= F;
	D: if(!w) Y_D <= E;
	else Y_D <= F;
	E: if(!w) Y_D <= E;
	else Y_D <= F;
	F: if(w) Y_D <= G;
	else Y_D <= B;
	G: if(w) Y_D <= H;
	else Y_D <= B;
	H: if(w) Y_D <= I;
	else Y_D <= B;
	I: if(w) Y_D <= I;
	else Y_D <= B;
	default : Y_D <= 4'bxxxx;
endcase 
end

//Display
always @ (*)
begin: display

case(y_Q)
	E: d <= 8'b11000000;
	I: d <= 8'b11111001;
	default: d<= 8'b10001001;
endcase

end	

//assign LEDR[8:5] = y_Q;
assign HEX0 = out;
assign HEX1 = out;
assign HEX2 = out;
assign HEX3 = out;




endmodule 

module decoder (d,o);
input [7:0] d;
output [7:0] o;

assign o = d;

endmodule



module state_update(Y_D,clock,reset,y_Q);
input [3:0] Y_D;
input clock,reset;
output reg [3:0] y_Q;

reg [3:0] temp;

always @ (posedge clock or posedge reset)

begin: state_FFs;
if(reset)
temp <= 4'b0000;
else 
temp <= Y_D; 


y_Q <= temp;

end

endmodule 

