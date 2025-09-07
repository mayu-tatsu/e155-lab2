module seven_seg_mux (
    input  logic        clk,
    input  logic        rst_n,
    input  logic [3:0]  in_0,
    input  logic [3:0]  in_1,
    output logic [6:0]  anode_out,
    output logic [1:0]  anode_sel
);

    logic [3:0] counter;
    logic [3:0] selected_in;
    
    // Anode selector logic
    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            counter <= 4'b0000;
        end else begin
            counter <= counter + 1'b1;
        end
    end

    // Mux logic - switches between in_0 and in_1 based on the counter MSB
    always_comb begin
        if (counter[3] == 1'b0) begin
            selected_in = in_0;
            anode_sel   = 2'b01; // Select display 0
        end else begin
            selected_in = in_1;
            anode_sel   = 2'b10; // Select display 1
        end
    end

    // Instantiate the single seven segment decoder
    seven_seg_decoder decoder_inst (
        .bin_in     (selected_in),
        .anode_out  (anode_out)
    );
    
endmodule