module ABRO_Module (
  input wire clk,
  input wire reset,
  input wire A,
  input wire B,
  output wire O,
  output wire [1:0] state
);

  wire [1:0] next_state;
  wire [1:0] current_state;

  ABRO_StateMachine ABRO_SM (
    .clk(clk),
    .reset(reset),
    .A(A),
    .B(B),
    .next_state(next_state),
    .current_state(current_state)
  );

  assign state = current_state;
  assign O = (current_state == 2'b11);

endmodule
