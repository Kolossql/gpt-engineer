module ABRO_Module_tb;

  // Inputs
  reg clk;
  reg reset;
  reg A;
  reg B;

  // Outputs
  wire O;
  wire [1:0] state;

  // Instantiate ABRO_Module
  ABRO_Module abro (
    .clk(clk),
    .reset(reset),
    .A(A),
    .B(B),
    .O(O),
    .state(state)
  );

  // Clock generation
  always begin
    #5 clk = ~clk;
  end

  // Testbench stimulus
  initial begin
    clk = 0;
    reset = 1;
    A = 0;
    B = 0;
    #10 reset = 0;
    #10 A = 1;
    #10 A = 0;
    #10 B = 1;
    #10 B = 0;
    #10 A = 1;
    #10 B = 1;
    #10 $finish;
  end

endmodule
