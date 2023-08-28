module testbench_shift_register;

  // Inputs
  reg clk;
  reg reset;
  reg data;
  reg shift_enable;

  // Outputs
  wire [7:0] stored_data;

  // Instantiate the shift_register module
  shift_register dut (
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
    reset = 1;
    #10;
    reset = 0;
  end

  // Data generator
  initial begin
    data = 0;
    #20;
    data = 1;
    #20;
    data = 0;
  end

  // Shift enable generator
  initial begin
    shift_enable = 0;
    #15;
    shift_enable = 1;
    #30;
    shift_enable = 0;
  end

  // Monitor
  always @(posedge clk) begin
    $display("Stored Data: %b", stored_data);
    if (stored_data === 8'b00000000)
      $display("Passed: Initial state test");
    else
      $display("Failed: Initial state test");

    if (stored_data === 8'b00000001)
      $display("Passed: Shift operation test");
    else
      $display("Failed: Shift operation test");

    if (stored_data === 8'b00000000)
      $display("Passed: Shift operation with shift enable low test");
    else
      $display("Failed: Shift operation with shift enable low test");

    if (stored_data === 8'b00000000)
      $display("Passed: Reset operation test");
    else
      $display("Failed: Reset operation test");

    if (stored_data === 8'b00000010)
      $display("Passed: Output when data is changed test");
    else
      $display("Failed: Output when data is changed test");
  end

  // Dump waveform and finish simulation
  initial begin
    $dumpfile("WaveOutput.vcd");
    $dumpvars(0, testbench_shift_register);
    #100;
    $finish;
  end

endmodule
