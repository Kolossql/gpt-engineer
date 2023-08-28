module SequenceGenerator (
    input wire clk,
    input wire reset_n,
    input wire enable,
    output reg [7:0] data
);

    // State encoding
    parameter S0 = 3'b000, // State for 0xAF
              S1 = 3'b001, // State for 0xBC
              S2 = 3'b010, // State for 0xE2
              S3 = 3'b011, // State for 0x78
              S4 = 3'b100, // State for 0xFF
              S5 = 3'b101, // State for 0xE2
              S6 = 3'b110, // State for 0x0B
              S7 = 3'b111; // State for 0x8D

    // Current state
    reg [2:0] state;

    // State machine
    always @(posedge clk or negedge reset_n) begin
        if (!reset_n) begin
            state <= S0;
        end else if (enable) begin
            case (state)
                S0: state <= S1;
                S1: state <= S2;
                S2: state <= S3;
                S3: state <= S4;
                S4: state <= S5;
                S5: state <= S6;
                S6: state <= S7;
                S7: state <= S0;
                default: state <= S0;
            endcase
        end
    end

    // Output register
    always @(state) begin
        case (state)
            S0: data = 8'hAF;
            S1: data = 8'hBC;
            S2: data = 8'hE2;
            S3: data = 8'h78;
            S4: data = 8'hFF;
            S5: data = 8'hE2;
            S6: data = 8'h0B;
            S7: data = 8'h8D;
            default: data = 8'hAF;
        endcase
    end

endmodule
