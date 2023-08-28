module ABRO_Module (
  input wire clk,
  input wire reset,
  input wire A,
  input wire B,
  output wire O,
  output wire [1:0] state
);

  wire [1:0] next_state;
  wire output_sent;

  ABRO_StateMachine ABRO_SM (
    .clk(clk),
    .reset(reset),
    .A(A),
    .B(B),
    .next_state(next_state),
    .output_sent(output_sent)
  );

  reg [1:0] current_state;

  always @(posedge clk or posedge reset) begin
    if (reset) begin
      current_state <= 2'b00;
    end else begin
      current_state <= next_state;
    end
  end

  assign state = current_state;
  assign O = output_sent;

endmodule
