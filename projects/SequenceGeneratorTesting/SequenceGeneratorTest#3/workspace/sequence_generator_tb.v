module sequence_generator_tb;

  // Parameters
  parameter CLK_PERIOD = 10; // Clock period in ns

  // Inputs
  reg clk;
  reg rst;
  reg enable;

  // Outputs
  wire [7:0] data;

  // Instantiate the sequence generator module
  sequence_generator dut (
    .clk(clk),
    .rst(rst),
    .enable(enable),
    .data(data)
  );

  // Clock generator
  always #((CLK_PERIOD)/2) clk = ~clk;

  // Reset generator
  initial begin
    rst = 1;
    #((CLK_PERIOD)*2) rst = 0;
    #((CLK_PERIOD)*10) rst = 1;
  end

  // Enable generator
  initial begin
    enable = 0;
    #((CLK_PERIOD)*10) enable = 1;
    #((CLK_PERIOD)*20) enable = 0;
    #((CLK_PERIOD)*30) enable = 1;
  end

  // Monitor
  always @(posedge clk) begin
    $display("Data: %h", data);
  end

  // Test cases
  initial begin
    #((CLK_PERIOD)*40) $finish;
  end

endmodule
