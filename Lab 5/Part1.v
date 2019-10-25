module Part1(SW,LEDR,CLOCK50 ,HEX0,HEX1,HEX2, HEX3, HEX4, HEX5 );

input CLOCK50;
input [9:0] SW;
output [9:0] LEDR;
output [6:0] HEX0, HEX1, HEX3, HEX5;
output [7:0] HEX2, HEX4;

wire [7:0] h3,h2,h1,h0;



RTC R1 (CLOCK50, h3, h2, h1, h0); 

assign HEX0 = h0;
assign HEX1 = h1;
assign HEX2 = h2;
assign HEX3 = h3;

endmodule 	


module RTC( clk, min_h, min_l, sec_h, sec_l);

input clk;

output [6:0] min_h;
output [6:0] min_l;
output [6:0] sec_h;
output [6:0] sec_l;

reg [6:0] min_h;    // MINUTES AND SECONDS WILL BE DISPLAYED IN 7 SEGMENT DISPLAY
reg [6:0] min_l;
reg [6:0] sec_h;
reg [6:0] sec_l;

// EXTRA SIGNALS YOU NEED
reg [3:0]sec_lower;
reg [3:0]sec_higher;
reg [3:0]min_higher;
reg [3:0]min_lower;

integer count;      // SINGLE 32_BIT SIGNED INTEGER
integer count1;
integer count2;
integer count3;
integer count4;
integer count12;
reg clk1;
reg clk2;
reg clk3;
reg clk4;

initial 
begin: process_15
count <= 0;
end
initial
begin: process_14
count1 <= 0;
end
initial
begin: process_13
count2 <= 0;
end
initial 
begin: process_12
count3 <= 0;
end
initial
begin: process_11
count4 <= 0;
end
initial
begin: process_10
sec_l <= 7'b0111111;
end
initial
begin: process_9
sec_h <= 7'b0111111;
end
initial
begin: process_8
min_l <= 7'b0111111;
end
initial
begin: process_7
min_h <= 7'b0111111;
end
always @ (posedge clk)
begin: process_6
count <= count + 1;
if (count == 10000000)
begin
   clk1 <= ~ clk1;

  count1 <= 1;
  count2 <= 1;
  count3 <= 1;
  count4 <= 1;  
end
else
begin
  count1 <= 0;
  count2 <= 0;
  count3 <= 0;
  count4 <= 0;
end
end
always @ (posedge clk1)
begin: process_5
	       count1 <= count1 + 1;
	       sec_lower <= sec_lower + 1'b1;
			 case (sec_lower)
          4'b0001:
			 if (count1 == 1)
          begin
				sec_l <= 7'b0000110;    // 1
				sec_lower <= 4'b0010;   // next state
			 end
			 else
			   sec_lower <= 4'b0001;   // same state
          4'b0010:
			 if (count1 == 2)
			 begin
            sec_l <= 7'b1011011;    // 2
				sec_lower <= 4'b0011;   // next state
			 end
			 else
			   sec_lower <= 4'b0010;   // same state
          4'b0011:
			 if (count1 == 3)
			 begin
            sec_l <= 7'b1001111;    // 3
				sec_lower <= 4'b0100;   // NEXT STATE
			 end
			 else
			   sec_lower <= 4'b0011;   // SAME STATE
          4'b0100:
			 if (count1 == 4)
			 begin
            sec_l <= 7'b1100110;    // 4
				sec_lower <= 4'b0101;   // NEXT STATE
			 end
			 else
			   sec_lower <= 4'b0100;   // SAME STATE
			 4'b0101:
			 if (count1 == 5)
			 begin
			   sec_l <= 7'b1101101;    // 5
				sec_lower <= 4'b0110;   // NEXT STATE
			 end
			 else
			   sec_lower <= 4'b0101;   // SAME STATE
			 4'b0110:
			 if (count1 == 6)
			 begin
   			sec_l <= 7'b1111101;    // 6
				sec_lower <= 4'b0111;   // NEXT STATE
			 end
			 else
			   sec_lower <= 4'b0110;   // SAME STATE
			 4'b0111:
			 if (count1 == 7)
			 begin
			   sec_l <= 7'b0000111;    // 7
				sec_lower <= 4'b1000;   // NEXT STATE
			 end
			 else
			   sec_lower <= 4'b0111;   // SAME STATE
			 4'b1000:
			 if (count1 == 8)
			 begin
			   sec_l <= 7'b1111111;    // 8
				sec_lower <= 4'b1001;   // NEXT STATE
			 end
			 else
			   sec_lower <= 4'b1000;   // SAME STATE
			 4'b1001:
			 if (count1 == 9)
			 begin
  			   sec_l <= 7'b1101111;    // 9
				sec_lower <= 4'b1010;   // NEXT STATE
			 end
			 else
			   sec_lower <= 4'b1001;   // SAME STATE
			 4'b1010:
			 if (count1 == 10)
			 begin
			   sec_l <= 7'b0111111;    // 0
				count1 <= 0;
            sec_lower <= 4'b0001;		// NEXT STATE
			 end
			 else
			   sec_lower <= 4'b1010;   // SAME STATE
			 endcase
