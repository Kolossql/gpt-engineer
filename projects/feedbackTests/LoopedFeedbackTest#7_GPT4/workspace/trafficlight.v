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
    reg [2:0] state_reg = RED, state_next;

    // Next State Logic
    always @(posedge clk or negedge reset_n) begin
        if (!reset_n) begin
            state_reg <= RED;
        end else if (enable) begin
            case (state_reg)
                RED: state_next = GREEN;
                GREEN: state_next = YELLOW;
                YELLOW: state_next = RED;
                default: state_next = RED;
            endcase
            state_reg <= state_next;
        end
    end

    // Output Logic
    assign red = (state_reg == RED);
    assign yellow = (state_reg == YELLOW);
    assign green = (state_reg == GREEN);

endmodule
