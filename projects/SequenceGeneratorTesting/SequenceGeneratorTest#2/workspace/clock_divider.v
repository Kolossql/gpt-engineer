module clock_divider (
  input wire clk,
  input wire reset,
  output wire slow_clk
);

  reg [15:0] count;

  always @(posedge clk or posedge reset) begin
    if (reset) begin
      count <= 0;
      slow_clk <= 0;
    end else begin
      count <= count + 1;
      if (count == 50000) begin
        count <= 0;
        slow_clk <= ~slow_clk;
      end
    end
  end

endmodule
