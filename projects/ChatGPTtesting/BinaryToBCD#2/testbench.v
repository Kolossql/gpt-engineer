`timescale 1ns / 1ps
module tb_binary_to_bcd;

  reg [7:0] binary_input_reg;  // renamed to avoid confusion
  wire [7:0] binary_input = binary_input_reg;  // added this line
  wire [3:0] hundreds;
  wire [3:0] tens;
  wire [3:0] ones;
  reg clk;
  reg reset;

  binary_to_bcd u1 (
    .binary_input(binary_input),
    .hundreds(hundreds),
    .tens(tens),
    .ones(ones),
    .clk(clk),
    .reset(reset)
  );

  integer i;

  initial begin
    $dumpfile("tb_binary_to_bcd.vcd");
    $dumpvars(0, tb_binary_to_bcd);

    // Reset the design
    reset = 0;
    clk = 0;
    #10 reset = 1;

    // Test the design with some random values
    for (i = 0; i < 256; i = i + 1) begin
      binary_input_reg = i;  // use blocking assignment for inputs
      @(posedge clk);
      if (hundreds !== i/100 || tens !== (i%100)/10 || ones !== i%10) begin
        $display("Test failed for input = %d, Expected BCD = %d%d%d, Actual BCD = %d%d%d", i, i/100, (i%100)/10, i%10, hundreds, tens, ones);
        $finish;
      end
    end

    $display("All tests passed");
    $finish;
  end

  always #5 clk = ~clk;

endmodule