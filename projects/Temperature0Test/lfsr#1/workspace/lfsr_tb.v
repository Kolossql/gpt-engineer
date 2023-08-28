module LFSR_tb;

  reg clk;
  reg reset;
  wire [7:0] data;

  LFSR uut (
    .clk(clk),
    .reset(reset),
    .data(data)
  );

  initial begin
    clk = 0;
    reset = 1;
    #10 reset = 0;
  end

  always begin
    #5 clk = ~clk;
  end

endmodule
