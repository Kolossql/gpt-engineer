module ABROStateMachine (
    input wire clk,
    input wire reset,
    input wire A,
    input wire B,
    output wire O,
    output wire [3:0] state
);

    // Internal state variable
    reg [3:0] current_state;

    // Output O logic
    assign O = (current_state == 4'b1111);

    // State transition logic
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            current_state <= 4'b0000;
        end else begin
            case (current_state)
                4'b0000: begin
                    if (A && B) begin
                        current_state <= 4'b0001;
                    end
                end
                4'b0001: begin
                    if (A && !B) begin
                        current_state <= 4'b0010;
                    end
                end
                4'b0010: begin
                    if (!A && B) begin
                        current_state <= 4'b0100;
                    end
                end
                4'b0100: begin
                    if (A && B) begin
                        current_state <= 4'b1111;
                    end
                end
                default: begin
                    current_state <= 4'b0000;
                end
            endcase
        end
    end

    // Output state logic
    assign state = current_state;

endmodule
