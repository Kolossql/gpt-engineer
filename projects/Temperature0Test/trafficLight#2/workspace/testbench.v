module testbench;
  
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
  traffic_light_module uut (
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
  end
  
  // Enable generator
  initial begin
    enable = 0;
    #((CLK_PERIOD)*2) enable = 1;
    #((CLK_PERIOD)*10) enable = 0;
    #((CLK_PERIOD)*2) enable = 1;
    #((CLK_PERIOD)*10) enable = 0;
    #((CLK_PERIOD)*2) enable = 1;
    #((CLK_PERIOD)*10) enable = 0;
    #((CLK_PERIOD)*2) enable = 1;
    #((CLK_PERIOD)*10) enable = 0;
    #((CLK_PERIOD)*2) enable = 1;
    #((CLK_PERIOD)*10) enable = 0;
  end
  
  // Monitor
  always @(posedge clk) begin
    $display("Red: %b, Yellow: %b, Green: %b", red, yellow, green);
  end
  
  // Stop simulation
  initial begin
    #((CLK_PERIOD)*100);
    $finish;
  end
  
endmodule
