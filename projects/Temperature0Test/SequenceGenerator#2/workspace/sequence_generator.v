module SequenceGenerator (
  input wire clk,
  input wire rst_n,
  input wire enable,
  output reg [7:0] data
);

  reg [7:0] sequence [7:0] = {8'hAF, 8'hBC, 8'hE2, 8'h78, 8'hFF, 8'hE2, 8'h0B, 8'h8D};
  reg [2:0] state = 0;

  always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
      state <= 0;
      data <= sequence[0];
    end else if (enable) begin
      state <= state + 1;
      data <= sequence[state];
    end
  end

endmodule
