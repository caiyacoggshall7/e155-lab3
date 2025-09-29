// Name: Caiya Coggshall
// Email: caiyacoggshall@gmail.com
// Date: 9/20/25
// Summary of Purpose: Tests that the async input and syncoutput of the synchronizer are the same but two cycles off.

`timescale 1ns/1ns

module synchronizer_tb();
	logic clk;
	logic reset;
	logic [3:0] asyncinput;
	logic [3:0] syncoutput;
	
	// instantiate
	synchronizer sync(clk, reset, asyncinput, syncoutput);
	
	//generate clk
	always
		begin
			clk = 1; #5;
			clk = 0; #5;
		end
		
	initial 
		begin
			reset = 0; #22;
			reset = 1;
			
			for (asyncinput = 0; asyncinput < 15; asyncinput++) begin
				assert (asyncinput != syncoutput) else $error("Not syncronized correctly!"); #20;	
			end
			
		end	
	
endmodule
	