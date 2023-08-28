module testbench_shift_register;
  // Inputs
  reg clk;
  reg reset;
  reg data_in;
  reg shift_enable;

  // Outputs
  wire [7:0] data_out;

  // Instantiate the shift_register module
  shift_register dut (
    .clk(clk),
    .reset(reset),
    .data_in(data_in),
    .shift_enable(shift_enable),
    .data_out(data_out)
  );

  // Clock generator
  always begin
    clk = 0;
    #5;
    clk = 1;
    #5;
  end

  // Stimulus generator
  initial begin
    // Test case 1: Shift enable is low, no shift operation should occur
    reset = 0;
    data_in = 1;
    shift_enable = 0;
    #20;
    if (data_out === 8'b00000000)
      $display("Test case 1 Passed");
    else
      $display("Test case 1 Failed");

    // Test case 2: Shift enable is high, clock signal triggers the shift operation
    reset = 0;
    data_in = 1;
    shift_enable = 1;
    #10;
    if (data_out === 8'b00000001)
      $display("Test case 2 Passed");
    else
      $display("Test case 2 Failed");

    // Test case 3: Active-low reset signal is triggered, the shift register should reset to the initial state
    reset = 1;
    data_in = 0;
    shift_enable = 1;
    #10;
    reset = 0;
    #10;
    if (data_out === 8'b00000000)
      $display("Test case 3 Passed");
    else
      $display("Test case 3 Failed");

    // Test case 4: Data input signal is changed, the next bit to be shifted should be updated
    reset = 0;
    data_in = 1;
    shift_enable = 1;
    #10;
    data_in = 0;
    #10;
    if (data_out === 8'b00000010)
      $display("Test case 4 Passed");
    else
      $display("Test case 4 Failed");

    // Test case 5: Data output signal is changed, the stored data in the shift register should be modified
    reset = 0;
    data_in = 1;
    shift_enable = 1;
    #10;
    data_out = 8'b00000011;
    #10;
    if (data_out === 8'b00000011)
      $display("Test case 5 Passed");
    else
      $display("Test case 5 Failed");

    // End simulation
    $finish;
  end

  // Monitor
  always @(posedge clk) begin
    $display("data_out = %b", data_out);
  end

  // Dump waveform
  initial begin
    $dumpfile("WaveOutput.vcd");
    $dumpvars(0, testbench_shift_register);
  end
endmodule
