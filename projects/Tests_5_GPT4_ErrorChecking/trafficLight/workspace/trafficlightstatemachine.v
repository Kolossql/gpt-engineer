module TrafficLightStateMachine(
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

    // Counter for the number of clock cycles
    reg [5:0] counter;

    // State Logic
    always @(posedge clk or negedge reset_n) begin
        if (!reset_n) begin
            state <= RED;
            counter <= 32;
        end else if (enable && counter == 0) begin
            state <= next_state;
            case (state)
                RED: counter <= 32;
                GREEN: counter <= 20;
                YELLOW: counter <= 7;
            endcase
        end else if (enable) begin
            counter <= counter - 1;
        end
    end

    // Next State Logic
    always @(*) begin
        case (state)
            RED: next_state = GREEN;
            GREEN: next_state = YELLOW;
            YELLOW: next_state = RED;
            default: next_state = RED;
        endcase
    end

    // Output Logic
    assign red = (state == RED);
    assign yellow = (state == YELLOW);
    assign green = (state == GREEN);

endmodule
