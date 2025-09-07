// Author: Gemini
// Date: 2025-09-07

// This module demonstrates time multiplexing a single sev_seg decoder
// to drive two 7-segment displays.
// The leds module provides an internal oscillator for a clock signal.
// This is a common technique to reduce pin count on an FPGA.

module seven_seg_mux (
    // Inputs from user to be displayed on the two 7-segment displays.
	input  logic [3:0] s1,
	input  logic [3:0] s2,
	input  logic       reset,
	
	// Outputs to the seven-segment displays.
	// seg is the 7-segment data.
	// an is the anode select for the two displays.
	output logic [6:0] seg,
	output logic [1:0] an
);

	// Internal signal from the oscillator in the leds module.
	logic clk;
	
	// Internal signal to select between the two inputs.
	logic sel_d;
	
	// Instantiate the oscillator module from the leds file to get a clock signal.
	// We only need the clock, so other outputs are left unconnected.
	leds clock_gen (
		.reset(1'b1), // Keep the leds module out of reset
		.s    (4'b1111), // Unused input s to leds module
		.led  ()
	);

	// This is a simplified version of the leds module. We just need the oscillator.
    // The HSOSC module is an internal component specific to certain FPGAs.
	HSOSC #(.CLKHF_DIV(2'b01))
	hf_osc (.CLKHFPU(1'b1), .CLKHFEN(1'b1), .CLKHF(clk));
	
	// A simple counter to generate the select signal for multiplexing.
	// The counter will alternate between 0 and 1, switching the active display.
	always_ff @(posedge clk) begin
		sel_d <= ~sel_d;
	end
	
	// Mux the two input data streams (s1 and s2) based on the select signal (sel_d).
	// The output of this mux is fed to the seven-segment decoder.
	logic [3:0] s_muxed;
	assign s_muxed = (sel_d) ? s1 : s2;
	
	// Instantiate the 7-segment decoder module.
	// It takes the muxed input and provides the segment signals.
	sev_seg decoder (
		.s  (s_muxed),
		.seg(seg)
	);

	// Drive the anodes of the two displays.
	// an[0] for the first display (driven by s2).
	// an[1] for the second display (driven by s1).
	// The anodes are active low, so we invert the select signal.
	// This ensures only one display is active at a time.
	assign an[0] = sel_d;
	assign an[1] = ~sel_d;
	
endmodule
