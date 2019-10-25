module part1_notb(SW,LEDR,KEY,CLOCK_50, HEX0, HEX1, HEX2, HEX3 ,HEX4, HEX5);
input [9:0] SW;
input [1:0] KEY;
input CLOCK_50;
output [9:0] LEDR;
output [7:0] HEX0, HEX1, HEX2, HEX3 ,HEX4, HEX5;

wire [7:0] din, dout;
reg [3:0] waddr, raddr;
wire wren, clock;
wire [7:0] a1,a2,a3,a4;

assign din = SW[7:0];
assign wren = ~KEY[0];
//assign clock = KEY[0];
assign LEDR[9:2] = dout;

slowClock(CLOCK_50, reset, clock);
memory1 m1(raddr,waddr, clock, din,wren,dout);

always @ (posedge clock)
begin
if(~KEY[1])begin
waddr <= waddr + 1;
end
raddr <= raddr + 1;

end


/*
decoder d1(raddr[3:0],a1);
//decoder d2({3'b000,addr[4]}, a2);
decoder d3(dout[7:4],a3);
decoder d4(dout[3:0],a4);

assign HEX5 = a1;
//assign HEX4 = a1;
//assign HEX2 = a3;
assign HEX0 = a4;
assign HEX1 = a3;
assign HEX3 = 8'b11111111;
*/

decoder d1(waddr+1,a1);
decoder d2(raddr, a2);
decoder d3(dout[7:4],a3);
decoder d4(dout[3:0],a4);

assign HEX5 = a1;
assign HEX4 = 8'b11111111;
assign HEX3 = a2;
assign HEX2 = 8'b11111111;
assign HEX1 = a3;
assign HEX0 = a4;
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

module memory1 (raddr,waddr, clock, din, wren, dout);

input [3:0] raddr,waddr;
input clock, wren;
input [7:0] din;
output reg [7:0] dout;

reg [7:0] memory_array [16:0];
always @(posedge clock) begin
    if (wren)
      memory_array[waddr] <= din;
    dout <= memory_array[raddr];
  end


endmodule

module slowClock(clk, reset, clk_1Hz);
input clk, reset;
output clk_1Hz;

reg clk_1Hz = 1'b0;
reg [27:0] counter;

always@(posedge reset or posedge clk)
begin
    if (reset == 1'b1)
        begin
            clk_1Hz <= 0;
            counter <= 0;
        end
    else
        begin
            counter <= counter + 1;
            if ( counter == 25_000_000)
                begin
                    counter <= 0;
                    clk_1Hz <= ~clk_1Hz;
                end
        end
end
endmodule 


module part1(clock,dout);
input clock;
output [7:0] dout;

reg [7:0] din;
reg [3:0] waddr, raddr;
reg wren;
//wire [7:0] dout;

memory1 DUT(raddr,waddr, clock, din,wren,dout);

always @ (posedge clock)
begin

raddr <= raddr + 1;

end

initial 
begin 
waddr = 0; raddr = 0; din =0; wren =0; 

#20 
waddr = 4'b0111; 
din = 8'h57;
wren = 1;
#20 
wren =0;
#20   
waddr = 4'b1101; 
din = 8'hab;
wren = 1;
#20
wren=0;


#1000;


end


endmodule 