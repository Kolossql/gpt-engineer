module ABROStateMachine (
    input wire clk,
    input wire reset_n,
    input wire A,
    input wire B,
    output wire O,
    output wire [1:0] State
);

    // State Register
    reg [1:0] current_state, next_state;

    // Next State Logic
    always @(posedge clk or negedge reset_n) begin
        if (!reset_n)
            current_state <= 2'b00;
        else
            current_state <= next_state;
    end

    // Next State Logic
    always @(*) begin
        case (current_state)
            2'b00: begin
                if (A)
                    next_state = 2'b01;
                else
                    next_state = current_state;
            end
            2'b01: begin
                if (B)
                    next_state = 2'b10;
                else
                    next_state = current_state;
            end
            2'b10: begin
                if (!A && !B)
                    next_state = 2'b00;
                else
                    next_state = current_state;
            end
            default: next_state = 2'b00;
        endcase
    end

    // Output Logic
    assign O = (current_state == 2'b10) ? 1'b1 : 1'b0;

    // State Output
    assign State = current_state;

endmodule
