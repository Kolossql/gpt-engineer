module SequenceGenerator (
    input wire clk,
    input wire reset_n,
    input wire enable,
    output reg [7:0] data
);

    // Define the states for the state machine
    parameter S0 = 3'b000, // State for 0xAF
              S1 = 3'b001, // State for 0xBC
              S2 = 3'b010, // State for 0xE2
              S3 = 3'b011, // State for 0x78
              S4 = 3'b100, // State for 0xFF
              S5 = 3'b101, // State for 0xE2
              S6 = 3'b110, // State for 0x0B
              S7 = 3'b111; // State for 0x8D

    // Define the state register
    reg [2:0] state;

    // State machine and output register
    always @(posedge clk or negedge reset_n) begin
        if (!reset_n) begin
            state <= S0;
            data <= 8'hAF;
        end else if (enable) begin
            case (state)
                S0: begin state <= S1; data <= 8'hBC; end
                S1: begin state <= S2; data <= 8'hE2; end
                S2: begin state <= S3; data <= 8'h78; end
                S3: begin state <= S4; data <= 8'hFF; end
                S4: begin state <= S5; data <= 8'hE2; end
                S5: begin state <= S6; data <= 8'h0B; end
                S6: begin state <= S7; data <= 8'h8D; end
                S7: begin state <= S0; data <= 8'hAF; end
                default: begin state <= S0; data <= 8'hAF; end
            endcase
        end
    end

endmodule
