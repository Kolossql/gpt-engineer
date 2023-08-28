module state_encoder (
  input wire [1:0] state,
  output wire [1:0] state_binary
);

  assign state_binary = state;

endmodule
