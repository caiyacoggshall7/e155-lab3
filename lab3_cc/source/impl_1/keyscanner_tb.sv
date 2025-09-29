// Name: Caiya Coggshall
// Email: caiyacoggshall@gmail.com
// Date: 9/20/25
// Summary of Purpose: This tests the keyscanner tb and is largely taken from Troy Kaufman, avaliable on the website.

`timescale 1 ns/1 ns
module keyscanner_tb();
    logic           clk;    // system clock
    logic           reset;  // active high reset
	logic			stopscan; // if stop scanning cols
	tri     [3:0]   row;   // 4-bit row input
	tri     [3:0]   col;   // 4-bit column output
    tri     [7:0] currentpress;   // 8-bit column_row output
    logic	  rowpressed;	// whether pressed
    // matrix of key presses: keys[row][col]
    logic [3:0][3:0] keys;
    // dut
    keyscanner dut(.clk(clk), .reset(reset), .stopscan(stopscan), .row(row), .col(col), .currentpress(currentpress), .rowpressed(rowpressed));
	
    // ensures rows = 4'b1111 when no key is pressed
    pulldown(row[0]);
    pulldown(row[1]);
    pulldown(row[2]);
    pulldown(row[3]);
    // keypad model using tranif
    genvar r, c;
    generate
        for (r = 0; r < 4; r++) begin : row_loop
            for (c = 0; c < 4; c++) begin : col_loop
                // when keys[r][c] == 1, connect cols[c] <-> rows[r]
                tranif1 key_switch(row[r], col[c], keys[r][c]);
            end
        end
    endgenerate
    // generate clock
    always begin
        clk = 0; #5;
        clk = 1; #5;
    end
    // task to check expected values of currentpress and rowpressed
    task check_key(input [7:0] exp_currentpress, exp_rowpressed, string msg);
        #100;
        assert (currentpress == exp_currentpress && rowpressed == exp_rowpressed)
            $display("PASSED!: %s -- got currentpress=%h rowpressed=%h expected currentpress=%h rowpressed=%h at time %0t.", msg, currentpress, rowpressed, exp_currentpress, exp_rowpressed, $time);
        else
            $display("FAILED!: %s -- got currentpress=%h rowpressed=%h expected currentpress=%h rowpressed=%h at time %0t.", msg, currentpress, rowpressed, exp_currentpress, exp_rowpressed, $time);
        #50;
    endtask
    // apply stimuli and check outputs
    initial begin
        reset = 1;
        // no key pressed
        keys = '{default:0};
        #22 reset = 0;
        // press key at row=1, col=2
        #50 keys[1][2] = 1;
        check_key(4'h6, 4'h0, "First key press");
        // release button
        keys[1][2] = 0;
        // press another key at row=0, col=0
        keys[2][3] = 1;
        check_key(4'hc, 4'h6, "Second key press");
        // release buttons
        #100 keys = '{default:0};
        #100 $stop;
    end
    // add a timeout
    initial begin
        #5000; // wait 5 us
        $error("Simulation did not complete in time.");
        $stop;
    end
endmodule