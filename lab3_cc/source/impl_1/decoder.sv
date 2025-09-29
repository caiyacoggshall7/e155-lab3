// Name: Caiya Coggshall
// Email: caiyacoggshall@gmail.com
// Date: 9/20/25
// Summary of Purpose: Decoder takes in the current row 8 bit encoding created in debouncer and returns the corresponding
// 4 bit binary number that the encoding means on the keypad. This is also where a clock will send that value to the new press and 
// the new press to the old press so it shifts on the delay as expected.


module decoder(input logic clk,
				 input logic reset,
				 input logic [7:0] keycode,
				 input pulseenable,
				 output logic [3:0] oldpress,
				 output logic [3:0] newpress);


	logic [3:0] keydigit;

	always_comb begin
		//if (pulseenable) begin
			case({keycode})
				// 4 bit column encoding _ 4 bit row encoding
				8'b0001_0001: keydigit = 4'b0001;  // column[0] and row[0] -> 1
				8'b0001_0010: keydigit = 4'b0100;  // column[0] and row[1] -> 4
				8'b0001_0100: keydigit = 4'b0111;  // column[0] and row[2] -> 7
				8'b0001_1000: keydigit = 4'b1110;  // column[0] and row[3] -> E
				
				8'b0010_0001: keydigit = 4'b0010;  // column[1] and row[0] -> 2
				8'b0010_0010: keydigit = 4'b0101;  // column[1] and row[1] -> 5
				8'b0010_0100: keydigit = 4'b1000;  // column[1] and row[2] -> 8
				8'b0010_1000: keydigit = 4'b0000;  // column[1] and row[3] -> 0
				
				8'b0100_0001: keydigit = 4'b0011;  // column[2] and row[0] -> 3
				8'b0100_0010: keydigit = 4'b0110;  // column[2] and row[1] -> 6
				8'b0100_0100: keydigit = 4'b1001;  // column[2] and row[2] -> 9
				8'b0100_1000: keydigit = 4'b1111;  // column[2] and row[3] -> F
				
				8'b1000_0001: keydigit = 4'b1010;  // column[3] and row[0] -> A
				8'b1000_0010: keydigit = 4'b1011;  // column[3] and row[1] -> B
				8'b1000_0100: keydigit = 4'b1100;  // column[3] and row[2] -> C
				8'b1000_1000: keydigit = 4'b1101;  // column[3] and row[3] -> D
				
				default: keydigit = 4'b1111;
			endcase
		//end
	end


	always_ff @(posedge clk) begin
		if (!reset) begin
			oldpress <= 4'b0000; // gets 0
			newpress <= 4'b0000; // gets 0
		end
		else if (pulseenable) begin
			oldpress <= newpress;
			newpress <= keydigit;		
		end
		else begin
			oldpress <= oldpress;
			newpress <= newpress;
		end
			
	end	
	
	
			
endmodule	
			