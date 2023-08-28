module ABROStateMachine (
    input wire clk,
    input wire reset_n,
    input wire A,
    input wire B,
    output wire O,
    output reg [3:0] State
);

    // State Register
    always @(posedge clk or negedge reset_n) begin
        if (!reset_n)
            State <= 4'b0001; // Initial state
        else
            State <= State; // Hold state
    end

    // State Logic
    always @(State or A or B) begin
        case (State)
            4'b0001: // State 1: Waiting for A and B
                if (A && B)
                    State <= 4'b0010; // Move to State 2
            4'b0010: // State 2: Output state
                State <= 4'b0001; // Move back to State 1
            default:
                State <= 4'b0001; // Default to State 1
        endcase
    end

    // Output Logic
    assign O = (State == 4'b0010) ? 1'b1 : 1'b0;

endmodule
