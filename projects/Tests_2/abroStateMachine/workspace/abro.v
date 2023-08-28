module abro (
  input wire clk,
  input wire reset,
  input wire A,
  input wire B,
  output wire O,
  output wire [3:0] state
);

  // Instantiate the StateRegister module
  StateRegister sr (
    .clk(clk),
    .reset(reset),
    .A(A),
    .B(B),
    .state(state)
  );

  // Instantiate the OutputLogic module
  OutputLogic ol (
    .state(state),
    .O(O)
  );

endmodule
