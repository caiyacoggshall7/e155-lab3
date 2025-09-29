// Name: Caiya Coggshall
// Email: caiyacoggshall@gmail.com
// Date: 9/17/25
// Summary of Purpose: One of the modules containing an FSM. This FSM has 4 states: idle, debounce, display and hold. 
// If in display state it tells the system pulseenable which will allow the seven seg to light up with the digit pressed as expected.


module debouncer(input logic clk,
				  input logic reset,
				  //input logic col, // TESTING
				  input logic rowpressed,
				  output logic pulseenable);
				  //output logic stopscan);
				  //output logic [3:0] curstate);

	typedef enum logic [3:0] {IDLE, DEBOUNCE, DISPLAY, HOLD} statetype;
	statetype state, nextstate;

	logic [24:0] debouncecounter;
	//logic [3:0] newcol; // TESTING

	// State Register
	always_ff @(posedge clk)
		if (reset == 0) state <= IDLE;
		else state <= nextstate;

	// Counter Register
	always_ff @(posedge clk)
		if (!reset) debouncecounter = 0;
		else if (state == DEBOUNCE) begin
			debouncecounter++;
			// newcol <= col; // TESTING
			end
		else debouncecounter = 0;



	// Next & Output State Logic
	always_comb
		case (state)
			IDLE: 		if (rowpressed) nextstate = DEBOUNCE;
						else nextstate = IDLE;
			
			DEBOUNCE:	if (!rowpressed) nextstate = IDLE;
						//else if (col != newcol) nextstate = IDLE; // TESTING
						else if (rowpressed && debouncecounter <= 7) nextstate = DEBOUNCE; // 48 Mhz * 5 ms unstability = 240 k cycles
						else nextstate = DISPLAY;
						
			DISPLAY: nextstate = HOLD;

			HOLD: if (rowpressed) nextstate = HOLD;
				   else nextstate = IDLE;

			
			//default: nextstate = IDLE;
	
	
	endcase

	
	assign pulseenable = (state == DISPLAY);//(nextstate == DEBOUNCE && rowpressed);
	//assign stopscan = (state != IDLE);
	//assign curstate = {(state == HOLD),(state == DISPLAY),(state == DEBOUNCE),(state == IDLE)};

endmodule