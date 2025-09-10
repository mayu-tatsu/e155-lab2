// testbench_led_adder.sv
// Mayu Tatsumi; mtatsumi@g.hmc.edu
// 2025-09-09

// Compares outputs of led_adder module to expected values
// using assert and delay statements, checking expected frequencies.
// Outputs number of tests and errors to console.

// Note: Input onboard_sw[3:0] and bboard_sw[3:0] are active low.

`timescale 1 ns / 1 ps

module testbench_led_adder();

	logic       clk, reset;
	logic [3:0] onboard_sw, bboard_sw;
	logic [4:0] led, led_expected;
	
	logic [31:0] test_idx, errors;
		
	led_adder dut(onboard_sw, bboard_sw, led);
	
	// generate a 100 Hz clk
	always
		begin
			clk = 1; #5; clk = 0; #5;
		end
		
	// reset
	initial
		begin
			test_idx = 0; errors = 0;
			reset = 0; #22; reset = 1;
		end
		
	initial begin
		// initialization
		#10; onboard_sw = 4'b1111; bboard_sw = 4'b1111;
		
		for (int i = 0; i < 16; i++) begin
			
			// take the opposite of the last 4 digits
			onboard_sw = ~(i % 10000);
			
			for (int j = 0; j < 16; j++) begin
				bboard_sw = ~(j % 10000);
				led_expected = i + j;

				// wait for outputs to settle
				# 10; assert(led === led_expected)
				else begin
					$display("Fail: led = %b, expected = %b. Inputs: onb: %b, bb: %b", led, led_expected, onboard_sw, bboard_sw);
					errors = errors + 1;
				end
				test_idx++;
			end
		end
		
		$display("Completed %d tests with %d errors", test_idx, errors);
		$stop;
	end	
endmodule