// Name: Caiya Coggshall
// Email: caiyacoggshall@gmail.com
// Date: 9/20/25
// Summary of Purpose: A simple testbench testing the top.sv module. 
// It has a reset and uses tranif to connect a column and row like hardware 
// (i.e simulating a button press). This is to check all the modules properly interface with one another.

`timescale 1ns/1ns

module top_tb();
	logic clk, reset;
	logic ctrl;
	//logic ctrl2;
	tri [3:0] row;
	logic [6:0] seg;
	logic [1:0] enable;
	logic [3:0] led;
	tri [3:0] col;

	// instantiate dut
	top dut(reset, row, seg, enable, col, led);
	
	pulldown(row[0]);
	pulldown(row[1]);
	pulldown(row[2]);
	pulldown(row[3]);
	
	
	tranif1 keyconnect(row[0], col[2], ctrl);  // number 3
	//tranif1 keyconnect2(row[3], col[3], ctrl2); // number D
	
	// Generate clk
	//always
		//begin
			//clk = 1; #5;
			//clk = 0; #5;
		//end
		
	
	
	initial
		begin
			reset = 0; #50;
			reset = 1; #50;
			
	
			ctrl = 1; #100;
			ctrl = 0; #100;
			
			//ctrl2 = 1; #50;
			//ctrl2 = 0; #50;
			
		end
	
endmodule