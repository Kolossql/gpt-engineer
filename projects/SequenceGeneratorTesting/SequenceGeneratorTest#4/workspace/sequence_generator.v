module sequence_generator (
  input wire clk,
  input wire reset,
  input wire enable,
  output reg [7:0] data
);

  // State Register
  reg [2:0] state;

  // Output Logic
  always @ (state)
    case (state)
      3'b000: data <= 8'hAF;
      3'b001: data <= 8'hBC;
      3'b010: data <= 8'hE2;
      3'b011: data <= 8'h78;
      3'b100: data <= 8'hFF;
      3'b101: data <= 8'hE2;
      3'b110: data <= 8'h0B;
      3'b111: data <= 8'h8D;
    endcase

  // Next State Logic
  always @ (posedge clk or posedge reset)
    if (reset)
      state <= 3'b000;
    else if (enable)
      state <= state + 1;

  // Reset Logic
  always @ (negedge reset)
    if (!reset)
      state <= 3'b000;

  // Enable Logic
  always @ (posedge clk)
    if (!enable)
      state <= 3'b000;

endmodule
