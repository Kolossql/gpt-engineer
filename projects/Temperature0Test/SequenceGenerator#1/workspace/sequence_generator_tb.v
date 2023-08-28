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
    reset = 1; // Activate active-low reset
    enable = 0; // Set enable signal low

    // Test case 1: Initial state
    #10;
    $display("Test Case 1: Initial state");
    $display("Expected Output: 0xAF");
    $display("Actual Output: %h", data);
    if (data === 8'hAF)
      $display("Test Case 1 Passed");
    else
      $display("Test Case 1 Failed");

    // Test case 2: Clock edge triggering
    #10;
    $display("Test Case 2: Clock edge triggering");
    $display("Expected Output: 0xBC");
    $display("Actual Output: %h", data);
    if (data === 8'hBC)
      $display("Test Case 2 Passed");
    else
      $display("Test Case 2 Failed");

    // Test case 3: Active-low reset
    #10;
    reset = 0; // Deactivate active-low reset
    $display("Test Case 3: Active-low reset");
    $display("Expected Output: 0xAF");
    $display("Actual Output: %h", data);
    if (data === 8'hAF)
      $display("Test Case 3 Passed");
    else
      $display("Test Case 3 Failed");

    // Test case 4: Enable signal
    #10;
    enable = 1; // Set enable signal high
    $display("Test Case 4: Enable signal");
    $display("Expected Output: 0xE2");
    $display("Actual Output: %h", data);
    if (data === 8'hE2)
      $display("Test Case 4 Passed");
    else
      $display("Test Case 4 Failed");

    // Test case 5: Sequence repetition
    #10;
    $display("Test Case 5: Sequence repetition");
    $display("Expected Output: 0xAF");
    $display("Actual Output: %h", data);
    if (data === 8'hAF)
      $display("Test Case 5 Passed");
    else
      $display("Test Case 5 Failed");

    // End simulation
    #10;
    $finish;
  end

endmodule
