module testbench;

  // Parameters
  parameter CLK_PERIOD = 20; // Clock period in ns

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
  always #((CLK_PERIOD)/2) clk = ~clk;

  // Reset generation
  initial begin
    reset = 1;
    #((CLK_PERIOD)*2) reset = 0;
  end

  // Test cases
  initial begin
    // Test Case 1: Initial State
    #((CLK_PERIOD)*10);
    if (data_out === 8'b10001010)
      $display("Test Case 1 Passed");
    else
      $display("Test Case 1 Failed");

    // Test Case 2: Clock Edge
    #((CLK_PERIOD)*10);
    if (data_out !== 8'b10001010)
      $display("Test Case 2 Passed");
    else
      $display("Test Case 2 Failed");

    // Test Case 3: Reset Signal
    reset = 1;
    #((CLK_PERIOD)*10);
    if (data_out === 8'b10001010)
      $display("Test Case 3 Passed");
    else
      $display("Test Case 3 Failed");
    reset = 0;

    // Test Case 4: Multiple Clock Edges
    #((CLK_PERIOD)*20);
    if (data_out !== 8'b10001010)
      $display("Test Case 4 Passed");
    else
      $display("Test Case 4 Failed");

    // Test Case 5: Long Sequence
    #((CLK_PERIOD)*100);
    if (data_out !== 8'b10001010)
      $display("Test Case 5 Passed");
    else
      $display("Test Case 5 Failed");

    // Finish simulation
    $finish;
  end

  // Dump waveform
  initial begin
    $dumpfile("WaveOutput.vcd");
    $dumpvars(0, testbench);
  end

endmodule
