module ABRO_Module (
  input wire clk,
  input wire reset,
  input wire A,
  input wire B,
  output wire O,
  output wire [1:0] State,
  output wire [3:0] EncodedState
);

  wire [1:0] state;
  wire [3:0] encoded_state;

  ABRO_StateMachine ABRO_SM (
    .clk(clk),
    .reset(reset),
    .A(A),
    .B(B),
    .O(O),
    .State(state)
  );

  ABRO_OutputEncoder ABRO_OE (
    .State(state),
    .EncodedState(encoded_state)
  );

  assign State = state;
  assign EncodedState = encoded_state;

endmodule
