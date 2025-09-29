// Name: Caiya Coggshall
// Email: caiyacoggshall@gmail.com
// Date: 9/18/25
// Summary of Purpose: This is the clock divider, originally in my multiplex module in Lab 2. 
// I split it up to now feed this slow clock through every module. It counts on the 17th counter 
// bit which is what I found for time multiplexing in Lab 2. Every other module only has a one bit 
// counter so they run on the freq of the slow clock. 


// 183 hz signal
module slowclock(input logic reset,
				 input 	 logic hsosc_clk,
				output  logic clk);
	
   logic [31:0] counter;

	// Counter
   always_ff @(posedge hsosc_clk) begin
		//if (!reset) counter <= 0;
		//else counter <= counter + 1;
		counter <= counter + 1;
	end
   
   assign clk = counter[17];
   
 endmodule