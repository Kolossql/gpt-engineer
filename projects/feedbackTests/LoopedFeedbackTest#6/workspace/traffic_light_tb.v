module traffic_light_tb;

  // Inputs
  reg clk;
  reg reset_n;
  reg enable;

  // Outputs
  wire red;
  wire yellow;
  wire green;

  // Instantiate the module under test
  TrafficLightModule dut (
    .clk(clk),
    .reset_n(reset_n),
    .enable(enable),
    .red(red),
    .yellow(yellow),
    .green(green)
  );

  // Clock driver
  always #5 clk = ~clk;

  // Reset driver
  initial begin
    reset_n = 0;
    #10;
    reset_n = 1;
  end

  // Enable driver
  initial begin
    enable = 0;
    #20;
    enable = 1;
    #32;
    enable = 0;
    #20;
    enable = 1;
    #7;
    enable = 0;
    #10;
    enable = 1;
  end

  // Monitor
  always @(red, yellow, green)
    $display("Red: %b, Yellow: %b, Green: %b", red, yellow, green);

  // Test cases
  initial begin
    // Test case 1: Initial state
    #160;
    if (red && !yellow && !green)
      $display("Test case 1 Passed");
    else
      $display("Test case 1 Failed");

    // Test case 2: Transition from red to green
    #32;
    if (!red && !yellow && green)
      $display("Test case 2 Passed");
    else
      $display("Test case 2 Failed");

    // Test case 3: Transition from green to yellow
    #20;
    if (!red && yellow && !green)
      $display("Test case 3 Passed");
    else
      $display("Test case 3 Failed");

    // Test case 4: Transition from yellow to red
    #7;
    if (red && !yellow && !green)
      $display("Test case 4 Passed");
    else
      $display("Test case 4 Failed");

    // Test case 5: Enable signal changes
    #10;
    if (red && !yellow && !green)
      $display("Test case 5 Passed");
    else
      $display("Test case 5 Failed");

    // Finish simulation
    $finish;
  end

  // Dump waveform
  initial begin
    $dumpfile("WaveOutput.vcd");
    $dumpvars(0, traffic_light_tb);
  end

endmodule
