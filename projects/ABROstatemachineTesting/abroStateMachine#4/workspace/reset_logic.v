module reset_logic (
  input wire clk,
  input wire reset,
  input wire A,
  input wire B,
  output wire reset_ab
);

  reg reset_ab_reg;

  always @(posedge clk) begin
    if (!reset) begin
      reset_ab_reg <= 1;
    end else begin
      if (A && B) begin
        reset_ab_reg <= 0;
      end
    end
  end

  assign reset_ab = reset_ab_reg;

endmodule
