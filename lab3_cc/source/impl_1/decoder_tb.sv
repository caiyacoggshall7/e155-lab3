// Name: Caiya Coggshall
// Email: caiyacoggshall@gmail.com
// Date: 9/20/25
// Summary of Purpose: Uses assert statements to check that oldpress get's newpress for different keycode values.

`timescale 1ns/1ns

module decoder_tb();
	
	logic clk;
	logic reset;
	logic [7:0] keycode;
	logic pulseenable;
	logic [3:0] oldpress;
	logic [3:0] newpress;
	
	// instatiate
	decoder dc(clk, reset, keycode, pulseenable, oldpress, newpress);
	
	//clk
	always
		begin
			clk = 1; #5;
			clk = 0; #5;
		end
		
	initial
		begin
			reset = 0; #22;
			reset = 1;
			
			// check #1
			
			assert (oldpress == 4'b0000 && newpress == 4'b0000) else $error("Values after reset are wrong!"); #10;
			
			// check #2
			pulseenable = 1;
			keycode = 8'b0100_0001; // = 3
			
			assert (oldpress == 4'b0000 && newpress == 4'b0011) else $error("Values for keycode = 3 are wrong!"); #10;
				
			pulseenable = 0;
			#30;
			// check #3
			pulseenable = 1;
			keycode = 8'b0100_1000; // = F
			
			assert (oldpress == newpress && newpress == 4'b1111) else $error("Values for keycode = F are wrong!"); #10;
		end
		
endmodule



			
			