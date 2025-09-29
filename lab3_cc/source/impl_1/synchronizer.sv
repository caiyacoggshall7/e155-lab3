// Name: Caiya Coggshall
// Email: caiyacoggshall@gmail.com
// Date: 9/19/25
// Summary of Purpose: This is the sychronizer that uses internal flops
// to delay the input by two clock cycles. 

module synchronizer (input logic clk, 
					 input logic reset,
					 input logic [3:0] asyncinput,
					 output logic [3:0] syncoutput);
	
		logic [3:0] flop1, flop2; //, flop3, flop4; // is this enough flops to delay by or do i need one more
	
	// Syncing Outputs with Clock
	always_ff @(posedge clk) begin
		if (reset) begin
			flop1 <= asyncinput;
			flop2 <= flop1;	
			//flop3 <= flop2;
			//flop4 <= flop3;
		end
		else begin
			flop1 <= 4'b0000;
			flop2 <= 4'b0000;
			//flop3 <= 4'b0000;
			//flop4 <= 4'b0000;
		end
		
	end

	
	assign syncoutput = flop2; // Sync outside 

endmodule
	