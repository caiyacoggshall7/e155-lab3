// Name: Caiya Coggshall
// Email: caiyacoggshall@gmail.com
// Date: 9/5/25 edited on 9/15/25
// Summary of Purpose: This is the multiplexer module that determines the enable pin logic based on the clock i.e. when the left and right displays on the dual seven 
// segment display is being powered. A mux is also established in the counter to determine whether the input pins for the left or the right display get sent to the
// seven_seg_display.sv code. 


module multiplex(input logic clk,
				 input 	 logic reset,
			    input	 logic [7:0] s2,
				output  logic [3:0] s,
			    output logic [1:0] enable
				 );  
	
   logic counter;

	// Toggle Counter
   always_ff @(posedge clk, negedge reset) begin
		if (reset == 0) counter <= 0;
		else counter <= counter + 1;
	end
   
   assign s = counter ? s2[7:4] : s2[3:0];
   // Telling the enable GPIO pin which gate to power
   // When one display is on, the other one shouldn't be which is why it's ~ the same bit
   assign enable[1] = counter;
   assign enable[0] = ~counter;
   
 endmodule

