module StateEncoder (
  input wire [3:0] state,
  output wire [3:0] encoded_state
);
  assign encoded_state = state;
endmodule
