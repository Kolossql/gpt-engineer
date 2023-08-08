module ABROStateMachine_tb;

  // Inputs
  reg clk;
  reg reset;
  reg A;
  reg B;

  // Outputs
  wire O;
  wire [1:0] State;

  // Instantiate the ABROStateMachine module
  ABROStateMachine dut (
    .clk(clk),
    .reset(reset),
    .A(A),
    .B(B),
    .O(O),
    .State(State)
  );

  // Clock generator
  always #5 clk = ~clk;

  // Stimulus generator
  initial begin
    // Initialize inputs
    reset = 1'b0;
    A = 1'b0;
    B = 1'b0;

    // Test case 1: Initial state
    #10;
    if (O == 1'b0 && State == 2'b00)
      $display("Test case 1 Passed");
    else
      $display("Test case 1 Failed");

    // Test case 2: Single input high
    A = 1'b1;
    #10;
    if (O == 1'b0 && State == 2'b00)
      $display("Test case 2 Passed");
    else
      $display("Test case 2 Failed");

    // Test case 3: Both inputs high in any order
    A = 1'b0;
    B = 1'b1;
    #10;
    if (O == 1'b1 && State == 2'b11)
      $display("Test case 3 Passed");
    else
      $display("Test case 3 Failed");

    // Test case 4: Both inputs high simultaneously
    A = 1'b1;
    #10;
    if (O == 1'b1 && State == 2'b11)
      $display("Test case 4 Passed");
    else
      $display("Test case 4 Failed");

    // Test case 5: Reset behavior
    reset = 1'b1;
    #10;
    if (O == 1'b0 && State == 2'b00)
      $display("Test case 5 Passed");
    else
      $display("Test case 5 Failed");

    // End simulation
    $finish;
  end

  // Monitor
  always @(posedge clk) begin
    $display("O = %b, State = %b", O, State);
  end

  // Dump waveform
  initial begin
    $dumpfile("WaveOutput.vcd");
    $dumpvars(0, ABROStateMachine_tb);
  end

endmodule
