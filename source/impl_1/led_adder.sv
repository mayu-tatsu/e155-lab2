// led_adder.sv
// Mayu Tatsumi; mtatsumi@g.hmc.edu
// 2025-09-07

module led_adder(
	input  logic [3:0] onboard_sw, bboard_sw,
	output logic [4:0] led
);

	led = ~onboard_sw + ~bboard_sw;

endmodule