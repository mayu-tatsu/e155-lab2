// lab2_mt.sv
// Mayu Tatsumi; mtatsumi@g.hmc.edu
// 2025-09-06

// Top-level module instantiating all necessary modules to create desired
// outputs from switch inputs.

// Note: Switches are active low.

module lab2_mt(
	input  logic       reset,
	input  logic [3:0] onboard_sw, bboard_sw,
	output logic       seg1en, seg2en,
	output logic [4:0] led,
	output logic [6:0] seg
);

	logic       clk;
	logic [6:0] sw;
		
	clk_gen     clk_generation(clk);
	led_adder   leds(onboard_sw, bboard_sw, led);
	sev_seg_sel selector(clk, reset, onboard_sw, bboard_sw, seg1en, seg2en, sw);
	sev_seg     dual_segs(sw, seg);

endmodule