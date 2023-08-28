module verification_output (
  input wire [1:0] state
);

  reg [1:0] current_state;

  always @(state) begin
    current_state <= state;
  end

  initial begin
    $display("Current State: %b", current_state);
  end

endmodule
