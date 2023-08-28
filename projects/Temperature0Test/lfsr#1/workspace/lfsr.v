module LFSR (
  input wire clk,
  input wire reset,
  output wire [7:0] data
);

  reg [7:0] state;

  always @(posedge clk or negedge reset) begin
    if (!reset) begin
      state <= 8'b10001010;
    end else begin
      state <= {state[6:0], state[7] ^ state[4] ^ state[1] ^ state[0]};
    end
  end

  assign data = state;

endmodule
