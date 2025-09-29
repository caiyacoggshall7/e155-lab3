// Name: Caiya Coggshall
// Email: caiyacoggshall@gmail.com
// Date: 9/17/25
// Summary of Purpose: This is another one of the modules containing an FSM. 
// This FSM originally had 4 states cycling through each column but that got adapted to 16 states 
// so that the press/hold one and then press another in the same column and lift registers. It also sets currentpress and rowpressed here.

module keyscanner(input logic clk,
				  input logic reset,
				  //input stopscan,
				  input logic [3:0] row,
				  output logic [3:0] col,
				  output logic [7:0] currentpress,
				  output rowpressed,
				  output logic [3:0] led);

	typedef enum logic [5:0] {SCAN0, SCAN0R0, SCAN0R1, SCAN0R2, SCAN0R3, 
							  SCAN1, SCAN1R0, SCAN1R1, SCAN1R2, SCAN1R3, 
							  SCAN2, SCAN2R0, SCAN2R1, SCAN2R2, SCAN2R3,
							  SCAN3, SCAN3R0, SCAN3R1, SCAN3R2, SCAN3R3} statetype;
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
			SCAN0:		begin
						if (row == 4'b0001) nextstate = SCAN0R0;
						else if (row == 4'b0010) nextstate = SCAN0R1;
						else if (row == 4'b0100) nextstate = SCAN0R2;
						else if (row == 4'b1000) nextstate = SCAN0R3;
						//else if (stopscan) nextstate = SCAN0; // never going to get this I think
						else nextstate = SCAN1;
						end
						
			SCAN0R0: 	begin
						if (row == 4'b0001) nextstate = SCAN0R0;
						else nextstate = SCAN0;
						end
						
			SCAN0R1: 	begin
						if (row == 4'b0010) nextstate = SCAN0R1;
						else nextstate = SCAN0;
						end
			
			SCAN0R2: 	begin
						if (row == 4'b0100) nextstate = SCAN0R2;
						else nextstate = SCAN0;
						end
						
			SCAN0R3: 	begin
						if (row == 4'b1000) nextstate = SCAN0R3;
						else nextstate = SCAN0;
						end
							
			SCAN1:		begin
						if (row == 4'b0001) nextstate = SCAN1R0;
						else if (row == 4'b0010) nextstate = SCAN1R1;
						else if (row == 4'b0100) nextstate = SCAN1R2;
						else if (row == 4'b1000) nextstate = SCAN1R3;
						//else if (stopscan) nextstate = SCAN1; // never going to get this I think
						else nextstate = SCAN2;
						end
						
			SCAN1R0: 	begin
						if (row == 4'b0001) nextstate = SCAN1R0;
						else nextstate = SCAN1;
						end
						
			SCAN1R1: 	begin
						if (row == 4'b0010) nextstate = SCAN1R1;
						else nextstate = SCAN1;
						end
			
			SCAN1R2: 	begin
						if (row == 4'b0100) nextstate = SCAN1R2;
						else nextstate = SCAN1;
						end
						
			SCAN1R3: 	begin
						if (row == 4'b1000) nextstate = SCAN1R3;
						else nextstate = SCAN1;
						end


			SCAN2:		begin
						if (row == 4'b0001) nextstate = SCAN2R0;
						else if (row == 4'b0010) nextstate = SCAN2R1;
						else if (row == 4'b0100) nextstate = SCAN2R2;
						else if (row == 4'b1000) nextstate = SCAN2R3;
						//else if (stopscan) nextstate = SCAN2; // never going to get this I think
						else nextstate = SCAN3;
						end
						
			SCAN2R0: 	begin
						if (row == 4'b0001) nextstate = SCAN2R0;
						else nextstate = SCAN2;
						end
						
			SCAN2R1: 	begin
						if (row == 4'b0010) nextstate = SCAN2R1;
						else nextstate = SCAN2;
						end
			
			SCAN2R2: 	begin
						if (row == 4'b0100) nextstate = SCAN2R2;
						else nextstate = SCAN2;
						end
						
			SCAN2R3: 	begin
						if (row == 4'b1000) nextstate = SCAN2R3;
						else nextstate = SCAN2;
						end


			SCAN3:		begin
						if (row == 4'b0001) nextstate = SCAN3R0;
						else if (row == 4'b0010) nextstate = SCAN3R1;
						else if (row == 4'b0100) nextstate = SCAN3R2;
						else if (row == 4'b1000) nextstate = SCAN3R3;
						//else if (stopscan) nextstate = SCAN3; // never going to get this I think
						else nextstate = SCAN0;
						end
						
			SCAN3R0: 	begin
						if (row == 4'b0001) nextstate = SCAN3R0;
						else nextstate = SCAN0;
						end
						
			SCAN3R1: 	begin
						if (row == 4'b0010) nextstate = SCAN3R1;
						else nextstate = SCAN0;
						end
			
			SCAN3R2: 	begin
						if (row == 4'b0100) nextstate = SCAN3R2;
						else nextstate = SCAN0;
						end
						
			SCAN3R3: 	begin
						if (row == 4'b1000) nextstate = SCAN3R3;
						else nextstate = SCAN0;
						end
			
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
			
			SCAN0R0:		// if (|row[3:0] == 1) 
							begin
							currentpress = {4'b0001, row}; //{4'b0100, row}; // shifting col by 2 cycles so save the one from 2 cols ago
							col = 4'b0001;
							end
			
			SCAN0R1:		// if (|row[3:0] == 1) 
							begin
							currentpress = {4'b0001, row}; //{4'b0100, row}; // shifting col by 2 cycles so save the one from 2 cols ago
							col = 4'b0001;
							end
							
			SCAN0R2:		// if (|row[3:0] == 1) 
							begin
							currentpress = {4'b0001, row}; //{4'b0100, row}; // shifting col by 2 cycles so save the one from 2 cols ago
							col = 4'b0001;
							end
							
			SCAN0R3:		// if (|row[3:0] == 1) 
							begin
							currentpress = {4'b0001, row}; //{4'b0100, row}; // shifting col by 2 cycles so save the one from 2 cols ago
							col = 4'b0001;
							end
							
							
			SCAN1:		// if (|row[3:0] == 1) 
							begin
							currentpress = {4'b0010, row}; //{4'b1000, row};
							col = 4'b0010;
							end
			SCAN1R0:		// if (|row[3:0] == 1) 
							begin
							currentpress = {4'b0010, row}; //{4'b1000, row};
							col = 4'b0010;
							end
			
			SCAN1R1:		// if (|row[3:0] == 1) 
							begin
							currentpress = {4'b0010, row}; //{4'b1000, row};
							col = 4'b0010;
							end
							
			SCAN1R2:		// if (|row[3:0] == 1) 
							begin
							currentpress = {4'b0010, row}; //{4'b1000, row};
							col = 4'b0010;
							end
			
			SCAN1R3:		// if (|row[3:0] == 1) 
							begin
							currentpress = {4'b0010, row}; //{4'b1000, row};
							col = 4'b0010;
							end

			SCAN2:		//if (|row[3:0] == 1) 
							begin
							currentpress = {4'b0100, row}; //{4'b0001, row};
							col = 4'b0100;
							end
			
			SCAN2R0:		//if (|row[3:0] == 1) 
							begin
							currentpress = {4'b0100, row}; //{4'b0001, row};
							col = 4'b0100;
							end
							
			SCAN2R1:		//if (|row[3:0] == 1) 
							begin
							currentpress = {4'b0100, row}; //{4'b0001, row};
							col = 4'b0100;
							end
							
			SCAN2R2:		//if (|row[3:0] == 1) 
							begin
							currentpress = {4'b0100, row}; //{4'b0001, row};
							col = 4'b0100;
							end

			SCAN2R3:		//if (|row[3:0] == 1) 
							begin
							currentpress = {4'b0100, row}; //{4'b0001, row};
							col = 4'b0100;
							end

			SCAN3:		// if (|row[3:0] == 1) 
							begin
							currentpress = {4'b1000, row}; //{4'b0010, row}; //sync
							col = 4'b1000; // unsync
							end			
			
			SCAN3R0:		// if (|row[3:0] == 1) 
							begin
							currentpress = {4'b1000, row}; //{4'b0010, row}; //sync
							col = 4'b1000; // unsync
							end		
			
			SCAN3R1:		// if (|row[3:0] == 1) 
							begin
							currentpress = {4'b1000, row}; //{4'b0010, row}; //sync
							col = 4'b1000; // unsync
							end		
			
			SCAN3R2:		// if (|row[3:0] == 1) 
							begin
							currentpress = {4'b1000, row}; //{4'b0010, row}; //sync
							col = 4'b1000; // unsync
							end		
							
			SCAN3R3:		// if (|row[3:0] == 1) 
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


