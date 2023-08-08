module testbench;

  // Inputs
  reg clk;
  reg reset;
  reg A;
  reg B;

  // Outputs
  wire O;
  wire [3:0] state;

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
    // Test case 1: Initial state
    A = 0;
    B = 0;
    #20;
    if (O == 0 && state == 0)
      $display("Test case 1 Passed");
    else
      $display("Test case 1 Failed");

    // Test case 2: Single high input
    A = 1;
    B = 0;
    #20;
    if (O == 0 && state == 0)
      $display("Test case 2 Passed");
    else
      $display("Test case 2 Failed");

    // Test case 3: Both inputs high in any order
    A = 1;
    B = 1;
    #20;
    if (O == 1 && state == 1)
      $display("Test case 3 Passed");
    else
      $display("Test case 3 Failed");

    // Test case 4: Continuous high inputs
    A = 1;
    B = 1;
    #20;
    if (O == 1 && state == 1)
      $display("Test case 4 Passed");
    else
      $display("Test case 4 Failed");

    // Test case 5: Reset
    A = 1;
    B = 1;
    reset = 1;
    #10 reset = 0;
    #20;
    if (O == 0 && state == 0)
      $display("Test case 5 Passed");
    else
      $display("Test case 5 Failed");

    // End simulation
    $finish;
  end

  // Dump waveform
  initial begin
    $dumpfile("WaveOutput.vcd");
    $dumpvars(0, testbench);
  end

endmodule
