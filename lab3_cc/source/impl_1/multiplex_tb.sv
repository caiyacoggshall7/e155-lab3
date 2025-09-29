// Name: Caiya Coggshall
// Email: caiyacoggshall@gmail.com
// Date: 9/8/25
// Summary of Purpose: This is my testbench for the multiplex.sv module. It tests that s get's the right 4 bits frm s2count (all possible 8 bit inputs) using assert statements on posedge of the clk.

`timescale 1ns/1ns

module multiplex_tb();

	logic reset;
	logic clk;
	logic [3:0] s;
	logic [1:0] enable;
	logic [7:0] s2count;
	
	//instantiating device under test, input: counter as s2count , output: led & seg
	multiplex mp(reset, clk, s2count, s, enable);

	//Generate clk
	always
		begin
			//if (clkenable) begin clk = 1; #5; clk = 0; #5; end
			//else clk = 0;	
			clk =1; #5;
			clk = 0; #5;
		end

	//initial only used in TB simulation
	initial
		begin	
			//// Pulse reset for 22 time units(2.2 cycles) so the reset
			// signal falls after a clk edge.
			reset = 0; #22;
			reset = 1;
			// we have a low reset so flipped from previous e85 TB's		
	
		end
	
	always_ff @(posedge clk) begin
		if (reset == 0) s2count <= 0;
		else s2count <= s2count + 1;
	end
	
	always_ff @(posedge clk) begin
			//if (reset) s2count <= 0;
			if (enable[1]) begin
				assert (s == s2count[7:4]) else $error("Seven segment output isn't choosing correctly [7:4]!");	
				end
			else if (enable[0])begin
				assert (s == s2count[3:0]) else $error("Seven segment output isn't choosing correctly [3:0]!");	
				end		

		end

endmodule 