module testbench_abro_state_machine;

  // Parameters
  parameter CLK_PERIOD = 10; // Clock period in ns

  // Inputs
  reg clk;
  reg reset;
  reg a;
  reg b;

  // Outputs
  wire o;
  wire [3:0] state;

  // Instantiate the ABROStateMachine module
  ABROStateMachine dut (
    .clk(clk),
    .reset(reset),
    .a(a),
    .b(b),
    .o(o),
    .state(state)
  );

  // Clock Generator
  always #((CLK_PERIOD)/2) clk = ~clk;

  // Reset Generator
  initial begin
    reset = 1;
    #((CLK_PERIOD)*2) reset = 0;
    #((CLK_PERIOD)*2) reset = 1;
  end

  // Stimulus Generator
  initial begin
    // Test 1: Initial state
    a = 0;
    b = 0;
    #((CLK_PERIOD)*10);
    if (o == 0 && state == 0)
      $display("Test 1 Passed");
    else
      $display("Test 1 Failed");

    // Test 2: Transition to state 1
    a = 1;
    b = 0;
    #((CLK_PERIOD)*10);
    if (o == 0 && state == 1)
      $display("Test 2 Passed");
    else
      $display("Test 2 Failed");

    // Test 3: Transition to state 2
    a = 0;
    b = 1;
    #((CLK_PERIOD)*10);
    if (o == 0 && state == 2)
      $display("Test 3 Passed");
    else
      $display("Test 3 Failed");

    // Test 4: Transition to state 3
    a = 1;
    b = 1;
    #((CLK_PERIOD)*10);
    if (o == 1 && state == 3)
      $display("Test 4 Passed");
    else
      $display("Test 4 Failed");

    // Test 5: Output reset
    a = 0;
    b = 0;
    #((CLK_PERIOD)*10);
    if (o == 0 && state == 0)
      $display("Test 5 Passed");
    else
      $display("Test 5 Failed");

    // End simulation
    $finish;
  end

  // Monitor
  always @(posedge clk) begin
    $display("Output: %b, State: %b", o, state);
  end

  // Dump waveform
  initial begin
    $dumpfile("WaveOutput.vcd");
    $dumpvars(0, testbench_abro_state_machine);
  end

endmodule
