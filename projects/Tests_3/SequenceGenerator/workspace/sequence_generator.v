module sequence_generator (
  input wire clk,
  input wire reset,
  input wire enable,
  output reg [7:0] data
);

  // Internal state variable to keep track of the current element in the sequence
  reg [2:0] state;

  // Define the sequence of hexadecimal values
  parameter [7:0] SEQUENCE [0:7] = {8'hAF, 8'hBC, 8'hE2, 8'h78, 8'hFF, 8'hE2, 8'h0B, 8'h8D};

  // Sequential logic to update the state and output the next element of the sequence
  always @(posedge clk or posedge reset) begin
    if (reset == 1'b0) begin
      // Reset to the initial state (first element of the sequence)
      state <= 3'b000;
      data <= SEQUENCE[0];
    end else if (enable == 1'b1) begin
      // Update the state and output the next element of the sequence
      state <= state + 1;
      data <= SEQUENCE[state];
    end
  end

endmodule
