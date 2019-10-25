module Part5(SW,KEY,HEX0,HEX1,HEX2,HEX3,HEX4,HEX5,LEDR,CLOCK_50);
input [9:0] SW;
input [1:0] KEY;
input CLOCK_50;
output [6:0] HEX0,HEX1,HEX2,HEX3,HEX4,HEX5;
output [9:0] LEDR;

wire enable,reset;
wire [15:0] bcd;
wire [6:0] d0,d1,d2,d3,d4,d5;

assign clk = CLOCK_50;
assign enable = SW[1];
assign reset = SW[0];
wire clock;
slowClock  sl1(clk,reset, clock);

reg [2:0] counter_up;

always @(posedge clock or posedge reset)
begin
if(reset)
 counter_up <= 3'h0;
else if (enable) begin
	if(counter_up > 3'b101)
	counter_up <= 3'b0;
	else
	counter_up <= counter_up + 2'b1;
end
 
 end
 
assign bcd = counter_up;

decoder h0(bcd +3'b101,d0);
decoder h1(bcd +3'b100,d1);
decoder h2(bcd +3'b011,d2);
decoder h3(bcd +3'b010,d3);
decoder h4(bcd +3'b001,d4);
decoder h5(bcd,d5);

assign HEX0 = d0;
assign HEX1 = d1;
assign HEX2 = d2;
assign HEX3 = d3;
assign HEX4 = d4;
assign HEX5 = d5;
endmodule

module decoder(bcd,z);
input [2:0] bcd;
output [6:0] z;
reg [6:0] z;

always @*
case (bcd)
3'b000 :      	//Hexadecimal d
z = 7'b0100001;
3'b001 :    		//Hexadecimal e
z = 7'b0000110;
3'b010 :  		// Hexadecimal 1
z = 7'b1111001 ; 
3'b011 : 		// Hexadecimal 0
z = 7'b1000000 ;
3'b100 :			//Hexadecimal -
z = 7'b1111111;
3'b101 :			//Hexadecimal -
z = 7'b1111111;
3'b110 :
z = 7'b1111111;
3'b111 :
z= 7'b1111111;
endcase


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
