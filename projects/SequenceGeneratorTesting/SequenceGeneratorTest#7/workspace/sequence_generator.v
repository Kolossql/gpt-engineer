module SequenceGenerator (
  input wire clk,
  input wire reset,
  input wire enable,
  output reg [7:0] data
);

  // Internal state variable to keep track of the current sequence index
  reg [2:0] sequenceIndex;

  // Sequence values
  reg [7:0] sequence [7:0];

  // Initialize the array using a generate block
  generate
    for (genvar i = 0; i < 8; i = i + 1) begin : INIT_SEQ
      initial begin
        sequence[i] = {8'hAF, 8'hBC, 8'hE2, 8'h78, 8'hFF, 8'hE2, 8'h0B, 8'h8D};
      end
    end
  endgenerate

  always @(posedge clk or posedge reset) begin
    if (reset == 1'b0) begin
      // Reset the sequence index and output the first element of the sequence
      sequenceIndex <= 3'b000;
      data <= sequence[0];
    end else if (enable == 1'b1) begin
      // Increment the sequence index and output the corresponding sequence element
      sequenceIndex <= sequenceIndex + 1;
      data <= sequence[sequenceIndex];
    end
  end

endmodule
