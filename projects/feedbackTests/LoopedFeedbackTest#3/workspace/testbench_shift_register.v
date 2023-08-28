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
  always #5 clk = ~clk;

  // Stimulus generator
  initial begin
    // Test case 1: Reset the module and verify that the stored data is 00000000
    reset = 1;
    data = 0;
    shift_enable = 0;
    #10 reset = 0;
    #20 if (stored_data === 8'b00000000) $display("Test case 1 Passed");
       else $display("Test case 1 Failed");

    // Test case 2: Shift enable is low, verify that the stored data remains unchanged
    reset = 0;
    data = 1;
    shift_enable = 0;
    #10 if (stored_data === 8'b00000000) $display("Test case 2 Passed");
       else $display("Test case 2 Failed");

    // Test case 3: Shift enable is high, verify that the data bit is shifted to the right of the data vector
    reset = 0;
    data = 1;
    shift_enable = 1;
    #10 if (stored_data === 8'b00000001) $display("Test case 3 Passed");
       else $display("Test case 3 Failed");

    // Test case 4: Test with different input data patterns to verify the shifting behavior
    reset = 0;
    data = 0;
    shift_enable = 1;
    #10 if (stored_data === 8'b00000010) $display("Test case 4 Passed");
       else $display("Test case 4 Failed");

    reset = 0;
    data = 1;
    shift_enable = 1;
    #10 if (stored_data === 8'b00000101) $display("Test case 5 Passed");
       else $display("Test case 5 Failed");

    reset = 0;
    data = 0;
    shift_enable = 1;
    #10 if (stored_data === 8'b00001010) $display("Test case 6 Passed");
       else $display("Test case 6 Failed");

    // Test case 5: Test with different clock frequencies to verify the synchronization
    reset = 0;
    data = 1;
    shift_enable = 1;
    #5 clk = 1;
    #5 clk = 0;
    #5 clk = 1;
    #5 clk = 0;
    #10 if (stored_data === 8'b00010101) $display("Test case 7 Passed");
       else $display("Test case 7 Failed");

    // Finish the simulation
    $finish;
  end

  // Monitor
  always @(posedge clk) begin
    $display("Stored Data: %b", stored_data);
  end

  // Dump waveform for debugging
  initial begin
    $dumpfile("WaveOutput.vcd");
    $dumpvars(0, testbench_shift_register);
  end

endmodule
