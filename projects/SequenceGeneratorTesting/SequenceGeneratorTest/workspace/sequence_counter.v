module sequence_counter (
  input wire clk,
  input wire reset_n,
  input wire enable,
  output reg [2:0] count
);

  always @(posedge clk or negedge reset_n) begin
    if (!reset_n) begin
      count <= 3'b000; // Initialize count to 0
    end else if (enable) begin
      count <= count + 1; // Increment count on rising edge of clk when enable is high
    end
  end

endmodule