end
always @ (posedge clk1)
begin: process_4
     count2 <= count2 + 1;
       sec_higher <= sec_higher + 1'b1;
     	    case (sec_higher)
          4'b0001:
			 if (count2 == 10)
			 begin        
            sec_h <= 7'b0000110;    //1
				sec_higher <= 4'b0010;  // NEXT STATE
			 end
          else
            sec_higher <= 4'b0001;	// SAME STATE		 
          4'b0010:
			 if (count2 == 20)
			 begin
            sec_h <= 7'b1011011;    //2
				sec_higher <= 4'b0011;  // NEXT STATE
			 end
			 else
			   sec_higher <= 4'b0010;  // SAME STATE
          4'b0011:
          if (count2 == 30)
			 begin	
				sec_h <= 7'b1001111;    //3
				sec_higher <= 4'b0100;  // NEXT STATE
			 end
			 else
			   sec_higher <= 4'b0011;	// SAME STATE			
          4'b0100:
			 if (count2 == 40)
			 begin
            sec_h <= 7'b1100110;    //4
				sec_higher <= 4'b0101;  // NEXT STATE
			 end
			 else
			   sec_higher <= 4'b0100;
			 4'b0101:
			 if (count2 == 50)
			 begin
			   sec_h <= 7'b1101101;    //5
				sec_higher <= 4'b0110;  // NEXT STATE
		    end
			 else
			   sec_higher <= 4'b0101;  // SAME STATE
			 4'b0110:
			 if (count2 == 60)
			 begin
			   sec_h <= 7'b0111111;    // 0
				sec_higher <= 4'b0001;  // NEXT STATE
				count2 <= 0;
			 end
			 else
			   sec_higher <= 4'b0110;
			 endcase
end
always @ (posedge clk1)
begin: process_3		
	count3 <= count3 + 1;
	 min_lower <= min_lower + 1'b1;
		    case (min_lower)
			 4'b0001:
			 if (count3 == 60)
          begin
				min_l <= 7'b0000110;    // 1
				min_lower <= 4'b0010;   // next state
			 end
			 else
			   min_lower <= 4'b0001;   // same state
          4'b0010:
			 if (count3 == 120)
			 begin
            min_l <= 7'b1011011;    // 2
				min_lower <= 4'b0011;   // next state
			 end
			 else
			   min_lower <= 4'b0010;   // SAME STATE
          4'b0011:
			 if (count3 == 180)
			 begin
            min_l <= 7'b1001111;    // 3
				min_lower <= 4'b0100;   // NEXT STATE
			 end
			 else
			   min_lower <= 4'b0011;   // SAME STATE
          4'b0100:
			 if (count3 == 240)
			 begin
            min_l <= 7'b1100110;    // 4
				min_lower <= 4'b0101;   // NEXT STATE
			 end
			 else
			   min_lower <= 4'b0100;   // SAME STATE
			 4'b0101:
			 if (count3 == 300)
			 begin
			   min_l <= 7'b1101101;    // 5
				min_lower <= 4'b0110;   // NEXT STATE
			 end
			 else
			   min_lower <= 4'b0101;   // SAME STATE
			 4'b0110:
			 if (count3 == 360)
			 begin
   			min_l <= 7'b1111101;    // 6
				min_lower <= 4'b0111;   // NEXT STATE
			 end
			 else
			   min_lower <= 4'b0110;   // SAME STATE
			 4'b0111:
			 if (count3 == 420)
			 begin
			   min_l <= 7'b0000111;    // 7
				min_lower <= 4'b1000;   // NEXT STATE
			 end
			 else
			   min_lower <= 4'b0111;   // SAME STATE
			 4'b1000:
			 if (count3 == 480)
			 begin
			   min_l <= 7'b1111111;    // 8
				min_lower <= 4'b1001;   // NEXT STATE
			 end
			 else
			   min_lower <= 4'b1000;   // SAME STATE
			 4'b1001:
			 if (count3 == 540)
			 begin
  			   min_l <= 7'b1101111;    // 9
				min_lower <= 4'b1010;   // NEXT STATE
			 end
			 else
			   min_lower <= 4'b1001;   // SAME STATE
			 4'b1010:
			 if (count3 == 600)
			 begin
			   min_l <= 7'b0111111;    // 0
				count3 <= 0;
            min_lower <= 4'b0001;		// NEXT STATE
			 end
			 else
			   min_lower <= 4'b1010;   // SAME STATE
			endcase
end
always @ (posedge clk1)
begin: process_2
   count4 <= count4 + 1;
     min_higher <= min_higher + 1'b1;	
		case (min_higher)
          4'b0001:
			 if (count4 == 600)
			 begin        
            min_h <= 7'b0000110;    //1
				min_higher <= 4'b0010;  // NEXT STATE
			 end
          else
            min_higher <= 4'b0001;	// SAME STATE		 
          4'b0010:
			 if (count4 == 1200)
			 begin
            min_h <= 7'b1011011;    //2
				min_higher <= 4'b0011;  // NEXT STATE
			 end
			 else
			   min_higher <= 4'b0010;  // SAME STATE
          4'b0011:
          if (count4 == 1800)
			 begin	
				min_h <= 7'b1001111;    //3
				min_higher <= 4'b0100;  // NEXT STATE
			 end
			 else
			   min_higher <= 4'b0011;	// SAME STATE			
          4'b0100:
			 if (count4 == 2400)
			 begin
            min_h <= 7'b1100110;    //4
				min_higher <= 4'b0101;  // NEXT STATE
			 end
			 else
			   min_higher <= 4'b0100;
			 4'b0101:
			 if (count4 == 3000)
			 begin
			   min_h <= 7'b1101101;    //5
				min_higher <= 4'b0110;  // NEXT STATE
		    end
			 else
			   min_higher <= 4'b0101;  // SAME STATE
			 4'b0110:
			 if (count4 == 3600)
			 begin
			   min_h <= 7'b0111111;    // 0
				min_higher <= 4'b0001;  // NEXT STATE
				count4 <= 0;
			 end
			 else
			   min_higher <= 4'b0110;
			 endcase

end				 
endmodule