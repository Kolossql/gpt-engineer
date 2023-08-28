module traffic_light_tb;

  // Inputs
  reg clk;
  reg reset;
  reg enable;

  // Outputs
  wire red;
  wire yellow;
  wire green;

  // Instantiate the module under test
  TrafficLightController dut (
    .clk(clk),
    .reset(reset),
    .enable(enable),
    .red(red),
    .yellow(yellow),
    .green(green)
  );

  // Clock Generator
  always #5 clk = ~clk;

  // Reset Generator
  initial begin
    reset = 1;
    #10 reset = 0;
  end

  // Enable Generator
  initial begin
    enable = 1;
    #50 enable = 0;
    #50 enable = 1;
    #50 enable = 0;
  end

  // Monitor
  always @(red, yellow, green) begin
    $display("Red: %b, Yellow: %b, Green: %b", red, yellow, green);
  end

  // Test Cases
  initial begin
    // Test Case 1: Transition from red to green after 32 clock cycles
    #160;
    if (red === 1'b1 && yellow === 1'b0 && green === 1'b0)
      $display("Test Case 1 Passed");
    else
      $display("Test Case 1 Failed");

    // Test Case 2: Transition from green to yellow after 20 clock cycles
    #100;
    if (red === 1'b0 && yellow === 1'b1 && green === 1'b0)
      $display("Test Case 2 Passed");
    else
      $display("Test Case 2 Failed");

    // Test Case 3: Transition from yellow to red after 7 clock cycles
    #35;
    if (red === 1'b0 && yellow === 1'b0 && green === 1'b1)
      $display("Test Case 3 Passed");
    else
      $display("Test Case 3 Failed");

    // Test Case 4: Resetting the module to its initial state
    reset = 1;
    #10 reset = 0;
    if (red === 1'b1 && yellow === 1'b0 && green === 1'b0)
      $display("Test Case 4 Passed");
    else
      $display("Test Case 4 Failed");

    // Test Case 5: Pausing the operation of the module by setting the enable signal low
    enable = 0;
    #100;
    if (red === 1'b1 && yellow === 1'b0 && green === 1'b0)
      $display("Test Case 5 Passed");
    else
      $display("Test Case 5 Failed");

    // Finish the simulation
    $finish;
  end

  // Dump waveform for GTKWave
  initial begin
    $dumpfile("WaveOutput.vcd");
    $dumpvars(0, traffic_light_tb);
  end

endmodule
