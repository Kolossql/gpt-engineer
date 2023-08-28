module testbench;

  // Parameters
  parameter CLK_PERIOD = 10; // Clock period in ns

  // Signals
  reg clk;
  reg reset;
  reg enable;
  wire [7:0] data;

  // Instantiate the sequence generator module
  sequence_generator dut (
    .clk(clk),
    .reset(reset),
    .enable(enable),
    .data(data)
  );

  // Clock generation
  always begin
    clk = 0;
    #((CLK_PERIOD)/2);
    clk = 1;
    #((CLK_PERIOD)/2);
  end

  // Testbench stimulus
  initial begin
    // Initialize signals
    reset = 1;
    enable = 0;

    // Wait for a few clock cycles
    #((CLK_PERIOD)*10);

    // Release reset
    reset = 0;

    // Test case 1: Enable signal low
    enable = 0;
    #((CLK_PERIOD)*10); // Wait for a few clock cycles
    // Verify output data remains unchanged
    // TODO: Add assertion here

    // Test case 2: Active-low reset signal
    reset = 1;
    #((CLK_PERIOD)*10); // Wait for a few clock cycles
    reset = 0;
    #((CLK_PERIOD)*10); // Wait for a few clock cycles
    // Verify output data returns to initial state
    // TODO: Add assertion here

    // Test case 3: Clock signal at different frequencies
    enable = 1;
    // TODO: Generate clock signal with different frequencies
    // Verify output data changes at the rising edge of the clock signal
    // TODO: Add assertion here

    // Test case 4: Enable signal high
    enable = 1;
    #((CLK_PERIOD)*10); // Wait for a few clock cycles
    // Verify output data follows the expected sequence
    // TODO: Add assertion here

    // Test case 5: Multiple clock cycles
    enable = 1;
    #((CLK_PERIOD)*100); // Wait for multiple clock cycles
    // Verify output data generates the sequence correctly over multiple clock cycles
    // TODO: Add assertion here

    // End simulation
    $finish;
  end

endmodule
