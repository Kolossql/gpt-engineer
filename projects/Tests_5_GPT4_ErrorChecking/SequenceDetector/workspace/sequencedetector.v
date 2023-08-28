module SequenceDetector (
    input wire clk,
    input wire reset_n,
    input wire [2:0] data_in,
    output reg sequence_found
);

    // Define the states
    parameter S0 = 0, S1 = 1, S2 = 2, S3 = 3, S4 = 4, S5 = 5, S6 = 6, S7 = 7, S8 = 8;
    reg [3:0] current_state, next_state;

    // State Machine
    always @(posedge clk or negedge reset_n) begin
        if (!reset_n)
            current_state <= S0;
        else
            current_state <= next_state;
    end

    // Sequence Detector
    always @(current_state or data_in) begin
        case (current_state)
            S0: if (data_in == 3'b001) next_state = S1; else next_state = S0;
            S1: if (data_in == 3'b101) next_state = S2; else next_state = S0;
            S2: if (data_in == 3'b110) next_state = S3; else next_state = S0;
            S3: if (data_in == 3'b000) next_state = S4; else next_state = S0;
            S4: if (data_in == 3'b110) next_state = S5; else next_state = S0;
            S5: if (data_in == 3'b110) next_state = S6; else next_state = S0;
            S6: if (data_in == 3'b011) next_state = S7; else next_state = S0;
            S7: if (data_in == 3'b101) next_state = S8; else next_state = S0;
            S8: next_state = S0;
            default: next_state = S0;
        endcase
    end

    // Output Register
    always @(current_state) begin
        if (current_state == S8)
            sequence_found <= 1;
        else
            sequence_found <= 0;
    end

endmodule
