module ABROStateMachine (
    input wire clk,
    input wire reset,
    input wire A,
    input wire B,
    output wire O,
    output reg [1:0] State
);

    // State Register
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            State <= 2'b00; // Initial state
        end else begin
            case (State)
                2'b00: begin // State 0
                    if (A || B) begin
                        State <= 2'b01; // Transition to State 1
                    end
                end
                2'b01: begin // State 1
                    if (A && B) begin
                        State <= 2'b10; // Transition to State 2
                    end
                end
                2'b10: begin // State 2
                    State <= 2'b00; // Transition back to Initial state
                end
                default: begin
                    State <= 2'b00; // Default to Initial state
                end
            endcase
        end
    end

    // Output Logic
    assign O = (State == 2'b10);

endmodule
