module LFSR (
    input wire clk,
    input wire reset_n,
    output wire [7:0] data
);

    // Shift Register
    reg [7:0] shift_reg;

    // Feedback Logic
    wire feedback;
    assign feedback = shift_reg[7] ^ shift_reg[6] ^ shift_reg[4] ^ shift_reg[1];

    // Reset Logic and Shift Register Update
    always @(posedge clk or negedge reset_n) begin
        if (~reset_n)
            shift_reg <= 8'b10001010; // Initial state
        else
            shift_reg <= {shift_reg[6:0], feedback};
    end

    // Output Data
    assign data = shift_reg;

endmodule
