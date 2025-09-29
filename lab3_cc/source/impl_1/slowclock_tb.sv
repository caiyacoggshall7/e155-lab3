// Name: Caiya Coggshall
// Email: caiyacoggshall@gmail.com
// Date: 9/20/25
// Summary of Purpose: This is the test bench for slowclock.sv and tests the that the slow clock is toggling at the slower frequency.

`timescale 1ns/1ns

module slowclock();
	logic reset;
	logic hsosc_clk;
	logic clk;

	// instantiating DUT
	slowclock sc(reset, hsosc_clk, clk);

	// generate hsosc_clk
	always
		begin
			hsosc_clk = 1; #5
			hsosc_clk = 0; #5;
		end
	
	//generate slow clk
	always
		begin
			clk = 1; #5
			clk = 0; #5;
		end


endmodule