// sev_seg_sel.sv
// Mayu Tatsumi; mtatsumi@g.hmc.edu
// 2025-09-07

// Alternates the output between the two seven segment display
// by enabling either seg1en or seg2en. These connect to the
// PNP transistors which activate the common anodes of either
// display. The output sw changes based on this clk-based
// toggle, but both displays use the same output pins.

// Note: Using posedge & negedge doesn't work

module sev_seg_sel(
	input  logic       clk, reset,
	input  logic [3:0] onboard_sw, bboard_sw,
	output logic       seg1en, seg2en,
	output logic [3:0] sw
);

	logic [31:0] counter;
	logic alternate_led;
		
	
	// converting 6 MHz clk into 100 Hz output by alternate_led
	// 6,000,000 / 100 = 60,000 / 2 = 30,000

	always_ff @(posedge clk) begin
		if (~reset) begin
			counter <= 1'b0;
			alternate_led <= 1'b0;
		end
		else if (counter < 32'd30000) counter <= counter + 1;
		else begin
			counter <= 32'b0;
			alternate_led <= ~alternate_led;
		end
	end

    always_comb begin
        if (alternate_led) begin
			seg2en = 1'b0;
			seg1en = 1'b1;
			sw = onboard_sw;
		end
		else begin
            seg1en = 1'b0;
            seg2en = 1'b1;
            sw = bboard_sw;
        end
    end
	
endmodule