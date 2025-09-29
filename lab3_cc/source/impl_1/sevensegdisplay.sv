// Name: Caiya Coggshall
// Email: caiyacoggshall@gmail.com
// Date: 8/31/25
// Summary of Purpose: This is the module for a single seven segment display. It will be used to output hexadecimal numbers 
// entered through DIP switches as binary encodings. The digit will be specified from the input via s[3:0] and display 0x0 through 0xF 

module sevensegdisplay(
     input   logic [3:0] sw,
     output  logic [6:0] seg
);

	// all binary outputs on display depending on DIP switch input
	always_comb
		case (sw)
			4'b0000: seg = 7'b1000000;
			4'b0001: seg = 7'b1111001;
			4'b0010: seg = 7'b0100100;
			4'b0011: seg = 7'b0110000;
			4'b0100: seg = 7'b0011001;
			4'b0101: seg = 7'b0010010;
			4'b0110: seg = 7'b0000010;
			4'b0111: seg = 7'b1111000;
			4'b1000: seg = 7'b0000000;
			4'b1001: seg = 7'b0011000;
			4'b1010: seg = 7'b0001000;
			4'b1011: seg = 7'b0000011;
			4'b1100: seg = 7'b1000110;
			4'b1101: seg = 7'b0100001;
			4'b1110: seg = 7'b0000110;
			4'b1111: seg = 7'b0001110;
			
			// default can also be x's
			default: seg = 7'b0000000;
			
		endcase


endmodule