module lfsr_tb;

  reg clk;
  reg reset;
  wire [7:0] data;

  lfsr dut (
    .clk(clk),
    .reset(reset),
    .data(data)
  );

  initial begin
    clk = 0;
    reset = 1;
    #10 reset = 0;
  end

  always #5 clk = ~clk;

endmodule
