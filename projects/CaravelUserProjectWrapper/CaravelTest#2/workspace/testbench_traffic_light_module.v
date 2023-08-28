module testbench_traffic_light_module;
  // Inputs
  reg clk;
  reg reset;
  reg enable;
  
  // Outputs
  wire red;
  wire yellow;
  wire green;
  
  // Instantiate the module to be tested
  traffic_light_module dut (
    .clk(clk),
    .reset(reset),
    .enable(enable),
    .red(red),
    .yellow(yellow),
    .green(green)
  );
  
  // Clock generator
  always #5 clk = ~clk;
  
  // Reset generator
  initial begin
    reset = 1;
    #10 reset = 0;
  end
  
  // Enable generator
  initial begin
    enable = 1;
    #100 enable = 0;
    #100 enable = 1;
    #100 enable = 0;
    #100 enable = 1;
    #100 enable = 0;
  end
  
  // Monitor
  always @(posedge clk) begin
    $display("Red: %b, Yellow: %b, Green: %b", red, yellow, green);
  end
  
  // Test cases
  initial begin
    // Test case 1: Initial state
    #160;
    $display("Test case 1 - Initial state:");
    if (red && !yellow && !green)
      $display("Passed");
    else
      $display("Failed");
    
    // Test case 2: Transition from red to green
    #160;
    $display("Test case 2 - Transition from red to green:");
    if (!red && !yellow && green)
      $display("Passed");
    else
      $display("Failed");
    
    // Test case 3: Transition from green to yellow
    #120;
    $display("Test case 3 - Transition from green to yellow:");
    if (!red && yellow && !green)
      $display("Passed");
    else
      $display("Failed");
    
    // Test case 4: Transition from yellow to red
    #70;
    $display("Test case 4 - Transition from yellow to red:");
    if (red && !yellow && !green)
      $display("Passed");
    else
      $display("Failed");
    
    // Test case 5: Reset
    #160;
    $display("Test case 5 - Reset:");
    reset = 1;
    #10 reset = 0;
    if (red && !yellow && !green)
      $display("Passed");
    else
      $display("Failed");
    
    // Finish simulation
    $finish;
  end
  
  // Dump waveform
  initial begin
    $dumpfile("WaveOutput.vcd");
    $dumpvars(0, testbench_traffic_light_module);
  end
endmodule
