// Name: Caiya Coggshall
// Email: caiyacoggshall@gmail.com
// Date: 8/31/25
// Summary of Purpose: This is the test bench for seven_seg_display.sv and tests the seven_segment case statements against a prewritten set of testvectors.

`timescale 1ns/1ns

module seven_seg_testbench();
	logic clk;
	logic reset;
	logic [3:0] s; 
	logic [6:0] seg, segexpected;
	logic [31:0] vectornum, errors;
	
	// 11 bits of input and output (4 bit input s and 7 bit output seg)
	logic [10:0] testvectors[10000:0];
	//instantiating device under test (DUT) , input: s , output: led & seg

	seven_seg_display dut(s, seg);

//generating clock
always
	begin 
		  //set clock with period of 10 time units, high(1) for 5 and low(0) for 5
		clk=1; #5;
		clk=0; #5;
		
	end

	//extract clock from lab1_cc module (thank you vikram + google)
	//assign clk = dut.clk;

//initial only used in TB simulation
initial
	begin
		// load in vectors stored as binary digits
		$readmemb("e155sevenseg.tv", testvectors);
		
		// initialize # of vectors applied and amount of errors detected
		vectornum = 0;
		errors=0;
		//both 0 to start
		
		//// Pulse reset for 22 time units(2.2 cycles) so the reset
		// signal falls after a clk edge.
		reset = 0; #22;
		reset = 1;
		// we have a low reset so flipped from previous e85 TB's
		
	end

always @(posedge clk)
	begin
		#1; // apply testvectors 1 time unit after rising edge of clock to avoid data chnaging w the clk
		
		// split testvectors into input and expected outputs
		{s, segexpected} = testvectors[vectornum];
		
	end
	
always @(negedge clk)
	if (reset) begin
			if (seg !== segexpected) begin
				//if error detected then print input & outputs
				$display("Error: inputs = %b", {s});
				$display("Outputs = %b (%b expected)", seg, segexpected);
				
				// increment amount of errors
				errors = errors + 1;
			end
			// increment the count of vectors
			vectornum = vectornum + 1;
			
			//// When the test vector becomes all 'x', that means all the
			// vectors that were initially loaded have been processed, thus
			// the test is complete.
			if (testvectors[vectornum] === 11'bx) begin
			// '==='&'!==' can compare unknown & floating values (X&Z),unlike
			// '=='&'!=', which can only compare 0s and 1s.
			// 11'bx is 11-bit binary of x's or xxxxx.
			// If the current testvector is xxxxx, report the number of
			// vectors applied & errors detected.
				$display("%d tests completed with %d errors", vectornum, errors);
				// then stop sim
				$stop;
			end
	end


endmodule