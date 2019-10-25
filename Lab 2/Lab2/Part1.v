module Part1 (SW,HEX0, HEX1);

input [9:0] SW;
output [6:0] HEX0, HEX1;
wire [4:0] A,B;
wire [6:0] X,Y;

assign A = SW[3:0];
assign B = SW[7:4];
//segment7 bcd(A,B);
decoder d1(A,X);
decoder d2(B,Y);
assign HEX0 = X;
assign HEX1 = Y;
endmodule

module decoder (bcd, seg);

input [3:0] bcd;
assign a = bcd[3];
assign b = bcd[2];
assign c = bcd[1];
assign d = bcd[0];

output [6:0] seg;

assign seg[0] = (b & (~c) & (~d)) | ((~a) & (~b) & (~c) & d); //a
assign seg[1] = (b & (~c) & d) | (b & c & (~d));//b
assign seg[2] = (~b) & (~d) & c;//c
assign seg[3] = (b & ~c & ~d) | (b & c & d) | (~a & ~b & ~c & d);//d
assign seg[4] = (d) | (b & ~c);//e
assign seg[5] = (~b & c) | (c & d) | (~a & ~b & d);//f
assign seg[6] = (~a & ~b & ~c) | (b & c & d);//g


endmodule



/*

module segment7(
     bcd,
     seg
    );
     
     //Declare inputs,outputs and internal variables.
     input [3:0] bcd;
     output [6:0] seg;
     reg [6:0] seg;

//always block for converting bcd digit into 7 segment format
    always @(bcd)
    begin
        case (bcd) //case statement
            0 : seg = 7'b1000000;
            1 : seg = 7'b1111001;
            2 : seg = 7'b0100100;
            3 : seg = 7'b0110000;
            4 : seg = 7'b0011001;
            5 : seg = 7'b0010010;
            6 : seg = 7'b0000010;
            7 : seg = 7'b1111000;
            8 : seg = 7'b0000000;
            9 : seg = 7'b0010000;
            //switch off 7 segment character when the bcd digit is not a decimal number.
            default : seg = 7'b1111111; 
        endcase
    end
    
endmodule 

*/