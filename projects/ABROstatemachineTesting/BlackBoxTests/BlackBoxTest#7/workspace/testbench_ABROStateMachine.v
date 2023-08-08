module testbench_ABROStateMachine;

  // Inputs
  reg clk;
  reg reset;
  reg A;
  reg B;

  // Outputs
  wire O;
  wire [2:0] state;

  // Instantiate ABROStateMachine module
  ABROStateMachine dut (
    .clk(clk),
    .reset(reset),
    .A(A),
    .B(B),
    .O(O),
    .state(state)
  );

  // Clock generator
  always #5 clk = ~clk;

  // Reset generator
  initial begin
    reset = 1;
    #10 reset = 0;
  end

  // Stimulus generator
  initial begin
    // Test 1: Initial state (both A and B low)
    #20;
    A = 0;
    B = 0;
    $display("Test 1: Initial state");
    if (O == 0 && state == 0)
      $display("Passed");
    else
      $display("Failed");

    // Test 2: Single high input (A high)
    #20;
    A = 1;
    B = 0;
    $display("Test 2: Single high input (A high)");
    if (O == 0 && state == 0)
      $display("Passed");
    else
      $display("Failed");

    // Test 3: Single high input (B high)
    #20;
    A = 0;
    B = 1;
    $display("Test 3: Single high input (B high)");
    if (O == 0 && state == 0)
      $display("Passed");
    else
      $display("Failed");

    // Test 4: Both inputs high in any order
    #20;
    A = 1;
    B = 0;
    #10;
    A = 0;
    B = 1;
    $display("Test 4: Both inputs high in any order");
    if (O == 1 && state == 3)
      $display("Passed");
    else
      $display("Failed");

    // Test 5: Both inputs high simultaneously
    #20;
    A = 1;
    B = 1;
    $display("Test 5: Both inputs high simultaneously");
    if (O == 1 && state == 7)
      $display("Passed");
    else
      $display("Failed");

    // Test 6: Continuous high inputs
    #20;
    A = 1;
    B = 1;
    #10;
    A = 1;
    B = 1;
    $display("Test 6: Continuous high inputs");
    if (O == 1 && state == 7)
      $display("Passed");
    else
      $display("Failed");

    // End simulation
    #10 $finish;
  end

  // Dump waveform
  initial begin
    $dumpfile("WaveOutput.vcd");
    $dumpvars(0, testbench_ABROStateMachine);
  end

endmodule
