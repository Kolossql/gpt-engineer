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
  ShiftRegister dut (
    .clk(clk),
    .reset(reset),
    .data_in(data),
    .shift_enable(shift_enable),
    .data_out(stored_data)
  );

  // Clock generator
  always #((CLK_PERIOD)/2) clk = ~clk;

  // Stimulus generator
  initial begin
    // Initialize inputs
    reset = 1;
    data = 0;
    shift_enable = 0;

    // Wait for reset to deactivate
    #((CLK_PERIOD)*10);
    reset = 0;

    // Test case 1: Shift enable inactive
    #((CLK_PERIOD)*10);
    shift_enable = 0;
    data = 1;
    #((CLK_PERIOD)*10);
    data = 0;
    #((CLK_PERIOD)*10);
    data = 1;
    #((CLK_PERIOD)*10);
    data = 0;
    #((CLK_PERIOD)*10);
    data = 1;
    #((CLK_PERIOD)*10);
    data = 0;
    #((CLK_PERIOD)*10);
    data = 1;
    #((CLK_PERIOD)*10);
    data = 0;
    #((CLK_PERIOD)*10);
    data = 1;
    #((CLK_PERIOD)*10);
    data = 0;

    // Test case 2: Shift enable active
    #((CLK_PERIOD)*10);
    shift_enable = 1;
    data = 1;
    #((CLK_PERIOD)*10);
    data = 0;
    #((CLK_PERIOD)*10);
    data = 1;
    #((CLK_PERIOD)*10);
    data = 0;
    #((CLK_PERIOD)*10);
    data = 1;
    #((CLK_PERIOD)*10);
    data = 0;
    #((CLK_PERIOD)*10);
    data = 1;
    #((CLK_PERIOD)*10);
    data = 0;
    #((CLK_PERIOD)*10);
    data = 1;
    #((CLK_PERIOD)*10);
    data = 0;

    // Test case 3: Active-low reset
    #((CLK_PERIOD)*10);
    reset = 1;
    #((CLK_PERIOD)*10);
    reset = 0;
    #((CLK_PERIOD)*10);
    data = 1;
    #((CLK_PERIOD)*10);
    data = 0;
    #((CLK_PERIOD)*10);
    data = 1;
    #((CLK_PERIOD)*10);
    data = 0;
    #((CLK_PERIOD)*10);
    data = 1;
    #((CLK_PERIOD)*10);
    data = 0;
    #((CLK_PERIOD)*10);
    data = 1;
    #((CLK_PERIOD)*10);
    data = 0;

    // Test case 4: Varying clock frequency
    #((CLK_PERIOD)*5);
    shift_enable = 1;
    data = 1;
    #((CLK_PERIOD)*5);
    data = 0;
    #((CLK_PERIOD)*5);
    data = 1;
    #((CLK_PERIOD)*5);
    data = 0;
    #((CLK_PERIOD)*5);
    data = 1;
    #((CLK_PERIOD)*5);
    data = 0;
    #((CLK_PERIOD)*5);
    data = 1;
    #((CLK_PERIOD)*5);
    data = 0;
    #((CLK_PERIOD)*5);
    data = 1;
    #((CLK_PERIOD)*5);
    data = 0;

    // Test case 5: Output when data is changed
    #((CLK_PERIOD)*10);
    shift_enable = 1;
    data = 1;
    #((CLK_PERIOD)*10);
    data = 0;
    #((CLK_PERIOD)*10);
    data = 1;
    #((CLK_PERIOD)*10);
    data = 0;
    #((CLK_PERIOD)*10);
    data = 1;
    #((CLK_PERIOD)*10);
    data = 0;
    #((CLK_PERIOD)*10);
    data = 1;
    #((CLK_PERIOD)*10);
    data = 0;
    #((CLK_PERIOD)*10);
    data = 1;
    #((CLK_PERIOD)*10);
    data = 0;

    // End simulation
    #((CLK_PERIOD)*10);
    $finish;
  end

  // Monitor
  always @(posedge clk) begin
    $display("Stored Data: %b", stored_data);
  end

endmodule
