// led_adder.sv
// Mayu Tatsumi; mtatsumi@g.hmc.edu
// 2025-09-07

// Outputs 5-bit binary value for the LEDs displaying the
// sum of two 4-bit binary switch inputs.

// Note: Switches are active low.

module led_adder(
	input  logic [3:0] onboard_sw,
	input  logic [3:0] bboard_sw,
	output logic [4:0] led
);

	logic [3:0] onboard_val;
	logic [3:0] bboard_val;

    assign onboard_val = ~onboard_sw;
    assign bboard_val = ~bboard_sw;
	
    assign led = onboard_val + bboard_val;
endmodule