module testbench_shift_register;

  // Parameters
  parameter CLK_PERIOD = 10; // Clock period in time units

  // Inputs
  reg clk;
  reg reset;
  reg data;
  reg shift_enable;

  // Outputs
  wire [7:0] stored_data;

  // Instantiate ShiftRegister module
  ShiftRegister dut (
    .clk(clk),
    .reset(reset),
    .data(data),
    .shift_enable(shift_enable),
    .stored_data(stored_data)
  );

  // Clock generator
  always begin
    clk = 0;
    #CLK_PERIOD/2;
    clk = 1;
    #CLK_PERIOD/2;
  end

  // Reset generator
  initial begin
    reset = 1;
    #CLK_PERIOD*2;
    reset = 0;
  end

  // Data generator
  initial begin
    data = 0;
    #CLK_PERIOD*2;
    data = 1;
    #CLK_PERIOD*2;
    data = 0;
  end

  // Shift enable generator
  initial begin
    shift_enable = 0;
    #CLK_PERIOD*2;
    shift_enable = 1;
    #CLK_PERIOD*2;
    shift_enable = 0;
  end

  // Monitor
  always @(posedge clk) begin
    $display("Stored Data: %b", stored_data);
    // Compare stored_data with expected output and display pass/fail
    // Add additional checks for each test case
    // Test case 1: No shifting operation
    if (stored_data === 8'b00000000)
      $display("Test case 1 Passed");
    else
      $display("Test case 1 Failed");

    // Test case 2: Single shift operation
    if (stored_data === 8'b00000001)
      $display("Test case 2 Passed");
    else
      $display("Test case 2 Failed");

    // Test case 3: Multiple shift operations
    if (stored_data === 8'b00000100)
      $display("Test case 3 Passed");
    else
      $display("Test case 3 Failed");

    // Test case 4: Reset operation
    if (stored_data === 8'b00000000)
      $display("Test case 4 Passed");
    else
      $display("Test case 4 Failed");

    // Test case 5: Changing input data
    if (stored_data === 8'b00000010)
      $display("Test case 5 Passed");
    else
      $display("Test case 5 Failed");
  end

  // Dump waveform to VCD file
  initial begin
    $dumpfile("WaveOutput.vcd");
    $dumpvars(0, testbench_shift_register);
  end

endmodule
