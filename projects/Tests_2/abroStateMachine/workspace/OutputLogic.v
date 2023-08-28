module OutputLogic (
  input wire [3:0] state,
  output wire O
);

  assign O = (state == 4'b1000) ? 1'b1 : 1'b0;

endmodule
