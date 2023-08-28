module testbench_traffic_light_module;
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

  // Clock generator
  always #5 clk = ~clk;

  // Reset generator
  initial begin
    reset_n = 0;
    #10 reset_n = 1;
  end

  // Enable generator
  initial begin
    enable = 0;
    #20 enable = 1;
    #30 enable = 0;
    #40 enable = 1;
  end

  // Monitor
  always @(posedge clk) begin
    $display("Red: %b, Yellow: %b, Green: %b", red, yellow, green);
  end

  // Test cases
  initial begin
    // Test case 1: Initial state
    $display("Test case 1: Initial state");
    #160;
    if (red && !yellow && !green)
      $display("Passed");
    else
      $display("Failed");

    // Test case 2: Transition from red to green
    $display("Test case 2: Transition from red to green");
    #32;
    if (!red && !yellow && green)
      $display("Passed");
    else
      $display("Failed");

    // Test case 3: Transition from green to yellow
    $display("Test case 3: Transition from green to yellow");
    #20;
    if (!red && yellow && !green)
      $display("Passed");
    else
      $display("Failed");

    // Test case 4: Transition from yellow to red
    $display("Test case 4: Transition from yellow to red");
    #7;
    if (red && !yellow && !green)
      $display("Passed");
    else
      $display("Failed");

    // Test case 5: Enable signal changes during state transition
    $display("Test case 5: Enable signal changes during state transition");
    #10;
    enable = 0;
    #10;
    enable = 1;
    #10;
    enable = 0;
    #10;
    enable = 1;
    #32;
    if (!red && !yellow && green)
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
