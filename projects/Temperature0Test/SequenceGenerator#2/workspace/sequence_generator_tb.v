module sequence_generator_tb;

  // Parameters
  parameter CLK_PERIOD = 10; // Clock period in ns

  // Inputs
  reg clk;
  reg reset;
  reg enable;

  // Outputs
  wire [7:0] data;

  // Instantiate sequence generator module
  sequence_generator dut (
    .clk(clk),
    .reset(reset),
    .enable(enable),
    .data(data)
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
    enable = 1;
    #((CLK_PERIOD)*10) enable = 0;
    #((CLK_PERIOD)*10) enable = 1;
  end

  // Test cases
  initial begin
    // Test case 1: Initial state
    $display("Test case 1: Initial state");
    #((CLK_PERIOD)*2) $display("Data: %h", data);

    // Test case 2: Clock edge triggering
    $display("Test case 2: Clock edge triggering");
    #((CLK_PERIOD)*2) $display("Data: %h", data);
    #((CLK_PERIOD)*2) $display("Data: %h", data);

    // Test case 3: Active-low reset
    $display("Test case 3: Active-low reset");
    reset = 1;
    #((CLK_PERIOD)*2) reset = 0;
    #((CLK_PERIOD)*2) $display("Data: %h", data);

    // Test case 4: Enable signal
    $display("Test case 4: Enable signal");
    enable = 0;
    #((CLK_PERIOD)*2) $display("Data: %h", data);
    #((CLK_PERIOD)*10) enable = 1;
    #((CLK_PERIOD)*2) $display("Data: %h", data);

    // Test case 5: Continuous generation
    $display("Test case 5: Continuous generation");
    #((CLK_PERIOD)*20) $display("Data: %h", data);
    #((CLK_PERIOD)*20) $display("Data: %h", data);
    #((CLK_PERIOD)*20) $display("Data: %h", data);
    #((CLK_PERIOD)*20) $display("Data: %h", data);
    #((CLK_PERIOD)*20) $display("Data: %h", data);
  end

endmodule
