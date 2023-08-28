module shift_register_tb;

  // Parameters
  parameter CLK_PERIOD = 10; // Clock period in ns

  // Inputs
  reg clk;
  reg reset;
  reg data_in;
  reg shift_enable;

  // Outputs
  wire [7:0] data_out;

  // Instantiate the shift register module
  ShiftRegister dut (
    .clk(clk),
    .reset(reset),
    .data_in(data_in),
    .shift_enable(shift_enable),
    .data_out(data_out)
  );

  // Clock generator
  always #((CLK_PERIOD)/2) clk = ~clk;

  // Stimulus generator
  initial begin
    // Initialize inputs
    reset = 1;
    data_in = 0;
    shift_enable = 0;

    // Release reset
    #((CLK_PERIOD)*2) reset = 0;

    // Test case 1: Initial state
    #((CLK_PERIOD)*10) begin
      if (data_out === 8'b00000000)
        $display("Test case 1 Passed");
      else
        $display("Test case 1 Failed");
    end

    // Test case 2: Clock edge triggering
    #((CLK_PERIOD)*5) begin
      clk = 1;
      reset = 1;
      data_in = 1;
      shift_enable = 1;
    end
    #((CLK_PERIOD)*5) begin
      if (data_out === 8'b00000001)
        $display("Test case 2 Passed");
      else
        $display("Test case 2 Failed");
    end

    // Test case 3: Active-low reset
    #((CLK_PERIOD)*5) begin
      reset = 0;
    end
    #((CLK_PERIOD)*5) begin
      if (data_out === 8'b00000000)
        $display("Test case 3 Passed");
      else
        $display("Test case 3 Failed");
    end

    // Test case 4: Data bit input
    #((CLK_PERIOD)*5) begin
      reset = 1;
      data_in = 1;
    end
    #((CLK_PERIOD)*5) begin
      if (data_out === 8'b00000001)
        $display("Test case 4 Passed");
      else
        $display("Test case 4 Failed");
    end

    // Test case 5: Shift enable
    #((CLK_PERIOD)*5) begin
      reset = 1;
      data_in = 1;
      shift_enable = 1;
    end
    #((CLK_PERIOD)*5) begin
      if (data_out === 8'b00000010)
        $display("Test case 5 Passed");
      else
        $display("Test case 5 Failed");
    end

    // End simulation
    $finish;
  end

  // Monitor
  always @(posedge clk) begin
    $display("Data Out: %b", data_out);
  end

  // Dump waveform
  initial begin
    $dumpfile("WaveOutput.vcd");
    $dumpvars(0, shift_register_tb);
  end

endmodule
