module Part1(SW,KEY,HEX0,HEX1,HEX2,HEX3,HEX4,LEDR,CLOCK_50);
input [9:0] SW;
input [1:0] KEY;
input CLOCK_50;
output [7:0] HEX0,HEX1,HEX2,HEX3,HEX4;
output [9:0] LEDR;


wire key1,clk1,clk,key0;
//wire [15:0] bcd;
wire [6:0] d0,d1,d2,d3,d4;
wire [3:0] b0,b1,b2,b3,b4;

assign clk1 = CLOCK_50;
//assign enable = SW[1];
assign key1 = ~KEY[1];
assign key0 = ~KEY[0];
wire clock,clock1,clock2,clock3;
reg enable,reset;
//reset <= KEY[1];



always @(posedge key1)
begin
reset <= ~reset;
end




always @(posedge key0)
begin
enable <= ~enable;
end

assign LEDR[0] = enable;
assign LEDR[1] = reset;
slowClock1 s1(clk1,enable,reset,clk);

slowClock  sl1(clk,reset,clock,b0);
slowClock  sl2(clock,reset,clock1,b1);
slowClock  sl3(clock1,reset,clock2,b2);
slowClock  sl4(clock2,reset,clock3,b3);
slowClock  sl5(clock3,reset,clock4,b4);


decoder h0(b0,d0);
decoder h1(b1,d1);
decoder h2(b2,d2);
decoder h3(b3,d3);
decoder h4(b4,d4);

assign HEX0 = {1'b1,d0};
assign HEX1 = {1'b1,d1};
assign HEX2 = {1'b0,d2};
assign HEX3 = {1'b1,d3};
assign HEX4 = {1'b1,d4};
endmodule


module slowClock(clk, reset, clk_1Hz,bcd);
input clk, reset;
output clk_1Hz;
output [3:0] bcd;

reg clk_1Hz = 1'b1;
reg [4:0] counter;
reg [3:0] bcd;

always@(posedge reset or posedge clk)
begin
    if (reset == 1'b1)
        begin
            clk_1Hz <= 0;
            counter <= 0;
				bcd <= 0;
        end
    else
        begin
				bcd <= bcd + 1; 
            //counter <= counter + 1;
            //if ( counter == 5)
            //    begin
				//		  counter <= 0;
                    
            //    end
				if (bcd == 9)
					begin
							clk_1Hz <= ~clk_1Hz;
							bcd<=0;
					end
				else 
						clk_1Hz =1'b0;
        end
end
endmodule 

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

module slowClock1(clk, enable, reset, clk_1Hz);
input clk, reset,enable;
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
    else if (enable)
        begin
            counter <= counter + 1;
            if ( counter == 25_000_0)
                begin
                    counter <= 0;
                    clk_1Hz <= ~clk_1Hz;
                end
        end
end
endmodule 