module testbench;

  // Parameters
  parameter CLK_PERIOD = 10; // Clock period in ns

  // Inputs
  reg Clock;
  reg Reset;
  reg A;
  reg B;

  // Outputs
  wire O;
  wire [N-1:0] State;

  // Instantiate ABROStateMachine module
  ABROStateMachine dut (
    .Clock(Clock),
    .Reset(Reset),
    .A(A),
    .B(B),
    .O(O),
    .State(State)
  );

  // Clock generator
  always #((CLK_PERIOD)/2) Clock = ~Clock;

  // Stimulus generator
  initial begin
    // Test 1: Initial state
    Reset = 1'b1;
    A = 1'b0;
    B = 1'b0;
    #10;
    Reset = 1'b0;
    #20;
    if (O == 1'b0 && State == 2'b00)
      $display("Test 1 Passed");
    else
      $display("Test 1 Failed");

    // Test 2: Single pulse
    Reset = 1'b1;
    A = 1'b1;
    B = 1'b0;
    #10;
    Reset = 1'b0;
    #20;
    if (O == 1'b0 && State == 2'b01)
      $display("Test 2 Passed");
    else
      $display("Test 2 Failed");

    // Test 3: Multiple pulses
    Reset = 1'b1;
    A = 1'b1;
    B = 1'b0;
    #10;
    Reset = 1'b0;
    #20;
    A = 1'b0;
    B = 1'b1;
    #20;
    if (O == 1'b1 && State == 2'b11)
      $display("Test 3 Passed");
    else
      $display("Test 3 Failed");

    // Test 4: Reset
    Reset = 1'b1;
    A = 1'b1;
    B = 1'b1;
    #10;
    Reset = 1'b0;
    #20;
    Reset = 1'b1;
    #20;
    if (O == 1'b0 && State == 2'b00)
      $display("Test 4 Passed");
    else
      $display("Test 4 Failed");

    // Test 5: Continuous pulses
    Reset = 1'b1;
    A = 1'b1;
    B = 1'b1;
    #10;
    Reset = 1'b0;
    #20;
    A = 1'b0;
    B = 1'b0;
    #20;
    A = 1'b1;
    B = 1'b1;
    #20;
    if (O == 1'b1 && State == 2'b11)
      $display("Test 5 Passed");
    else
      $display("Test 5 Failed");

    // End simulation
    $finish;
  end

  // Dump waveform
  initial begin
    $dumpfile("WaveOutput.vcd");
    $dumpvars(0, testbench);
  end

endmodule
