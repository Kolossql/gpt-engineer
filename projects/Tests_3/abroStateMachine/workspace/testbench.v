module testbench;
  
  // Parameters
  parameter CLK_PERIOD = 10; // Clock period in ns
  
  // Signals
  reg clk;
  reg reset;
  reg A;
  reg B;
  wire O;
  wire [3:0] state;
  
  // Instantiate ABRO state machine module
  ABRO uut (
    .clk(clk),
    .reset(reset),
    .A(A),
    .B(B),
    .O(O),
    .state(state)
  );
  
  // Clock generator
  always #((CLK_PERIOD)/2) clk = ~clk;
  
  // Reset generator
  initial begin
    reset = 1;
    #((CLK_PERIOD)*2) reset = 0;
  end
  
  // Test cases
  initial begin
    // Test case 1: A and B not entered in correct order
    A = 1;
    B = 1;
    #((CLK_PERIOD)*10);
    if (O == 0)
      $display("Test case 1: Passed");
    else
      $display("Test case 1: Failed");
    
    // Test case 2: A entered before B
    A = 1;
    B = 0;
    #((CLK_PERIOD)*10);
    if (O == 0)
      $display("Test case 2: Passed");
    else
      $display("Test case 2: Failed");
    
    // Test case 3: B entered before A
    A = 0;
    B = 1;
    #((CLK_PERIOD)*10);
    if (O == 0)
      $display("Test case 3: Passed");
    else
      $display("Test case 3: Failed");
    
    // Test case 4: A and B entered simultaneously
    A = 1;
    B = 1;
    #((CLK_PERIOD)*10);
    if (O == 1)
      $display("Test case 4: Passed");
    else
      $display("Test case 4: Failed");
    
    // Test case 5: A and B entered multiple times in different orders
    A = 1;
    B = 0;
    #((CLK_PERIOD)*10);
    if (O == 0)
      $display("Test case 5: Passed");
    else
      $display("Test case 5: Failed");
    
    A = 0;
    B = 1;
    #((CLK_PERIOD)*10);
    if (O == 0)
      $display("Test case 5: Passed");
    else
      $display("Test case 5: Failed");
    
    A = 1;
    B = 1;
    #((CLK_PERIOD)*10);
    if (O == 1)
      $display("Test case 5: Passed");
    else
      $display("Test case 5: Failed");
  end
  
  // Dump waveform for visualization
  initial begin
    $dumpfile("WaveOutput.vcd");
    $dumpvars(0, testbench);
  end
  
endmodule
