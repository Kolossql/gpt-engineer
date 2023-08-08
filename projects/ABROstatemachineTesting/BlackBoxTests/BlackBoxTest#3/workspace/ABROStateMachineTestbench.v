module ABROStateMachineTestbench;

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

  // Reset generator
  initial begin
    reset = 1;
    #10 reset = 0;
  end

  // Stimulus generator
  initial begin
    // Test case 1: A and B are both low after reset
    #20 A = 0;
    #20 B = 0;
    #20 $display("Test case 1:");
    if (O == 0 && State == 0)
      $display("Passed");
    else
      $display("Failed");

    // Test case 2: A is high before B after reset
    #20 A = 1;
    #20 B = 0;
    #20 $display("Test case 2:");
    if (O == 0 && State == 0)
      $display("Passed");
    else
      $display("Failed");

    // Test case 3: B is high before A after reset
    #20 A = 0;
    #20 B = 1;
    #20 $display("Test case 3:");
    if (O == 0 && State == 0)
      $display("Passed");
    else
      $display("Failed");

    // Test case 4: A and B are both high after reset
    #20 A = 1;
    #20 B = 1;
    #20 $display("Test case 4:");
    if (O == 1 && State == 1)
      $display("Passed");
    else
      $display("Failed");

    // Test case 5: A or B transitions from high to low after meeting the requirement
    #20 A = 1;
    #20 B = 1;
    #20 A = 0;
    #20 $display("Test case 5:");
    if (O == 1 && State == 1)
      $display("Passed");
    else
      $display("Failed");

    // End simulation
    #10 $finish;
  end

  // Output checker
  // always @(posedge clk) begin
  //   if (O == 1 && State == 0)
  //     $display("Output: Passed");
  //   else
  //     $display("Output: Failed");
  // end

  // Dump waveform
  initial begin
    $dumpfile("WaveOutput.vcd");
    $dumpvars(0, ABROStateMachineTestbench);
  end

endmodule
