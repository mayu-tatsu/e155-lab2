// sev_seg_sel.sv
// Mayu Tatsumi; mtatsumi@g.hmc.edu
// 2025-09-07

module sev_seg_sel(
	input  logic       clk,
	input  logic [3:0] onboard_sw, bboard_sw,
	output logic       seg1sel, seg2sel,
	output logic [3:0] sw
);

	logic reset;
	
	always @(posedge clk) begin
		seg2sel = 1'b0;
		seg1sel = 1'b1;
		sw = onboard_sw;
	end
	
	always @(negedge clk) begin
		seg1sel = 1'b0;
		seg2sel = 1'b1;
		sw = onboard_sw;
	end
endmodule