module Part4(SW,KEY,LEDR,CLOCK_50);
input CLOCK_50;
input [1:0] KEY;
input [9:0] SW;
output [9:0] LEDR;

reg [15:0] LED,L;
wire a,halfsec;
wire [2:0] bcd;
wire CLOCK;
wire [15:0] A;
reg reset ;



assign bcd = SW[2:0];

always @ (negedge KEY[0])
begin 

reset <= ~ reset;

end


assign A = 16'h7777;
assign CLOCK = CLOCK_50;

slowClock  s1(CLOCK, reset, halfsec);

//shifter   sf1(halfsec,A,out1);

shift sf1(CLOCK,SW[9],LED,a);


always @ (posedge CLOCK)
begin
case(bcd)
	3'b000: begin
	if (reset)
	begin 
	LED <= 16'b0;
	end
	else
	begin
	LED <= 16'h001d;	
	end
	end
	3'b001: begin
	if (reset)
	begin 
	LED <= 16'b0;
	end
	else
	begin
	LED <= 16'h0157;	
	end	
	end
	3'b010: begin
	if (reset)
	begin 
	LED <= 16'b0;
	end
	else
	begin
	LED <= 16'h05d7;	
	end	
	end
	3'b011: begin
	if (reset)
	begin 
	LED <= 16'b0;
	end
	else
	begin
	LED <= 16'h0057;	
	end	
	end
	3'b100: begin
	if (reset)
	begin 
	LED <= 16'b0;
	end
	else
	begin
	LED <= 16'h0001;	
	end	
	end
	3'b101: begin
	if (reset)
	begin 
	LED <= 16'b0;
	end
	else
	begin
	LED <= 16'h0175;	
	end	
	end
	3'b110: begin 
	if (reset)
	begin 
	LED <= 16'b0;
	end
	else
	begin
	LED <= 16'h01dd;	
	end	
	end	
	3'b111: begin 
	if (reset)
	begin 
	LED <= 16'b0;
	end
	else
	begin
	LED <= 16'h0055;	
	end	
	end

endcase

end 



assign LEDR[0] = a;

endmodule 

module slowClock(clk, reset, clk_1Hz);
input clk, reset;
output clk_1Hz;

reg clk_1Hz = 1'b0;
reg [27:0] counter = 1'b0;

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
            if ( counter == 12_500_000)
                begin
                    counter <= 0;
                    clk_1Hz <= ~clk_1Hz;
                end
        end
end
endmodule 


module shifter (clock , in , out);
input clock ;
input [15:0] in;
output [15:0] out;
reg in1;

always @ (in) 

begin
in1 = 16'h5555;
end 

always @ (posedge clock)
begin

in1 = in1 >> 1;

end 

assign out = in[0];

endmodule


module shift (C, SLOAD, D, SO); 
input  C,SLOAD; 
input [15:0] D; 
output SO; 
reg [15:0] tmp; 
 
  always @(posedge C) 
  begin 
    if (SLOAD) 
      tmp = D; 
    else 
      begin 
        tmp = tmp >> 1; 
      end 
  end 
  assign SO  = tmp[0]; 
endmodule 
 