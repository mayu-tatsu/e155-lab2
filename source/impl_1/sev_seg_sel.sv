// sev_seg_sel.sv
// Mayu Tatsumi; mtatsumi@g.hmc.edu
// 2025-09-07

// Alternates the output between the two seven segment display
// by enabling either seg1sel or seg2sel. These connect to the
// PNP transistors which activate the common anodes of either
// display. The output sw changes based on this clk-based
// toggle, but both displays use the same output pins.

// Note: Using posedge & negedge doesn't work

module sev_seg_sel(
	input  logic       clk,
	input  logic [3:0] onboard_sw, bboard_sw,
	output logic       seg1sel, seg2sel,
	output logic [3:0] sw
);

	// alternate_led changes the display at every rising clk edge
	
	logic alternate_led;

    always_ff @(posedge clk) begin
        alternate_led <= ~alternate_led;
    end

    always_comb begin
        if (alternate_led) begin
			seg2sel = 1'b0;
            seg1sel = 1'b1;
            sw = onboard_sw;
        end
		else begin
            seg1sel = 1'b0;
            seg2sel = 1'b1;
            sw = bboard_sw;
        end
    end
	
endmodule