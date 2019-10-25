module Lab5Part4 (

input [2:0] SW, 
input [1:0] KEY,
output [0:0] LEDR,
input CLOCK_10, 
input CLOCK_50);

	
	wire [15:0] LED;
	wire Key0, Key1, Pulse;

	assign Key0 = KEY[0];
	assign Key1 = KEY[1];
	
	
  Initializer U1 (
					.Clock(CLOCK_50), 
					.Sel(SW[2:0]), 
					.reset(Key0), 
					.Q(LED)
				);
	
  Counter U2 (
			.Clock(CLOCK_10/2), 
			.reset(Key0),
			.Q(Pulse)
		   );
							
  Morse_Code U3 (
				.En(Pulse), 
				.LOAD(Key1), 
				.Code(LED), 
				.Reslt(LEDR[0])
			);
	
endmodule 

module Initializer (Clock, Sel, reset, Q);

 input Clock, reset;
 input [2:0] Sel;
 
 reg reset_S;
 output reg [15:0] Q;
 
 always @ (posedge reset)
	begin
		reset_S <= ~reset_S;
		end
	
	always @ (posedge Clock)
		begin
			case(Sel)
			3'b000: 
			begin
			if (reset_S)
				begin 
				Q <= 16'b0;
				end
			else
				begin
				Q <= 16'h001d;	
				end
			end
			3'b001: 
			begin
			if (reset_S)
				begin 
				Q <= 16'b0;
				end
			else
				begin
				Q <= 16'h0157;	
				end	
			end
			3'b010: 
			begin
			if (reset_S)
				begin 
				Q <= 16'b0;
				end
			else
				begin
				Q <= 16'h05d7;	
				end	
			end
			3'b011: 
			begin
			if (reset_S)
				begin 
				Q <= 16'b0;
				end
			else
				begin
				Q <= 16'h0057;	
				end	
			end
			3'b100: 
			begin
			if (reset_S)
				begin 
				Q <= 16'b0;
				end
			else
				begin
				Q <= 16'h0001;	
				end	
			end
			3'b101: 
			begin
			if (reset_S)
				begin 
				Q <= 16'b0;
				end
			else
				begin
				Q <= 16'h0175;	
				end	
			end
			3'b110:
			begin 
			if (reset_S)
				begin 
				Q <= 16'b0;
				end
			else
				begin
				Q <= 16'h0177;	
				end	
			end	
			3'b111: 
			begin 
			if (reset_S)
				begin 
				Q <= 16'b0;
				end
			else
				begin
				Q <= 16'h0055;	
				end	
			end

		endcase

		end 

endmodule 

module Counter (Clock, reset, Q);

input Clock, reset;

output reg Q = 1'b0;

reg [3:0] Cnt = 1'b0;

always @ (posedge Clock)

	begin
    if (!reset)
        begin
            Q <= 0;
            Cnt <= 0;
        end
    else
        begin
            Cnt <= Cnt + 1;
				Q <= 0;
            if ( Cnt == 1)
                begin
                    Cnt <= 0;
						  Q <= ~Q;
                end
        end
	end

endmodule 

module Morse_Code (En, LOAD, Code, Reslt); 

	input  En, LOAD; 
	input [15:0] Code; 

	output Reslt; 

	reg [15:0] Temp; 
 
  always @ (posedge En) 
  
	begin 
	
    if (!LOAD) 
		Temp <= Code; 
    else 
      begin 
        Temp <= Temp >> 1; 
      end 
	end 
	
  assign Reslt = Temp[0]; 

endmodule 

 