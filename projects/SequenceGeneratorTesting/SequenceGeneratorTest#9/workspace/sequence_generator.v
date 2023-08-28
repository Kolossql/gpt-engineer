module SequenceGenerator (
  input wire clk,
  input wire reset,
  input wire enable,
  output reg [7:0] data
);

  // Internal state variable to keep track of the current sequence index
  reg [2:0] sequenceIndex;

  // Sequence values in hexadecimal format
  // parameter [64:0] sequence  = {
  //   8'hAF, 8'hBC, 8'hE2, 8'h78, 8'hFF, 8'hE2, 8'h0B, 8'h8D
  // };
  reg [7:0] sequence [0:7];

  // Output the current sequence value
  always @(posedge clk or posedge reset) begin
    if (reset) begin
      sequenceIndex <= 3'b000;
      sequence[0] <= 8'hAF; // Reset to initial state
      data <= sequence[0]; // Output the first element of the sequence
    end else if (enable) begin
      sequenceIndex <= sequenceIndex + 1; // Increment the sequence index
      // data <= sequence[8*sequenceIndex[2:0]:56]; // Output the corresponding sequence value
    end
  end

endmodule
