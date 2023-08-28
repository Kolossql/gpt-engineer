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
    .rst_n(reset),
    .enable(enable),
    .data(data)
  );

  // Clock generation
  always #((CLK_PERIOD)/2) clk = ~clk;

  // Test stimuli generation
  initial begin
    // Initialize inputs
    reset = 1;
    enable = 0;

    // Wait for a few clock cycles
    #((CLK_PERIOD)*10);

    // Test case 1: Initial state
    $display("Test Case 1: Initial state");
    reset = 0;
    #((CLK_PERIOD)*10);
    if (data !== 8'hAF) $display("Test Case 1 failed!");

    // Test case 2: Sequence generation
    $display("Test Case 2: Sequence generation");
    enable = 1;
    #((CLK_PERIOD)*10);
    if (data !== 8'hAF) $display("Test Case 2 failed!");
    #((CLK_PERIOD)*10);
    if (data !== 8'hBC) $display("Test Case 2 failed!");
    #((CLK_PERIOD)*10);
    if (data !== 8'hE2) $display("Test Case 2 failed!");
    #((CLK_PERIOD)*10);
    if (data !== 8'h78) $display("Test Case 2 failed!");
    #((CLK_PERIOD)*10);
    if (data !== 8'hFF) $display("Test Case 2 failed!");
    #((CLK_PERIOD)*10);
    if (data !== 8'hE2) $display("Test Case 2 failed!");
    #((CLK_PERIOD)*10);
    if (data !== 8'h0B) $display("Test Case 2 failed!");
    #((CLK_PERIOD)*10);
    if (data !== 8'h8D) $display("Test Case 2 failed!");

    // Test case 3: Enable signal low
    $display("Test Case 3: Enable signal low");
    enable = 0;
    #((CLK_PERIOD)*10);
    if (data !== 8'h8D) $display("Test Case 3 failed!");

    // Test case 4: Active-low reset
    $display("Test Case 4: Active-low reset");
    reset = 1;
    #((CLK_PERIOD)*10);
    if (data !== 8'hAF) $display("Test Case 4 failed!");
    reset = 0;
    #((CLK_PERIOD)*10);
    if (data !== 8'hAF) $display("Test Case 4 failed!");

    // Test case 5: Continuous sequence generation
    $display("Test Case 5: Continuous sequence generation");
    enable = 1;
    #((CLK_PERIOD)*100);
    if (data !== 8'hAF) $display("Test Case 5 failed!");
    #((CLK_PERIOD)*100);
    if (data !== 8'hBC) $display("Test Case 5 failed!");
    #((CLK_PERIOD)*100);
    if (data !== 8'hE2) $display("Test Case 5 failed!");
    #((CLK_PERIOD)*100);
    if (data !== 8'h78) $display("Test Case 5 failed!");
    #((CLK_PERIOD)*100);
    if (data !== 8'hFF) $display("Test Case 5 failed!");
    #((CLK_PERIOD)*100);
    if (data !== 8'hE2) $display("Test Case 5 failed!");
    #((CLK_PERIOD)*100);
    if (data !== 8'h0B) $display("Test Case 5 failed!");
    #((CLK_PERIOD)*100);
    if (data !== 8'h8D) $display("Test Case 5 failed!");

    $finish;
  end

endmodule
