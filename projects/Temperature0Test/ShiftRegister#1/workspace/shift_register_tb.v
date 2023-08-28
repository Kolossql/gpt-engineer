module shift_register_tb;

  // Parameters
  parameter CLK_PERIOD = 10; // Clock period in ns

  // Inputs
  reg clk;
  reg reset;
  reg data;
  reg shift_enable;

  // Outputs
  wire [7:0] stored_data;

  // Instantiate the shift register module
  shift_register dut (
    .clk(clk),
    .reset(reset),
    .data(data),
    .shift_enable(shift_enable),
    .stored_data(stored_data)
  );

  // Clock generator
  always #((CLK_PERIOD)/2) clk = ~clk;

  // Stimulus generator
  initial begin
    clk = 0;
    reset = 1;
    data = 0;
    shift_enable = 0;

    // Wait for a few clock cycles
    #((CLK_PERIOD)*5);

    // Test case 1: Initial state
    $display("Test Case 1: Initial state");
    $display("Stored Data: %b", stored_data);
    #((CLK_PERIOD)*5);

    // Test case 2: Shift enable low
    $display("Test Case 2: Shift enable low");
    reset = 0;
    shift_enable = 0;
    data = 1;
    #((CLK_PERIOD)*5);
    $display("Stored Data: %b", stored_data);
    #((CLK_PERIOD)*5);

    // Test case 3: Shift enable high
    $display("Test Case 3: Shift enable high");
    shift_enable = 1;
    #((CLK_PERIOD)*5);
    $display("Stored Data: %b", stored_data);
    #((CLK_PERIOD)*5);

    // Test case 4: Active-low reset
    $display("Test Case 4: Active-low reset");
    reset = 1;
    #((CLK_PERIOD)*5);
    $display("Stored Data: %b", stored_data);
    #((CLK_PERIOD)*5);

    // Test case 5: Data change
    $display("Test Case 5: Data change");
    reset = 0;
    data = 0;
    #((CLK_PERIOD)*5);
    $display("Stored Data: %b", stored_data);
    #((CLK_PERIOD)*5);

    $finish;
  end

endmodule
