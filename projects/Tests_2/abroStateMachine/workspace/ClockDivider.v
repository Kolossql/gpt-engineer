module ClockDivider (
  input wire clk,
  output wire clk_div
);

  reg [15:0] counter;

  always @(posedge clk) begin
    if (counter == 16'd0) begin
      counter <= 16'd9999; // Divide clock frequency by 10000
      clk_div <= 1'b1;
    end else begin
      counter <= counter - 1;
      clk_div <= 1'b0;
    end
  end

endmodule
