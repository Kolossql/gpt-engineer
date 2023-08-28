module state_register (
  input wire clk,
  input wire reset,
  input wire valid_input,
  output wire [1:0] encoded_state
);

  reg [1:0] state;

  always @(posedge clk or posedge reset) begin
    if (reset) begin
      state <= 2'b00; // Assuming initial state is S0
    end else if (valid_input) begin
      case (state)
        2'b00: state <= 2'b01; // Transition from S0 to S1
        2'b01: state <= 2'b10; // Transition from S1 to S2
        2'b10: state <= 2'b11; // Transition from S2 to S3
        2'b11: state <= 2'b11; // Stay in S3
      endcase
    end
  end

  assign encoded_state = state;

endmodule
