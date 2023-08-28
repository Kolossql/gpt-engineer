module ABRO_OutputEncoder (
  input wire [1:0] State,
  output wire [3:0] EncodedState
);

  assign EncodedState = {State, 2'b00};

endmodule
