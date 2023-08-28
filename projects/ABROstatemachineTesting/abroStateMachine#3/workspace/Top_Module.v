module Top_Module (
  input wire clk,
  input wire reset,
  input wire A,
  input wire B,
  output reg O,
  output reg [1:0] state
);

  // Instantiate ABRO_Module
  ABRO_Module abro (
    .clk(clk),
    .reset(reset),
    .A(A),
    .B(B),
    .O(O),
    .state(state)
  );

endmodule
