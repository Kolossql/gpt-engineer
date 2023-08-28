module testbench;

  // Parameters
  parameter CLK_PERIOD = 10; // Clock period in ns

  // Signals
  reg clk;
  reg reset;
  wire [7:0] data_out;

  // Instantiate LFSR module
  lfsr lfsr (
    .clk(clk),
    .reset(reset),
    .data(data_out)
  );

  // Clock generation
  always  #((CLK_PERIOD)/2) clk = ~clk;
  

  // Reset generation
  initial begin
    reset = 1;
    #10;
    reset = 0;
  end

  // Test cases
  initial begin
    // Case 1: Initial state
    #10;
    $display("Case 1: Initial state");
    $display("Expected output: 10001010");
    $display("Actual output: %b", data_out);
    if (data_out === 8'b10001010)
      $display("Test Passed");
    else
      $display("Test Failed");

    // Case 2: Clock edge
    #10;
    $display("Case 2: Clock edge");
    $display("Expected output: 01000101");
    $display("Actual output: %b", data_out);
    if (data_out === 8'b01000101)
      $display("Test Passed");
    else
      $display("Test Failed");

    // Case 3: Active-low reset
    #10;
    $display("Case 3: Active-low reset");
    reset = 1;
    #10;
    reset = 0;
    $display("Expected output: 10001010");
    $display("Actual output: %b", data_out);
    if (data_out === 8'b10001010)
      $display("Test Passed");
    else
      $display("Test Failed");

    // Case 4: Continuous generation
    #10;
    $display("Case 4: Continuous generation");
    $display("Expected output: 01000101");
    $display("Actual output: %b", data_out);
    if (data_out === 8'b01000101)
      $display("Test Passed");
    else
      $display("Test Failed");

    // Case 5: Output verification
    #10;
    $display("Case 5: Output verification");
    $display("Expected output: 01000101");
    $display("Actual output: %b", data_out);
    if (data_out === 8'b01000101)
      $display("Test Passed");
    else
      $display("Test Failed");

    // End simulation
    #10;
    $finish;
  end

endmodule
