module testbench;
  // Inputs
  reg clk;
  reg reset;
  reg A;
  reg B;

  // Outputs
  wire O;
  wire [1:0] state;

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
    // Test 1: Initial state
    A = 0;
    B = 0;
    #20 A = 1;
    #20 B = 1;
    #20 A = 0;
    #20 B = 0;

    // Test 2: Random state
    // Add more random stimulus here

    // Test 3: Reset
    #20 reset = 1;
    #10 reset = 0;

    // Test 4: Multiple transitions
    // Add more stimulus for multiple transitions here

    // Test 5: Output verification
    // Add stimulus to verify the output here

    // End simulation
    #10 $finish;
  end

  // Output checker
  always @(posedge clk) begin
    // Test 1: Initial state
    if (O === 1'b1 && state === 2'b00)
      $display("Test 1 Passed");
    else
      $display("Test 1 Failed");

    // Test 2: Random state
    // Add output verification for random state here

    // Test 3: Reset
    // Add output verification for reset here

    // Test 4: Multiple transitions
    // Add output verification for multiple transitions here

    // Test 5: Output verification
    // Add output verification for output here
  end

  // Dump waveform for GTKWave
  initial begin
    $dumpfile("WaveOutput.vcd");
    $dumpvars(0, testbench);
  end
endmodule
