module testbench;
  
  // Parameters
  parameter CLK_PERIOD = 10; // Clock period in ns
  
  // Signals
  reg [4:0] binary_input;
  wire [7:0] bcd_output;
  
  // Instantiate the binary to BCD converter module
  binary_to_bcd_converter dut (
    .binary_input(binary_input),
    .bcd_output(bcd_output)
  );
  
  // Clock generation
  reg clk;
  always #((CLK_PERIOD)/2) clk = ~clk;
  
  // Test input values
  initial begin
    // Test case 1: Minimum input value (0 in binary)
    binary_input = 5'b00000;
    #10;
    $display("Binary Input: %b, BCD Output: %b", binary_input, bcd_output);
    
    // Test case 2: Maximum input value (31 in binary)
    binary_input = 5'b11111;
    #10;
    $display("Binary Input: %b, BCD Output: %b", binary_input, bcd_output);
    
    // Test case 3: Input value with all bits set to 1 (31 in binary)
    binary_input = 5'b11111;
    #10;
    $display("Binary Input: %b, BCD Output: %b", binary_input, bcd_output);
    
    // Test case 4: Input value with all bits set to 0 (0 in binary)
    binary_input = 5'b00000;
    #10;
    $display("Binary Input: %b, BCD Output: %b", binary_input, bcd_output);
    
    // Test case 5: Random input value
    binary_input = $random;
    #10;
    $display("Binary Input: %b, BCD Output: %b", binary_input, bcd_output);
    
    // End simulation
    $finish;
  end
  
  // Clock driver
  always #((CLK_PERIOD)/2) clk = ~clk;
  
endmodule
