module testbench;

  // Inputs
  reg [4:0] binary_input;
  
  // Outputs
  wire [7:0] bcd_output;
  
  // Instantiate the binary to BCD converter module
  binary_to_bcd_converter dut (
    .binary_input(binary_input),
    .bcd_output(bcd_output)
  );
  
  // Clock generation
  reg clk;
  always #5 clk = ~clk;
  
  // Test inputs
  initial begin
    clk = 0;
    binary_input = 5'b00000; // Minimum input value
    #10;
    binary_input = 5'b11111; // Maximum input value
    #10;
    binary_input = 5'b11111; // All bits set to 1
    #10;
    binary_input = 5'b00000; // All bits set to 0
    #10;
    binary_input = 5'b11010; // Random input value
    #10;
    $finish;
  end
  
  // Display statements for verification
  always @(posedge clk) begin
    $display("Binary Input: %b", binary_input);
    $display("BCD Output: %b", bcd_output);
  end
  
  // Dump waveform for visualization
  initial begin
    $dumpfile("WaveOutput.vcd");
    $dumpvars(1, testbench);
  end
  
endmodule
