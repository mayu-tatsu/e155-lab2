// testbench_clk_gen.sv
// Mayu Tatsumi; mtatsumi@g.hmc.edu
// 2025-09-09

// Checks if output of 6 MHz from clk_gen module oscillates at the expected frequency.

`timescale 1 ns / 1 ps

module testbench_clk_gen();

	logic clk, reset;
	logic test_clk;
	
	clk_gen dut(test_clk);
	
	// generate a 100 Hz clk
	always
		begin
			clk = 1; #5; clk = 0; #5;
		end
		
	// reset
	initial
		begin
			reset = 0; #22; reset = 1;
		end
		
	initial begin
		// initialization
		#10; assert(test_clk === 1'b0) else $display("Fail: test_clk = 1'b1. Expecting 1'b0.");
		#10; assert(test_clk === 1'b1) else $display("Fail: test_clk = 1'b0. Expecting 1'b1.");
		
		$display("Completed test for clk generation.");
		$stop;
	end	
endmodule