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
  TrafficLightModule dut (
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
    enable = 0;
    #20 enable = 1;
    #50 enable = 0;
    #30 enable = 1;
    #50 enable = 0;
    #30 enable = 1;
    #50 enable = 0;
  end

  // Test case generator
  initial begin
    // Test case 1: Initial state
    $display("Test case 1: Initial state");
    $display("Red: %b, Yellow: %b, Green: %b", red, yellow, green);
    if (red && !yellow && !green)
      $display("Passed");
    else
      $display("Failed");

    // Test case 2: Transition from red to green
    $display("Test case 2: Transition from red to green");
    #160;
    $display("Red: %b, Yellow: %b, Green: %b", red, yellow, green);
    if (!red && !yellow && green)
      $display("Passed");
    else
      $display("Failed");

    // Test case 3: Transition from green to yellow
    $display("Test case 3: Transition from green to yellow");
    #100;
    $display("Red: %b, Yellow: %b, Green: %b", red, yellow, green);
    if (!red && yellow && !green)
      $display("Passed");
    else
      $display("Failed");

    // Test case 4: Transition from yellow to red
    $display("Test case 4: Transition from yellow to red");
    #35;
    $display("Red: %b, Yellow: %b, Green: %b", red, yellow, green);
    if (red && !yellow && !green)
      $display("Passed");
    else
      $display("Failed");

    // Test case 5: Reset
    $display("Test case 5: Reset");
    reset = 1;
    #10 reset = 0;
    $display("Red: %b, Yellow: %b, Green: %b", red, yellow, green);
    if (red && !yellow && !green)
      $display("Passed");
    else
      $display("Failed");

    // Finish simulation
    $finish;
  end

  // Monitor
  always @(red, yellow, green)
    $display("Red: %b, Yellow: %b, Green: %b", red, yellow, green);

  // Dump waveform
  initial begin
    $dumpfile("WaveOutput.vcd");
    $dumpvars(0, testbench_traffic_light_module);
  end
endmodule
