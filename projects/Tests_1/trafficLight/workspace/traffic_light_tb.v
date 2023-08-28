module traffic_light_tb;

  // Parameters
  parameter CLK_PERIOD = 10; // Clock period in ns

  // Signals
  reg clk;
  reg reset;
  reg enable;
  wire red;
  wire yellow;
  wire green;

  // Instantiate the traffic light module
  traffic_light dut (
    .clk(clk),
    .reset(reset),
    .enable(enable),
    .red(red),
    .yellow(yellow),
    .green(green)
  );

  // Clock generator
  always #((CLK_PERIOD)/2) clk = ~clk;

  // Reset generator
  initial begin
    reset = 1;
    #((CLK_PERIOD)*2) reset = 0;
    #((CLK_PERIOD)*10) reset = 1;
  end

  // Enable generator
  initial begin
    enable = 1;
    #((CLK_PERIOD)*20) enable = 0;
    #((CLK_PERIOD)*30) enable = 1;
  end

  // Monitor
  always @(posedge clk) begin
    $display("Red: %b, Yellow: %b, Green: %b", red, yellow, green);
  end

  // Test cases
  initial begin
    // Case 1: Initial state
    #((CLK_PERIOD)*32) $display("Case 1: Initial state");

    // Case 2: Transition from red to green
    #((CLK_PERIOD)*32) $display("Case 2: Transition from red to green");

    // Case 3: Transition from green to yellow
    #((CLK_PERIOD)*20) $display("Case 3: Transition from green to yellow");

    // Case 4: Transition from yellow to red
    #((CLK_PERIOD)*7) $display("Case 4: Transition from yellow to red");

    // Case 5: Enable signal low
    #((CLK_PERIOD)*10) $display("Case 5: Enable signal low");
    #((CLK_PERIOD)*20) $display("Case 5: Enable signal low");
  end

endmodule
