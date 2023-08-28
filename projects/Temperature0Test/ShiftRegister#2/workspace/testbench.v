module Testbench;

  reg clk;
  reg reset;
  reg shift_enable;
  reg data_in;
  wire [7:0] data_out;

  ShiftRegister dut (
    .clk(clk),
    .reset(reset),
    .shift_enable(shift_enable),
    .data_in(data_in),
    .data_out(data_out)
  );

  initial begin
    clk = 0;
    reset = 1;
    shift_enable = 0;
    data_in = 0;

    #10 reset = 0;

    // Test Case 1: Shift in data
    shift_enable = 1;
    data_in = 1;
    #10;
    shift_enable = 0;
    data_in = 0;
    #10;
    shift_enable = 1;
    data_in = 0;
    #10;
    shift_enable = 0;
    data_in = 1;
    #10;
    shift_enable = 1;
    data_in = 1;
    #10;
    shift_enable = 0;
    data_in = 0;
    #10;
    shift_enable = 1;
    data_in = 1;
    #10;
    shift_enable = 0;
    data_in = 0;
    #10;

    // Test Case 2: Reset
    reset = 1;
    #10 reset = 0;
    shift_enable = 1;
    data_in = 1;
    #10;
    reset = 1;
    #10 reset = 0;
    shift_enable = 1;
    data_in = 0;
    #10;
    reset = 1;
    #10 reset = 0;
    shift_enable = 0;
    data_in = 1;
    #10;
    reset = 1;
    #10 reset = 0;
    shift_enable = 0;
    data_in = 0;
    #10;

    $finish;
  end

  always begin
    #5 clk = ~clk;
  end

endmodule
