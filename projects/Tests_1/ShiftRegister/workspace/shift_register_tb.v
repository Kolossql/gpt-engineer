module shift_register_tb;

  // Parameters
  parameter CLK_PERIOD = 10; // Clock period in ns

  // Inputs
  reg clk;
  reg reset;
  reg shift_enable;
  reg data;

  // Outputs
  wire [7:0] stored_data;

  // Instantiate the shift register module
  ShiftRegister dut (
    .clk(clk),
    .reset(reset),
    .shift_enable(shift_enable),
    .data_in(data),
    .data_out(stored_data)
  );

  // Clock generation
  always #((CLK_PERIOD)/2) clk = ~clk;

  // Initial state test
  initial begin
    $display("Test: Initial State");
    reset = 1;
    shift_enable = 0;
    data = 0;
    #10;
    reset = 0;
    #10;
    $display("Stored Data: %b", stored_data);
    $finish;
  end

  // Shift enable low test
  initial begin
    $display("Test: Shift Enable Low");
    reset = 0;
    shift_enable = 0;
    data = 1;
    #10;
    $display("Stored Data: %b", stored_data);
    $finish;
  end

  // Active-low reset test
  initial begin
    $display("Test: Active-low Reset");
    reset = 1;
    shift_enable = 1;
    data = 1;
    #10;
    reset = 0;
    #10;
    $display("Stored Data: %b", stored_data);
    $finish;
  end

  // Shifting operation test
  initial begin
    $display("Test: Shifting Operation");
    reset = 0;
    shift_enable = 1;
    data = 1;
    #10;
    data = 0;
    #10;
    data = 1;
    #10;
    data = 0;
    #10;
    $display("Stored Data: %b", stored_data);
    $finish;
  end

  // Data change test
  initial begin
    $display("Test: Data Change");
    reset = 0;
    shift_enable = 1;
    data = 1;
    #10;
    data = 0;
    #10;
    data = 1;
    #10;
    data = 0;
    #10;
    data = 1;
    #10;
    $display("Stored Data: %b", stored_data);
    $finish;
  end

endmodule
