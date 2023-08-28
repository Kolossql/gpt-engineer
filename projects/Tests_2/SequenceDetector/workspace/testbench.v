module testbench;
  
  // Parameters
  parameter CLK_PERIOD = 10; // Clock period in ns
  
  // Inputs
  reg clk;
  reg reset;
  reg [2:0] data;
  
  // Outputs
  wire sequence_found;
  
  // Instantiate the sequence detector module
  SequenceDetector dut (
    .clk(clk),
    .reset(reset),
    .data(data),
    .sequence_found(sequence_found)
  );
  
  // Clock generation
  always #((CLK_PERIOD)/2) clk = ~clk;
  
  // Test cases
  initial begin
    // Initialize inputs
    reset = 1;
    data = 0;
    
    // Wait for a few clock cycles
    #((CLK_PERIOD)*5);
    
    // Deassert reset
    reset = 0;
    
    // Test case 1: Valid sequence detection
    data = 3'b001;
    #((CLK_PERIOD)*5);
    $display("Test case 1: Sequence found = %b", sequence_found);
    
    // Test case 2: Invalid sequence detection
    data = 3'b010;
    #((CLK_PERIOD)*5);
    $display("Test case 2: Sequence found = %b", sequence_found);
    
    // Test case 3: Sequence with incorrect order detection
    data = 3'b100;
    #((CLK_PERIOD)*5);
    $display("Test case 3: Sequence found = %b", sequence_found);
    
    // Test case 4: Sequence with additional elements detection
    data = 3'b001;
    #((CLK_PERIOD)*5);
    $display("Test case 4: Sequence found = %b", sequence_found);
    
    // Test case 5: Active-low reset functionality
    reset = 1;
    #((CLK_PERIOD)*5);
    $display("Test case 5: Sequence found = %b", sequence_found);
    
    reset = 0;
    data = 3'b001;
    #((CLK_PERIOD)*5);
    $display("Test case 5: Sequence found = %b", sequence_found);
    
    reset = 1;
    #((CLK_PERIOD)*5);
    $display("Test case 5: Sequence found = %b", sequence_found);
    
    $finish;
  end
  
endmodule
