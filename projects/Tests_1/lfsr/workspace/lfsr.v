module lfsr (
  input wire clk,
  input wire reset,
  output reg [7:0] data
);

  reg [7:0] state;

  always @(posedge clk or posedge reset) begin
    if (reset) begin
      state <= 8'b10001010;
    end else begin
      state <= {state[6:0], state[7] ^ state[6] ^ state[3] ^ state[1]};
    end
  end

  assign data = state;

endmodule
