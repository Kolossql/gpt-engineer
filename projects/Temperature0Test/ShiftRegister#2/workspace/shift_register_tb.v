module shift_register_tb;

  // Parameters
  parameter DATA_WIDTH = 8;

  // Inputs
  reg clk;
  reg reset;
  reg shift_enable;
  reg data_in;

  // Outputs
  wire [DATA_WIDTH-1:0] data_out;

  // Instantiate the shift register module
  shift_register dut (
    .clk(clk),
    .reset(reset),
    .shift_enable(shift_enable),
    .data_in(data_in),
    .data_out(data_out)
  );

  // Clock generation
  always begin
    clk = 0;
    #5;
    clk = 1;
    #5;
  end

  // Testbench logic
  initial begin
    // Initialize inputs
    reset = 1;
    shift_enable = 0;
    data_in = 0;

    // Wait for a few clock cycles
    #20;

    // Release reset
    reset = 0;

    // Test case 1: Initial state
    $display("Test Case 1: Initial state");
    #10;
    if (data_out !== 8'b00000000)
      $display("ERROR: Incorrect initial state");

    // Test case 2: Shift enable low
    $display("Test Case 2: Shift enable low");
    shift_enable = 0;
    data_in = 1;
    #10;
    if (data_out !== 8'b00000000)
      $display("ERROR: Incorrect output when shift enable is low");

    // Test case 3: Shift enable high
    $display("Test Case 3: Shift enable high");
    shift_enable = 1;
    data_in = 1;
    #10;
    if (data_out !== 8'b00000001)
      $display("ERROR: Incorrect output when shift enable is high");

    // Test case 4: Active-low reset
    $display("Test Case 4: Active-low reset");
    reset = 1;
    #10;
    if (data_out !== 8'b00000000)
      $display("ERROR: Incorrect output after reset");

    // Test case 5: Data change
    $display("Test Case 5: Data change");
    reset = 0;
    data_in = 0;
    #10;
    if (data_out !== 8'b00000000)
      $display("ERROR: Incorrect output after data change");

    // End simulation
    $display("Simulation complete");
    $finish;
  end

endmodule
