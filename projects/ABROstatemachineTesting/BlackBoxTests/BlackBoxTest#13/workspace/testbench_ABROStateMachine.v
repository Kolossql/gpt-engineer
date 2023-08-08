module testbench_ABROStateMachine;

  // Parameters
  parameter CLK_PERIOD = 10; // Clock period in ns

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
  always #((CLK_PERIOD)/2) clk = ~clk;

  // Stimulus generator
  initial begin
    // Test 1: Initial state
    $display("Test 1: Initial state");
    reset = 1'b1;
    A = 1'b0;
    B = 1'b0;
    #10;
    reset = 1'b0;
    A = 1'b1;
    #10;
    A = 1'b0;
    #10;
    B = 1'b1;
    #10;
    B = 1'b0;
    #10;
    A = 1'b1;
    #10;
    A = 1'b0;
    #10;
    B = 1'b1;
    #10;
    B = 1'b0;
    #10;

    // Test 2: Random state
    $display("Test 2: Random state");
    reset = 1'b1;
    A = 1'b0;
    B = 1'b0;
    #10;
    reset = 1'b0;
    repeat(20) begin
      #10;
      A = $random;
      #10;
      B = $random;
    end

    // Test 3: Reset
    $display("Test 3: Reset");
    reset = 1'b1;
    A = 1'b0;
    B = 1'b0;
    #10;
    reset = 1'b0;
    #10;
    reset = 1'b1;
    #10;
    reset = 1'b0;
    #10;
    A = 1'b1;
    #10;
    B = 1'b1;
    #10;

    // Test 4: Sequential transitions
    $display("Test 4: Sequential transitions");
    reset = 1'b1;
    A = 1'b0;
    B = 1'b0;
    #10;
    reset = 1'b0;
    #10;
    A = 1'b1;
    #10;
    B = 1'b1;
    #10;
    A = 1'b0;
    #10;
    B = 1'b0;
    #10;
    A = 1'b1;
    #10;
    B = 1'b1;
    #10;

    // Test 5: Output verification
    $display("Test 5: Output verification");
    reset = 1'b1;
    A = 1'b0;
    B = 1'b0;
    #10;
    reset = 1'b0;
    #10;
    A = 1'b1;
    #10;
    B = 1'b1;
    #10;
    A = 1'b0;
    #10;
    B = 1'b0;
    #10;
    A = 1'b1;
    #10;
    B = 1'b1;
    #10;

    // End simulation
    $display("Simulation completed");
    $finish;
  end

  // Monitor
  always @(posedge clk) begin
    $display("Current state: %b", state);
    $display("Output O: %b", O);
  end

  // Dump waveform
  initial begin
    $dumpfile("WaveOutput.vcd");
    $dumpvars(0, testbench_ABROStateMachine);
  end

endmodule
