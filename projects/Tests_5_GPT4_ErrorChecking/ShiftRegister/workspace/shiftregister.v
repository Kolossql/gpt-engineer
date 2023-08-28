module ShiftRegister (
    input wire clk,
    input wire reset_n,
    input wire data_in,
    input wire shift_enable,
    output reg [7:0] data_out
);

always @(posedge clk or negedge reset_n) begin
    if (!reset_n) begin
        data_out <= 8'b00000000; // Reset the shift register to initial state
    end else if (shift_enable) begin
        data_out <= {data_out[6:0], data_in}; // Shift the data bit on the right side of the data vector
    end
end

endmodule
