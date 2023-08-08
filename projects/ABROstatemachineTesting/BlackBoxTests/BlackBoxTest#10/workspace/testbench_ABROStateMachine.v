module testbench_ABROStateMachine;

  // Inputs
  reg clk;
  reg reset;
  reg A;
  reg B;

  // Outputs
  wire O;
  wire [3:0] state;

  // Instantiate the ABROStateMachine module
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

  // Stimulus generator
  initial begin
    // Test 1: Initial state
    $display("Test 1: Initial state");
    reset = 1'b0;
    A = 1'b0;
    B = 1'b0;
    #10;
    if (O === 1'b0 && state === 4'b0000)
      $display("Passed");
    else
      $display("Failed");

    // Test 2: Single occurrence of A and B
    $display("Test 2: Single occurrence of A and B");
    reset = 1'b0;
    A = 1'b1;
    B = 1'b0;
    #10;
    if (O === 1'b0 && state === 4'b0000)
      $display("Passed");
    else
      $display("Failed");

    // Test 3: Multiple occurrences of A and B
    $display("Test 3: Multiple occurrences of A and B");
    reset = 1'b0;
    A = 1'b1;
    B = 1'b1;
    #10;
    if (O === 1'b1 && state === 4'b0001)
      $display("Passed");
    else
      $display("Failed");

    // Test 4: A and B in different order
    $display("Test 4: A and B in different order");
    reset = 1'b0;
    A = 1'b0;
    B = 1'b1;
    #10;
    if (O === 1'b1 && state === 4'b0010)
      $display("Passed");
    else
      $display("Failed");

    // Test 5: Reset
    $display("Test 5: Reset");
    reset = 1'b1;
    A = 1'b1;
    B = 1'b1;
    #10;
    if (O === 1'b0 && state === 4'b0000)
      $display("Passed");
    else
      $display("Failed");

    $finish;
  end

  // Monitor
  always @(posedge clk) begin
    $display("O = %b, state = %b", O, state);
  end

  // Dump waveform
  initial begin
    $dumpfile("WaveOutput.vcd");
    $dumpvars(0, testbench_ABROStateMachine);
  end

endmodule
