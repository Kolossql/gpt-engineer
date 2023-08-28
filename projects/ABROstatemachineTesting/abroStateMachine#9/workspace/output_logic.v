module OutputLogic (
  input wire clk,
  input wire A,
  input wire B,
  output wire O
);

  reg output_pulse;

  always @(posedge clk) begin
    if (A && B) begin
      output_pulse <= 1'b1;
    end else begin
      output_pulse <= 1'b0;
    end
  end

  assign O = output_pulse;

endmodule
