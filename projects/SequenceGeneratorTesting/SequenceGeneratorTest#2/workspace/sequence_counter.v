module sequence_counter (
  input wire clk,
  input wire reset,
  input wire enable,
  output reg [2:0] counter
);

  always @(posedge clk or posedge reset) begin
    if (reset) begin
      counter <= 0;
    end else if (enable) begin
      counter <= counter + 1;
    end
  end

endmodule
