module lfsr (
  input wire clk,
  input wire reset,
  output wire [7:0] data
);

  reg [7:0] state;
  wire feedback;

  assign feedback = state[1] ^ state[4] ^ state[6] ^ state[7];

  always @(posedge clk or negedge reset) begin
    if (!reset) begin
      state <= 8'b10001010;
    end else begin
      state <= {state[6:0], feedback};
    end
  end

  assign data = state;

endmodule
