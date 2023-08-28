module ABROStateMachine (
    input wire clk,
    input wire reset_n,
    input wire A,
    input wire B,
    output wire O,
    output reg [1:0] state
);

    // State Register
    always @(posedge clk or negedge reset_n) begin
        if (!reset_n) begin
            state <= 2'b00; // Reset state
        end else begin
            // Next State Logic
            if (A && !B) begin
                state <= 2'b01; // A has been entered
            end else if (!A && B) begin
                state <= 2'b10; // B has been entered
            end else if (A && B) begin
                state <= 2'b11; // Both A and B have been entered
            end else begin
                state <= 2'b00; // Neither A nor B has been entered
            end
        end
    end

    // Output Logic
    assign O = (state == 2'b11) ? 1'b1 : 1'b0;

endmodule
