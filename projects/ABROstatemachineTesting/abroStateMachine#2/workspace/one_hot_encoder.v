module one_hot_encoder (
  input wire [3:0] state,
  output wire [3:0] encoded_state
);

  // Encoding logic
  assign encoded_state = (state == 4'b0001) ? 4'b0001 :
                         (state == 4'b0010) ? 4'b0010 :
                         (state == 4'b0011) ? 4'b0100 :
                         4'b0000;

endmodule
