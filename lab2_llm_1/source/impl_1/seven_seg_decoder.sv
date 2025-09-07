module seven_seg_decoder (
    input  logic [3:0] bin_in,
    output logic [6:0] anode_out
);

    always_comb begin
        case (bin_in)
            4'h0: anode_out = 7'b1000000; // 0
            4'h1: anode_out = 7'b1111001; // 1
            4'h2: anode_out = 7'b0100100; // 2
            4'h3: anode_out = 7'b0110000; // 3
            4'h4: anode_out = 7'b0011001; // 4
            4'h5: anode_out = 7'b0010010; // 5
            4'h6: anode_out = 7'b0000010; // 6
            4'h7: anode_out = 7'b1111000; // 7
            4'h8: anode_out = 7'b0000000; // 8
            4'h9: anode_out = 7'b0010000; // 9
            default: anode_out = 7'b1111111; // Off
        endcase
    end
endmodule