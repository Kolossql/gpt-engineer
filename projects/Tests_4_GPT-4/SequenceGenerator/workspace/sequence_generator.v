module SequenceGenerator (
    input wire clk,
    input wire reset_n,
    input wire enable,
    output reg [7:0] data
);
    // State encoding
    parameter [2:0] S_AF = 3'b000, // 0xAF
                    S_BC = 3'b001, // 0xBC
                    S_E2 = 3'b010, // 0xE2
                    S_78 = 3'b011, // 0x78
                    S_FF = 3'b100, // 0xFF
                    S_0B = 3'b101, // 0x0B
                    S_8D = 3'b110; // 0x8D

    // Current state
    reg [2:0] state;

    // State machine
    always @(posedge clk or negedge reset_n) begin
        if (!reset_n) begin
            state <= S_AF;
        end else if (enable) begin
            case (state)
                S_AF: state <= S_BC;
                S_BC: state <= S_E2;
                S_E2: state <= S_78;
                S_78: state <= S_FF;
                S_FF: state <= S_E2;
                S_E2: state <= S_0B;
                S_0B: state <= S_8D;
                S_8D: state <= S_AF;
                default: state <= S_AF;
            endcase
        end
    end

    // Output register
    always @(state) begin
        case (state)
            S_AF: data = 8'hAF;
            S_BC: data = 8'hBC;
            S_E2: data = 8'hE2;
            S_78: data = 8'h78;
            S_FF: data = 8'hFF;
            S_0B: data = 8'h0B;
            S_8D: data = 8'h8D;
            default: data = 8'hAF;
        endcase
    end
endmodule
