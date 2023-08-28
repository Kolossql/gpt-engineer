module SequenceDetector (
    input wire clk,
    input wire reset_n,
    input wire [2:0] data,
    output reg sequence_found
);

    // Define the states
    parameter [2:0] S0 = 3'b000;
    parameter [2:0] S1 = 3'b001;
    parameter [2:0] S2 = 3'b010;
    parameter [2:0] S3 = 3'b011;
    parameter [2:0] S4 = 3'b100;
    parameter [2:0] S5 = 3'b101;
    parameter [2:0] S6 = 3'b110;
    parameter [2:0] S7 = 3'b111;

    reg [2:0] state;
    reg [2:0] next_state;

    // State Machine
    always @(posedge clk or negedge reset_n) begin
        if (!reset_n)
            state <= S0;
        else
            state <= next_state;
    end

    // Sequence Checker and Next State Logic
    always @* begin
        sequence_found = 0;
        case (state)
            S0: if (data == 3'b001) next_state = S1; else next_state = S0;
            S1: if (data == 3'b101) next_state = S2; else next_state = S0;
            S2: if (data == 3'b110) next_state = S3; else next_state = S0;
            S3: if (data == 3'b000) next_state = S4; else next_state = S0;
            S4: if (data == 3'b110) next_state = S5; else next_state = S0;
            S5: if (data == 3'b110) next_state = S6; else next_state = S0;
            S6: if (data == 3'b011) next_state = S7; else next_state = S0;
            S7: if (data == 3'b101) begin next_state = S0; sequence_found = 1; end else next_state = S0;
            default: next_state = S0;
        endcase
    end

endmodule
