module abro_state_machine (
  input wire clk,
  input wire reset,
  input wire A,
  input wire B,
  output wire O,
  output wire [1:0] state
);

  wire [1:0] encoded_state;
  wire valid_input;

  state_register sr (
    .clk(clk),
    .reset(reset),
    .valid_input(valid_input),
    .encoded_state(encoded_state)
  );

  input_handler ih (
    .A(A),
    .B(B),
    .valid_input(valid_input)
  );

  output_logic ol (
    .encoded_state(encoded_state),
    .O(O)
  );

  state_encoder se (
    .state(encoded_state),
    .state_binary(state)
  );

  verification_output vo (
    .state(encoded_state)
  );

endmodule
