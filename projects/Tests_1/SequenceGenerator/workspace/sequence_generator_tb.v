module sequence_generator_tb;

  // Parameters
  parameter CLK_PERIOD = 10; // Clock period in ns

  // Inputs
  reg clk;
  reg reset;
  reg enable;

  // Outputs
  wire [7:0] data;

  // Instantiate the sequence generator module
  sequence_generator dut (
    .clk(clk),
    .reset(reset),
    .enable(enable),
    .data(data)
  );

  // Clock generator
  always #((CLK_PERIOD)/2) clk = ~clk;

  // Stimulus generator
  initial begin
    reset = 1;
    enable = 0;
    #10;
    reset = 0;
    #10;
    enable = 1;
    #100;
    enable = 0;
    #10;
    reset = 1;
    #10;
    reset = 0;
    #100;
    enable = 1;
    #1000;
    $finish;
  end

  // Monitor
  always @(posedge clk) begin
    $display("Data: %h", data);
  end

endmodule
