module MainModule (
  input wire clk,
  input wire reset,
  input wire A,
  input wire B,
  output wire O,
  output wire [1:0] state
);

  wire reset_A;
  wire reset_B;
  wire [1:0] next_state;

  ResetLogic reset_logic (
    .clk(clk),
    .reset(reset),
    .A(A),
    .B(B),
    .reset_A(reset_A),
    .reset_B(reset_B)
  );

  StateRegister state_register (
    .clk(clk),
    .reset(reset),
    .next_state(next_state),
    .state(state)
  );

  ABRO_StateMachine abro_state_machine (
    .clk(clk),
    .reset(reset),
    .A(A),
    .B(B),
    .O(O),
    .state(next_state)
  );

  OutputLogic output_logic (
    .clk(clk),
    .A(A),
    .B(B),
    .O(O)
  );

endmodule
