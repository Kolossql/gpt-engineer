module TrafficLightStateMachine (
    input wire clk,
    input wire reset_n,
    input wire enable,
    output wire red,
    output wire yellow,
    output wire green
);

    // Define the states
    parameter RED = 3'b000, GREEN = 3'b001, YELLOW = 3'b010;

    // State Register
    reg [2:0] state, next_state;

    // Next State Logic
    always @(posedge clk or negedge reset_n) begin
        if (!reset_n) begin
            state <= RED;
        end else if (enable) begin
            state <= next_state;
        end
    end

    // Next State Logic
    always @(*) begin
        case (state)
            RED: next_state = (enable) ? GREEN : RED;
            GREEN: next_state = (enable) ? YELLOW : GREEN;
            YELLOW: next_state = (enable) ? RED : YELLOW;
            default: next_state = RED;
        endcase
    end

    // Output Logic
    assign red = (state == RED);
    assign yellow = (state == YELLOW);
    assign green = (state == GREEN);

endmodule
