module SequenceGenerator (
  input wire clk,
  input wire reset,
  input wire enable,
  output reg [7:0] data
);

  // Internal state variable to keep track of the current position in the sequence
  reg [2:0] position;

  // Sequence values
  reg [7:0] sequence [7:0] = {8'hAF, 8'hBC, 8'hE2, 8'h78, 8'hFF, 8'hE2, 8'h0B, 8'h8D};

  always @(posedge clk or posedge reset) begin
    if (reset) begin
      // Reset the position and output the first element of the sequence
      position <= 3'b000;
      data <= sequence[0];
    end else if (enable) begin
      // Increment the position and output the corresponding element of the sequence
      position <= position + 1;
      data <= sequence[position];
    end
  end

endmodule
