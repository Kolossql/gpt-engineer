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

  // Instantiate the module under test
  traffic_light_module uut (
    .clk(clk),
    .reset(reset),
    .enable(enable),
    .red(red),
    .yellow(yellow),
    .green(green)
  );

  // Clock generation
  always begin
    clk = 0;
    #((CLK_PERIOD)/2);
    clk = 1;
    #((CLK_PERIOD)/2);
  end

  // Testbench stimulus
  initial begin
    // Initialize inputs
    reset = 1;
    enable = 1;

    // Wait for a few clock cycles
    #((CLK_PERIOD)*5);

    // Release reset
    reset = 0;

    // Test initial state
    #((CLK_PERIOD)*32);
    $display("Initial State Test:");
    $display("Red: %b, Yellow: %b, Green: %b", red, yellow, green);

    // Test transition from red to green
    #((CLK_PERIOD)*32);
    $display("Transition from Red to Green Test:");
    $display("Red: %b, Yellow: %b, Green: %b", red, yellow, green);

    // Test transition from green to yellow
    #((CLK_PERIOD)*20);
    $display("Transition from Green to Yellow Test:");
    $display("Red: %b, Yellow: %b, Green: %b", red, yellow, green);

    // Test transition from yellow to red
    #((CLK_PERIOD)*7);
    $display("Transition from Yellow to Red Test:");
    $display("Red: %b, Yellow: %b, Green: %b", red, yellow, green);

    // Test enable signal transitions
    enable = 0;
    #((CLK_PERIOD)*10);
    $display("Enable Signal Transition Test (Enable = 0):");
    $display("Red: %b, Yellow: %b, Green: %b", red, yellow, green);

    enable = 1;
    #((CLK_PERIOD)*10);
    $display("Enable Signal Transition Test (Enable = 1):");
    $display("Red: %b, Yellow: %b, Green: %b", red, yellow, green);

    // End simulation
    $finish;
  end

endmodule
