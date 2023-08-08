module testbench_ABROStateMachine;
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
  
  // Stimulus generator
  initial begin
    // Initialize inputs
    reset = 1;
    A = 0;
    B = 0;
    
    // Test 1: Initial state
    #10;
    reset = 0;
    #20;
    if (O == 0 && state == 2'b00)
      $display("Test 1 Passed");
    else
      $display("Test 1 Failed");
    
    // Test 2: Single input
    #10;
    A = 1;
    #20;
    if (O == 0 && state == 2'b00)
      $display("Test 2 Passed");
    else
      $display("Test 2 Failed");
    
    // Test 3: Both inputs in order
    #10;
    A = 1;
    B = 1;
    #20;
    if (O == 1 && state == 2'b11)
      $display("Test 3 Passed");
    else
      $display("Test 3 Failed");
    
    // Test 4: Both inputs in reverse order
    #10;
    A = 0;
    B = 0;
    #20;
    A = 1;
    #20;
    B = 1;
    #20;
    if (O == 1 && state == 2'b11)
      $display("Test 4 Passed");
    else
      $display("Test 4 Failed");
    
    // Test 5: Simultaneous inputs
    #10;
    A = 1;
    B = 1;
    #20;
    if (O == 1 && state == 2'b11)
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
    $dumpvars(0, testbench_ABROStateMachine);
  end
endmodule
