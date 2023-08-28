module shift_register_tb;

  // Inputs
  reg clk;
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
  always begin
    clk = 0;
    #5;
    clk = 1;
    #5;
  end

  // Reset generator
  initial begin
    reset = 1;
    #10;
    reset = 0;
    #10;
  end

  // Data generator
  initial begin
    data = 0;
    #20;
    data = 1;
    #20;
    data = 0;
    #20;
  end

  // Shift enable generator
  initial begin
    shift_enable = 0;
    #15;
    shift_enable = 1;
    #30;
    shift_enable = 0;
    #15;
  end

  // Monitor
  always @(posedge clk) begin
    $display("Stored Data: %b", stored_data);
    if (stored_data === 8'b00000000)
      $display("Passed: Initial state test");
    else
      $display("Failed: Initial state test");

    if (stored_data === 8'b00000001)
      $display("Passed: Shifting test");
    else
      $display("Failed: Shifting test");

    if (stored_data === 8'b00000000)
      $display("Passed: Reset test");
    else
      $display("Failed: Reset test");

    if (stored_data === 8'b00000001)
      $display("Passed: Data change test");
    else
      $display("Failed: Data change test");

    $display("Finished testing");
    $finish;
  end

  // Dump waveform to VCD file
  initial begin
    $dumpfile("WaveOutput.vcd");
    $dumpvars(0, shift_register_tb);
  end

endmodule
