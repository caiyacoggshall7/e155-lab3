// Name: Caiya Coggshall
// Email: caiyacoggshall@gmail.com
// Date: 9/17/25
// Summary of Purpose: This is the top level module for lab 3: This is where the internal high-speed oscillator is defined and all of my other modules are instantiated. The HSOSC gets fed into the slow clk and every other module is run on that slow clk. The synchronizer syncs rows and columns. The keyscanner module gets the column and column/row encoding of the current press we are on. It also ORs the bits of row together to determine if itâ€™s on. That then goes through debounce and decoder to debounce the key press and decode the value and then that value gets time multiplexed in the multiplex module and then displayed via the sevensegdisplay module.



module top( input logic reset,
				input	 logic [3:0] row, //unsyncrow when syncronizer is in
			    output  logic [6:0] seg,
			    output logic [1:0] enable,
				output logic [3:0] col,
				output logic [3:0] led);
  
   //logic [31:0] counter;

	 // //Counter
   //always_ff @(posedge hsosc_clk) begin
		//if (!reset) counter <= 0;
		//else if (counter[17]) col[0] = 1;
		//else begin
			//counter <= counter + 1;
			//col[0] = 0;
			//end
	//end
  
  
  // Defining Internal Variables
   logic hsosc_clk;
   // logic [3:0] col2;
   // logic [3:0] row;
   //logic [3:0] unsynccol;
   //logic stopscan;
   logic [3:0] oldpress, newpress, s;
   logic [7:0] currentpress;
   logic pulseenable, rowpressed; //, stopscan;
  
	// Internal high-speed oscillator
	HSOSC #(.CLKHF_DIV(2'b01)) 
         hf_osc (.CLKHFPU(1'b1), .CLKHFEN(1'b1), .CLKHF(hsosc_clk));
 
	// Now to call on my slowclock file
	slowclock sc(reset, hsosc_clk, clk);  
	
   //// Now to call on synchronizer file for rows
	//synchronizer syncrow(clk, reset, unsyncrow, row);
	
	//// Now to call on synchronizer file for cols
	//synchronizer synccol(clk, reset, unsynccol, col);
	
	// Now to call on keyscanner, i.e. the column FSM
    keyscanner ks(clk, reset, row, col, currentpress, rowpressed, led);
   
   // Now to call on debouncer, i.e. the debouncing FSM
   debouncer db(clk, reset, rowpressed, pulseenable); // curstate);
   
   // Now to call on the decoder that decodes the value and moves new to old value
   decoder dc(clk, reset, currentpress, pulseenable, oldpress, newpress);
  
	// Now to call on the multiplex that does the time multiplexing
	multiplex mp(clk, reset, {oldpress, newpress}, s, enable );  
  
   // Now to call on seven segment display from Lab 1
   sevensegdisplay ssd(s, seg);
  
endmodule