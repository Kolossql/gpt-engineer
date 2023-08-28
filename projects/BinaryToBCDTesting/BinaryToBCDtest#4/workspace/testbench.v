module testbench;
  
  // Inputs
  reg [7:0] binary_input;
  
  // Outputs
  wire [11:0] bcd_output;
  
  // Instantiate the module under test
  binary_to_bcd_converter dut (
    .binary_input(binary_input),
    .bcd_output(bcd_output)
  );
  
  // Clock generation
  reg clk;
  always #5 clk = ~clk;
  
  // Stimulus generation
  initial begin
    $dumpfile("WaveOutput.vcd");
    $dumpvars(1, testbench);
    
    // Initialize inputs
    binary_input = 0;
    
    // Apply stimulus
    #10 binary_input = 0; // Minimum input value (0)
    #10 binary_input = 255; // Maximum input value (255)
    #10 binary_input = 123; // Random input value
    #10 binary_input = 42; // Input value with leading zeros
    #10 binary_input = 255; // Input value with all ones
    
    // Finish simulation
    #10 $finish;
  end
  
  // Display output BCD values
  always @(posedge clk) begin
    $display("Binary Input: %b, BCD Output: %b", binary_input, bcd_output);
  end
  
endmodule
