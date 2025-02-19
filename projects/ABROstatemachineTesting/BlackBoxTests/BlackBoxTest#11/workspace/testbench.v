module testbench;

  // Parameters
  parameter CLK_PERIOD = 10; // Clock period in ns

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
  always #((CLK_PERIOD)/2) clk = ~clk;

  // Stimulus generator
  initial begin
    // Test 1: Initial state (both A and B low)
    reset = 1;
    A = 0;
    B = 0;
    #10;
    reset = 0;
    #20;
    if (O == 0 && state == 4'b0000)
      $display("Test 1 Passed");
    else
      $display("Test 1 Failed");

    // Test 2: Single high input
    reset = 1;
    A = 1;
    B = 0;
    #10;
    reset = 0;
    #20;
    if (O == 0 && state == 4'b0000)
      $display("Test 2 Passed");
    else
      $display("Test 2 Failed");

    // Test 3: Both inputs high in any order
    reset = 1;
    A = 1;
    B = 0;
    #10;
    A = 0;
    B = 1;
    #10;
    reset = 0;
    #20;
    if (O == 1 && state == 4'b0001)
      $display("Test 3 Passed");
    else
      $display("Test 3 Failed");

    // Test 4: Both inputs high in order
    reset = 1;
    A = 0;
    B = 0;
    #10;
    A = 1;
    #10;
    B = 1;
    #10;
    reset = 0;
    #20;
    if (O == 1 && state == 4'b0001)
      $display("Test 4 Passed");
    else
      $display("Test 4 Failed");

    // Test 5: Reset
    reset = 1;
    A = 1;
    B = 1;
    #10;
    reset = 0;
    #20;
    if (O == 0 && state == 4'b0000)
      $display("Test 5 Passed");
    else
      $display("Test 5 Failed");

    // End simulation
    $finish;
  end

  // Monitor
  always @(posedge clk) begin
    $display("O = %b, State = %b", O, state);
  end

  // Dump waveform
  initial begin
    $dumpfile("WaveOutput.vcd");
    $dumpvars(0, testbench);
  end

endmodule
