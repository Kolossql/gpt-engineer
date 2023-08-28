module abro_module (
  input wire clk,
  input wire reset,
  input wire A,
  input wire B,
  output wire O,
  output wire [n-1:0] state
);

  // Instantiate the State Register module
  state_register #(.n(n)) state_reg (
    .clk(clk),
    .reset(reset),
    .A(A),
    .B(B),
    .state(state)
  );

  // Instantiate the Output Register module
  output_register output_reg (
    .clk(clk),
    .reset(reset),
    .A(A),
    .B(B),
    .O(O)
  );

endmodule
