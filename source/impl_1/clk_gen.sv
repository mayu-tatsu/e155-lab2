// clk_gen.sv
// Mayu Tatsumi; mtatsumi@g.hmc.edu
// 2025-09-09

// Generates a 6 MHz clock using the iCE40UP's onboard
// high-speed oscillator. The module, HSCOSC, takes in a
// CLKHF_DIV to specify frequency and outputs the new clk
// from the port CLKHF.

module clk_gen(
	output logic clk
);

	// 6 MHz clk generation
	HSOSC #(.CLKHF_DIV(2'b11))
		hf_osc (.CLKHFPU(1'b1), .CLKHFEN(1'b1), .CLKHF(clk));
		
endmodule