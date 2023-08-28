module SequenceGenerator (
  input wire clk,
  input wire reset,
  input wire enable,
  output wire [7:0] data
);
  reg [7:0] sequence [7:0] = {8'hAF, 8'hBC, 8'hE2, 8'h78, 8'hFF, 8'hE2, 8'h0B, 8'h8D};
  reg [2:0] state;
  
  always @(posedge clk or posedge reset) begin
    if (reset) begin
      state <= 0;
    end else if (enable) begin
      state <= state + 1;
    end
  end
  
  assign data = sequence[state];
endmodule
