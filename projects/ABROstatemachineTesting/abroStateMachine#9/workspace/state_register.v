module StateRegister (
  input wire clk,
  input wire reset,
  input wire [1:0] next_state,
  output wire [1:0] state
);

  reg [1:0] current_state;

  always @(posedge clk or negedge reset) begin
    if (!reset) begin
      current_state <= 2'b00; // Reset to initial state
    end else begin
      current_state <= next_state;
    end
  end

  assign state = current_state;

endmodule
