module Main;

  // Inputs
  reg clk;
  reg reset;
  reg enable;

  // Outputs
  wire [7:0] data;

  // Instantiate the SequenceGenerator module
  SequenceGenerator sequence_gen (
    .clk(clk),
    .reset(reset),
    .enable(enable),
    .data(data)
  );

  // Clock generation
  always begin
    #5 clk = ~clk;
  end

  // Initial state and stimulus generation
  initial begin
    clk = 0;
    reset = 1;
    enable = 0;
    #10 reset = 0;
    #20 enable = 1;
    #100 enable = 0;
    #100 enable = 1;
    #100 $finish;
  end

endmodule
