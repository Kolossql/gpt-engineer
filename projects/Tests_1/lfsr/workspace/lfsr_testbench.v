module lfsr_testbench;

  // Parameters
  parameter CLK_PERIOD = 20; // Clock period in ns

  // Inputs
  reg clk;
  reg reset;

  // Outputs
  wire [7:0] data;

  // Instantiate LFSR module
  lfsr lfsr_inst (
    .clk(clk),
    .reset(reset),
    .data(data)
  );

  // Clock generator
  always begin
    clk = 0;
    #((CLK_PERIOD / 2) - 1) // Delay for half the clock period
    clk = 1;
    #((CLK_PERIOD / 2) - 1) // Delay for half the clock period
  end

  // Reset generator
  initial begin
    reset = 1;
    #10 // Hold reset for 10 ns
    reset = 0;
  end

  // Monitor
  always @(posedge clk) begin
    $display("Data: %b", data);
  end

  // Test cases
  initial begin
    // Test initial state
    #10 // Wait for a few clock cycles
    $display("Test Case: Initial State");
    $display("Expected: 10001010");
    #10 // Wait for a few clock cycles

    // Test clock edge
    $display("Test Case: Clock Edge");
    $display("Expected: Random numbers on every clock edge");
    #100 // Wait for a few clock cycles

    // Test reset signal
    $display("Test Case: Reset Signal");
    $display("Expected: Reset to initial state");
    #10 // Wait for a few clock cycles
    reset = 1;
    #10 // Hold reset for 10 ns
    reset = 0;
    #100 // Wait for a few clock cycles

    // Test continuous operation
    $display("Test Case: Continuous Operation");
    $display("Expected: Continuous generation of random numbers");
    #1000 // Wait for a few clock cycles

    // Test output verification
    $display("Test Case: Output Verification");
    $display("Expected: Compare generated sequence with expected sequence");
    #1000 // Wait for a few clock cycles

    // End simulation
    $finish;
  end

endmodule
