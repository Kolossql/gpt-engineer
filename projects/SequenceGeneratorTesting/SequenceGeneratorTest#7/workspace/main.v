module main;
  
  // Inputs
  reg clk;
  reg reset;
  reg enable;

  // Outputs
  wire [7:0] data;

  // Instantiate the SequenceGenerator module
  SequenceGenerator sequenceGenerator (
    .clk(clk),
    .reset(reset),
    .enable(enable),
    .data(data)
  );

  // Clock generation
  always begin
    #5 clk = ~clk;
  end

  // Initial values
  initial begin
    clk = 0;
    reset = 1;
    enable = 0;
    #10 reset = 0;
    #10 enable = 1;
  end

endmodule
