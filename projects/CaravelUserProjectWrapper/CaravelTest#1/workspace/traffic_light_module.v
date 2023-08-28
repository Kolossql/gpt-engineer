module TrafficLightModule(
    input wire clk,
    input wire reset_n,
    input wire enable,
    output wire red,
    output wire yellow,
    output wire green
);

    // Define the states of the traffic light
    parameter IDLE = 2'b00;
    parameter RED = 2'b01;
    parameter GREEN = 2'b10;
    parameter YELLOW = 2'b11;

    // Internal state register
    reg [1:0] state;

    // Counter for clock cycles
    reg [5:0] counter;

    // Output assignments
    assign red = (state == RED) ? 1'b1 : 1'b0;
    assign yellow = (state == YELLOW) ? 1'b1 : 1'b0;
    assign green = (state == GREEN) ? 1'b1 : 1'b0;

    // State machine logic
    always @(posedge clk or negedge reset_n) begin
        if (~reset_n) begin
            // Reset to initial state
            state <= IDLE;
            counter <= 6'd0;
        end else if (enable) begin
            // State transition logic
            case (state)
                IDLE: begin
                    if (counter == 6'd31) begin
                        state <= GREEN;
                        counter <= 6'd0;
                    end else begin
                        state <= IDLE;
                        counter <= counter + 1;
                    end
                end
                GREEN: begin
                    if (counter == 6'd19) begin
                        state <= YELLOW;
                        counter <= 6'd0;
                    end else begin
                        state <= GREEN;
                        counter <= counter + 1;
                    end
                end
                YELLOW: begin
                    if (counter == 6'd6) begin
                        state <= RED;
                        counter <= 6'd0;
                    end else begin
                        state <= YELLOW;
                        counter <= counter + 1;
                    end
                end
                RED: begin
                    if (counter == 6'd0) begin
                        state <= IDLE;
                        counter <= 6'd0;
                    end else begin
                        state <= RED;
                        counter <= counter + 1;
                    end
                end
                default: begin
                    state <= IDLE;
                    counter <= 6'd0;
                end
            endcase
        end else begin
            // Pause state transitions when enable is low
            state <= state;
            counter <= counter;
        end
    end

endmodule
