// lab2_mt.sv
// Mayu Tatsumi; mtatsumi@g.hmc.edu
// 2025-09-06

// Top-level module generating a 24MHz clk through the HSOSC module
// and instantiating all of the necessary modules to create desired
// outputs from inputs.

// do we need a reset?

module lab2_mt(
	input  logic [3:0] onboard_sw, bboard_sw,
	output logic       seg1sel, seg2sel,
	output logic [4:0] led,
	output logic [6:0] seg
);

	logic clk;
	logic [6:0] sw;

	// 24 MHz clk generation
	HSOSC #(.CLKHF_DIV(2'b01))
		hf_osc (.CLKHFPU(1'b1), .CLKHFEN(1'b1), .CLKHF(clk));
		
	led_adder   leds(onboard_sw, bboard_sw, led);
	sev_seg_sel selector(clk, onboard_sw, bboard_sw, sw, seg1sel, seg2sel);
	sev_seg     dual_segs(sw, seg);

endmodule