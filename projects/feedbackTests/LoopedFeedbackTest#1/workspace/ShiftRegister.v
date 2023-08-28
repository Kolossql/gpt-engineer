module ShiftRegister(
    input wire clk,
    input wire reset,
    input wire data,
    input wire shift_enable,
    output wire [7:0] stored_data
);
    reg [7:0] shift_reg;

    always @(posedge clk) begin
        if (reset == 0) begin
            shift_reg <= 8'b00000000;
        end else if (shift_enable == 1) begin
            shift_reg <= {shift_reg[6:0], data};
        end
    end

    assign stored_data = shift_reg;

endmodule
