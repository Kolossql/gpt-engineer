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
  
  // Stimulus generation
  initial begin
    clk = 0;
    binary_input = 5'b00000; // Test case 1: Input value of 0
    #10;
    
    binary_input = 5'b11111; // Test case 2: Input value of 31
    #10;
    
    binary_input = 5'b00011; // Test case 3: Input value with leading zeros
    #10;
    
    binary_input = 5'b11100; // Test case 4: Input value with leading ones
    #10;
    
    binary_input = 5'b01010; // Test case 5: Random input value
    #10;
    
    $finish;
  end
  
  // Display statements for verification
  always @(posedge clk) begin
    $display("Binary Input: %b", binary_input);
    $display("BCD Output: %b", bcd_output);
  end
  
endmodule
