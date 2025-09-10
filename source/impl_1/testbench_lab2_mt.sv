// testbench_lab2_mt.sv
// Mayu Tatsumi; mtatsumi@g.hmc.edu
// 2025-09-07

// Checks if top-module lab2_mt behaves as expected. seg1en and seg2en should toggle
// and seg should change at the same frequency as well. LEDs should not change at the
// same rate as the clk, only as the stimuli change. Outputs a terminal message with
// number of total tests and errors.

// Note: Input s[3:0] and output seg[6:0] are active low.

`timescale 1 ns / 1 ps

module testbench_lab2_mt();

	logic       clk, reset;
	logic [3:0] onboard_sw, bboard_sw;
	logic       seg1en, seg2en;
	logic [4:0] led, led_expected;
	logic [6:0] seg, seg_expected;
	
	logic [31:0] test_idx, errors;

	lab2_mt dut(reset, onboard_sw, bboard_sw, seg1en, seg2en, led, seg);
	
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
				// 625,000 ps for seg_sel to alternate
				#10; $display("starting case %0d a", test_idx);
				led_expected = (i % 10000) + (j % 10000);
				if (seg2en) begin
					if (bboard_sw === 4'b1111) seg_expected = 1000000;
					else if (bboard_sw === 4'b1110) seg_expected = 7'b1111001;
					else if (bboard_sw === 4'b1101) seg_expected = 7'b0100100;
					else if (bboard_sw === 4'b1100) seg_expected = 7'b0110000;
					else if (bboard_sw === 4'b1011) seg_expected = 7'b0011001;
					else if (bboard_sw === 4'b1010) seg_expected = 7'b0010010;
					else if (bboard_sw === 4'b1001) seg_expected = 7'b0000010;
					else if (bboard_sw === 4'b1000) seg_expected = 7'b1111000;
					else if (bboard_sw === 4'b0111) seg_expected = 7'b0000000;
					else if (bboard_sw === 4'b0110) seg_expected = 7'b0011000;
					else if (bboard_sw === 4'b0101) seg_expected = 7'b0001000;
					else if (bboard_sw === 4'b0100) seg_expected = 7'b0000011;
					else if (bboard_sw === 4'b0011) seg_expected = 7'b1000110;
					else if (bboard_sw === 4'b0010) seg_expected = 7'b0100001;
					else if (bboard_sw === 4'b0001) seg_expected = 7'b0000110;
					else if (bboard_sw === 4'b0000) seg_expected = 7'b0001110;
				end else begin
					if (onboard_sw === 4'b1111) seg_expected = 1000000;
					else if (onboard_sw === 4'b1110) seg_expected = 7'b1111001;
					else if (onboard_sw === 4'b1101) seg_expected = 7'b0100100;
					else if (onboard_sw === 4'b1100) seg_expected = 7'b0110000;
					else if (onboard_sw === 4'b1011) seg_expected = 7'b0011001;
					else if (onboard_sw === 4'b1010) seg_expected = 7'b0010010;
					else if (onboard_sw === 4'b1001) seg_expected = 7'b0000010;
					else if (onboard_sw === 4'b1000) seg_expected = 7'b1111000;
					else if (onboard_sw === 4'b0111) seg_expected = 7'b0000000;
					else if (onboard_sw === 4'b0110) seg_expected = 7'b0011000;
					else if (onboard_sw === 4'b0101) seg_expected = 7'b0001000;
					else if (onboard_sw === 4'b0100) seg_expected = 7'b0000011;
					else if (onboard_sw === 4'b0011) seg_expected = 7'b1000110;
					else if (onboard_sw === 4'b0010) seg_expected = 7'b0100001;
					else if (onboard_sw === 4'b0001) seg_expected = 7'b0000110;
					else if (onboard_sw === 4'b0000) seg_expected = 7'b0001110;
				end
				
				assert(seg1en === 1'b0) else begin $display("Fail: seg1en = ON, expected: OFF. Inputs: onb: %b, bb: %b", onboard_sw, bboard_sw); errors = errors + 1; end
				assert(seg2en === 1'b1) else begin $display("Fail: seg2en = OFF, expected: ON. Inputs: onb: %b, bb: %b", onboard_sw, bboard_sw); errors = errors + 1; end
				assert(led === led_expected) else begin $display("Fail: led = %b, expected = %b. Inputs: onb: %b, bb: %b", led, led_expected, onboard_sw, bboard_sw); errors = errors + 1; end
				assert(seg === seg_expected) else begin $display("Fail: seg = %b, expected = %b. Inputs: onb: %b, bb: %b", seg, seg_expected, onboard_sw, bboard_sw); errors = errors + 1; end
					
				#625000; $display("starting case %0d b", test_idx);
				if (seg1en) begin
					if (onboard_sw === 4'b1111) seg_expected = 1000000;
					else if (onboard_sw === 4'b1110) seg_expected = 7'b1111001;
					else if (onboard_sw === 4'b1101) seg_expected = 7'b0100100;
					else if (onboard_sw === 4'b1100) seg_expected = 7'b0110000;
					else if (onboard_sw === 4'b1011) seg_expected = 7'b0011001;
					else if (onboard_sw === 4'b1010) seg_expected = 7'b0010010;
					else if (onboard_sw === 4'b1001) seg_expected = 7'b0000010;
					else if (onboard_sw === 4'b1000) seg_expected = 7'b1111000;
					else if (onboard_sw === 4'b0111) seg_expected = 7'b0000000;
					else if (onboard_sw === 4'b0110) seg_expected = 7'b0011000;
					else if (onboard_sw === 4'b0101) seg_expected = 7'b0001000;
					else if (onboard_sw === 4'b0100) seg_expected = 7'b0000011;
					else if (onboard_sw === 4'b0011) seg_expected = 7'b1000110;
					else if (onboard_sw === 4'b0010) seg_expected = 7'b0100001;
					else if (onboard_sw === 4'b0001) seg_expected = 7'b0000110;
					else if (onboard_sw === 4'b0000) seg_expected = 7'b0001110;
				end else begin
					if (bboard_sw === 4'b1111) seg_expected = 1000000;
					else if (bboard_sw === 4'b1110) seg_expected = 7'b1111001;
					else if (bboard_sw === 4'b1101) seg_expected = 7'b0100100;
					else if (bboard_sw === 4'b1100) seg_expected = 7'b0110000;
					else if (bboard_sw === 4'b1011) seg_expected = 7'b0011001;
					else if (bboard_sw === 4'b1010) seg_expected = 7'b0010010;
					else if (bboard_sw === 4'b1001) seg_expected = 7'b0000010;
					else if (bboard_sw === 4'b1000) seg_expected = 7'b1111000;
					else if (bboard_sw === 4'b0111) seg_expected = 7'b0000000;
					else if (bboard_sw === 4'b0110) seg_expected = 7'b0011000;
					else if (bboard_sw === 4'b0101) seg_expected = 7'b0001000;
					else if (bboard_sw === 4'b0100) seg_expected = 7'b0000011;
					else if (bboard_sw === 4'b0011) seg_expected = 7'b1000110;
					else if (bboard_sw === 4'b0010) seg_expected = 7'b0100001;
					else if (bboard_sw === 4'b0001) seg_expected = 7'b0000110;
					else if (bboard_sw === 4'b0000) seg_expected = 7'b0001110;
				end
				
				assert(seg1en === 1'b1) else begin $display("Fail: seg1en = OFF, expected: ON. Inputs: onb = %b, bb = %b", onboard_sw, bboard_sw); errors = errors + 1; end
				assert(seg2en === 1'b0) else begin $display("Fail: seg2en = ON, expected: OFF. Inputs: onb = %b, bb = %b", onboard_sw, bboard_sw); errors = errors + 1; end
				assert(led === led_expected) else begin $display("Fail: led = %b, expected = %b. Inputs: onb: %b, bb: %b", led, led_expected, onboard_sw, bboard_sw); errors = errors + 1; end
				assert(seg === seg_expected) else begin $display("Fail: seg = %b, expected = %b. Inputs: onb: %b, bb: %b", seg, seg_expected, onboard_sw, bboard_sw); errors = errors + 1; end
						
				#625000; test_idx++;
			end
		end
		
		$display("Completed %d tests with %0b errors", test_idx, errors);
		$stop;
	end	
endmodule