module testbench_shiftregister;
  // Inputs
  reg clk  = 0;
  reg reset;
  reg data_in;
  reg shift_enable;

  // Outputs
  wire [7:0] data_out;

  // Instantiate the ShiftRegister module
  ShiftRegister dut (
    .clk(clk),
    .reset(reset),
    .data_in(data_in),
    .shift_enable(shift_enable),
    .data_out(data_out)
  );

  // Clock generator
  always #5 clk = ~clk; 

  // Reset generator
  initial begin
    reset = 1;
    #10 reset = 0;
    #50 reset = 1;
    #10 reset = 0;
    #30 $finish;
  end

  // Data generator
  initial begin
    $display("Data Out: %b", data_out);
    data_in = 0;
    $display("Data Out: %b", data_out);
    #20 data_in = 1;
    $display("Data Out: %b", data_out);
    #20 data_in = 0;
    $display("Data Out: %b", data_out);
    #20 data_in = 1;
    $display("Data Out: %b", data_out);
    #20 data_in = 0;
    $display("Data Out: %b", data_out);
  end

  // Shift enable generator
  initial begin
    shift_enable = 0;
    #15 shift_enable = 1;
    #25 shift_enable = 0;
    #25 shift_enable = 1;
    #15 shift_enable = 0;
  end

  // Monitor
  always @(posedge clk) begin
    #5 $display("Data Out: %b", data_out);
  end

  // Simulation end
  initial begin
    $dumpfile("WaveOutput.vcd");
    $dumpvars(0, testbench_shiftregister);
  end
endmodule
