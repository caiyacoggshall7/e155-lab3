module keyscan(input logic clk,
				  input logic reset,
				  input stopscan,
				  input logic [3:0] row,
				  output logic [3:0] col,
				  output logic [7:0] currentpress,
				  output rowpressed,
				  output logic [3:0] led);

	typedef enum logic [3:0] {SCAN0, SCAN1, SCAN2, SCAN3} statetype;
	statetype state, nextstate;
	
	//logic [3:0] saverow;

	// State Register
	always_ff @(posedge clk) begin
		if (!reset) state <= SCAN0;
		else state <= nextstate;
	end
	
	 // //To save the row for currentpress
	//always_ff @(posedge clk) begin
		//if (rowpressed)saverow <= row; // gets 0
		//else saverow <= 4'b0000;
	//end	
	//make it update the value only on the rising edge of anew press being detected

	

	// Next State Logic
	always_comb
		case (state)
			SCAN0:		if (|row[3:0] == 1 && col == 4'b0001) nextstate = SCAN0;
						else if (stopscan) nextstate = SCAN0;
						else nextstate = SCAN1;
							
			SCAN1:		if (|row[3:0] == 1 && col == 4'b0010) nextstate = SCAN1;
						else if (stopscan) nextstate = SCAN1;
						else nextstate = SCAN2;


			SCAN2:		if (|row[3:0] == 1 && col == 4'b0100) nextstate = SCAN2;
						else if (stopscan) nextstate = SCAN2;
						else nextstate = SCAN3;


			SCAN3:		if (|row[3:0] == 1 && col == 4'b1000) nextstate = SCAN3;
						else if (stopscan) nextstate = SCAN3;
						else nextstate = SCAN0;
			
			default: nextstate = SCAN0;
	endcase


	// Output State Logic
	always_comb begin
		case (state)
			SCAN0:		// if (|row[3:0] == 1) 
							begin
							currentpress = {4'b0001, row}; //{4'b0100, row}; // shifting col by 2 cycles so save the one from 2 cols ago
							col = 4'b0001;
							end
							
			SCAN1:		// if (|row[3:0] == 1) 
							begin
							currentpress = {4'b0010, row}; //{4'b1000, row};
							col = 4'b0010;
							end


			SCAN2:		//if (|row[3:0] == 1) 
							begin
							currentpress = {4'b0100, row}; //{4'b0001, row};
							col = 4'b0100;
							end


			SCAN3:		// if (|row[3:0] == 1) 
							begin
							currentpress = {4'b1000, row}; //{4'b0010, row}; //sync
							col = 4'b1000; // unsync
							end			
		
		
		endcase
		
	end
	
	//assign col =  {state==SCAN0,state==SCAN1,state==SCAN2,state==SCAN3};
	//assign currentpress = {4'b0010,row};
	assign rowpressed = (|row);
	assign led = row;

endmodule
