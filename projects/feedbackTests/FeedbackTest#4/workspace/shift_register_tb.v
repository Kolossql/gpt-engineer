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
  end

  // Data generator
  initial begin
    data = 0;
    #20;
    data = 1;
    #20;
    data = 0;
    #20;
    data = 1;
    #20;
  end

  // Shift enable generator
  initial begin
    shift_enable = 0;
    #10;
    shift_enable = 1;
    #40;
    shift_enable = 0;
    #20;
    shift_enable = 1;
    #40;
  end

  // Monitor
  always @(posedge clk) begin
    if (shift_enable) begin
      if (stored_data === 8'b00000000)
        $display("Passed: Shift enable high - Data shifted correctly");
      else
        $display("Failed: Shift enable high - Data not shifted correctly");
    end

    if (!shift_enable) begin
      if (stored_data === 8'b00000000)
        $display("Passed: Shift enable low - Data held correctly");
      else
        $display("Failed: Shift enable low - Data not held correctly");
    end

    if (reset) begin
      if (stored_data === 8'b00000000)
        $display("Passed: Active-low reset - Module reset correctly");
      else
        $display("Failed: Active-low reset - Module not reset correctly");
    end

    if (data) begin
      if (stored_data === 8'b00000001)
        $display("Passed: Data change - Stored data outputted correctly");
      else
        $display("Failed: Data change - Stored data not outputted correctly");
    end
  end

  // Dump waveform to VCD file
  initial begin
    $dumpfile("WaveOutput.vcd");
    $dumpvars(0, shift_register_tb);
  end

endmodule
