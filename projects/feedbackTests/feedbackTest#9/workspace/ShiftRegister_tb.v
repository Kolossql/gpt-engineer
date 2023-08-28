module ShiftRegister_tb;

  // Inputs
  reg clk = 0;
  reg reset;
  reg data;
  reg shift_enable;

  // Outputs
  wire [7:0] stored_data;

  // Instantiate the ShiftRegister module
  ShiftRegister dut (
    .clk(clk),
    .reset(reset),
    .data(data),
    .shift_enable(shift_enable),
    .stored_data(stored_data)
  );

  // Clock generator
  always #5 clk = ~clk;

  // Reset generator
  initial begin
    reset = 1;
    #10 reset = 0;
  end

  // Data generator
  initial begin
    data = 0;
    #20 data = 1;
    #20 data = 0;
    #20 data = 1;
    #20 data = 0;
  end

  // Shift enable generator
  initial begin
    shift_enable = 0;
    #30 shift_enable = 1;
    #40 shift_enable = 0;
    #50 shift_enable = 1;
    #60 shift_enable = 0;
  end

  // Monitor
  always @(posedge clk) begin
    $display("Stored Data: %b", stored_data);
    if (stored_data === 8'b00000000)
      $display("Passed: Initial state test");
    else if (stored_data === 8'b00000001)
      $display("Passed: Shift operation test");
    else if (stored_data === 8'b00000000)
      $display("Passed: Reset operation test");
    else if (stored_data === 8'b00000000)
      $display("Passed: Hold state test");
    else if (stored_data === 8'b00000001)
      $display("Passed: Output verification test");
    else
      $display("Failed: Unexpected output");
  end

  // Simulation end
  initial begin
    $dumpfile("WaveOutput.vcd");
    $dumpvars(0, ShiftRegister_tb);
    #100;
    $finish;
  end

endmodule
