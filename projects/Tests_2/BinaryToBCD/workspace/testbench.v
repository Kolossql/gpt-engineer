module testbench;
  
  // Inputs
  reg [4:0] binary_input;
  
  // Outputs
  wire [7:0] bcd_output;
  
  // Instantiate the DUT
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
    binary_input = 5'b00000; // Test case 1: Input value 0
    #10;
    
    binary_input = 5'b11111; // Test case 2: Input value 31
    #10;
    
    binary_input = 5'b11111; // Test case 3: Input value with all bits set to 1
    #10;
    
    binary_input = 5'b00000; // Test case 4: Input value with all bits set to 0
    #10;
    
    binary_input = 5'b10101; // Test case 5: Random input value
    #10;
    
    $finish;
  end
  
  // Monitor
  always @(posedge clk) begin
    $display("Binary Input: %b", binary_input);
    $display("BCD Output: %b", bcd_output);
  end
  
endmodule
