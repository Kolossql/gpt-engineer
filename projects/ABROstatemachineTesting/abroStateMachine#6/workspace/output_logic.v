module output_logic (
  input wire [1:0] encoded_state,
  output wire O
);

  assign O = (encoded_state == 2'b11) ? 1'b1 : 1'b0;

endmodule
