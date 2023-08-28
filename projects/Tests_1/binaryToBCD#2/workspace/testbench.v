module testbench;

  // Inputs
  reg [4:0] binary_input;
  
  // Outputs
  wire [7:0] bcd_output;
  
  // Instantiate the module under test
  binary_to_bcd dut (
    .binary_input(binary_input),
    .bcd_output(bcd_output)
  );
  
  // Clock generation
  reg clk;
  always #5 clk = ~clk;
  
  // Stimulus generation
  initial begin
    clk = 0;
    binary_input = 5'b00000; // Test case 1: Input binary number 0
    #10;
    binary_input = 5'b11111; // Test case 2: Input binary number 31
    #10;
    binary_input = 5'b11111; // Test case 3: Input binary number with all bits set to 1
    #10;
    binary_input = 5'b00000; // Test case 4: Input binary number with all bits set to 0
    #10;
    binary_input = 5'b10101; // Test case 5: Random input binary number
    #10;
    $finish;
  end
  
  // Monitor the outputs and compare with expected values
  always @(posedge clk) begin
    $display("Binary Input: %b, BCD Output: %b", binary_input, bcd_output);
    // Add assertions to compare the bcd_output with expected values
    // For example:
    // assert (bcd_output == 8'b00000000) else $error("Test case 1 failed");
    // assert (bcd_output == 8'b00000001) else $error("Test case 2 failed");
    // assert (bcd_output == 8'b00000010) else $error("Test case 3 failed");
    // assert (bcd_output == 8'b00000011) else $error("Test case 4 failed");
    // assert (bcd_output == 8'b00000101) else $error("Test case 5 failed");
  end
  
endmodule
