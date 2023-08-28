module ResetLogic (
  input wire clk,
  input wire reset,
  input wire A,
  input wire B,
  output wire reset_A,
  output wire reset_B
);

  reg reset_a;
  reg reset_b;

  always @(posedge clk) begin
    if (!reset) begin
      reset_a <= 1'b1;
      reset_b <= 1'b1;
    end else begin
      if (A) begin
        reset_a <= 1'b0;
      end
      if (B) begin
        reset_b <= 1'b0;
      end
    end
  end

  assign reset_A = reset_a;
  assign reset_B = reset_b;

endmodule
