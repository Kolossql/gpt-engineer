module SequenceGenerator (
  input wire clk,
  input wire reset,
  input wire enable,
  output reg [7:0] data
);

  // Internal state variable to keep track of the current index in the sequence
  reg [2:0] index;

  // Sequence of hexadecimal values
  reg [7:0] sequence [0:7] = {8'hAF, 8'hBC, 8'hE2, 8'h78, 8'hFF, 8'hE2, 8'h0B, 8'h8D};

  always @(posedge clk or posedge reset) begin
    if (reset == 1'b0) begin
      // Reset to the initial state (0xAF)
      index <= 3'b000;
      data <= sequence[0];
    end else if (enable == 1'b1) begin
      // Generate the next part of the sequence on the rising edge of the clock
      index <= index + 1;
      data <= sequence[index];
    end
  end

endmodule
