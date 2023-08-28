module testbench;
  
  // Parameters
  parameter CLK_PERIOD = 10; // Clock period in ns
  
  // Inputs
  reg clk;
  reg reset;
  reg enable;
  
  // Outputs
  wire [7:0] data;
  
  // Instantiate the sequence generator module
  sequence_generator dut (
    .clk(clk),
    .reset(reset),
    .enable(enable),
    .data(data)
  );
  
  // Clock generation
  always begin
    clk = 0;
    #((CLK_PERIOD)/2);
    clk = 1;
    #((CLK_PERIOD)/2);
  end
  
  // Reset generation
  initial begin
    reset = 1;
    #10;
    reset = 0;
  end
  
  // Test cases
  initial begin
    // Test initial state
    #10;
    $display("Test Case 1: Initial State");
    $display("Expected Output: 0xAF");
    $display("Actual Output: %h", data);
    
    // Test active-low reset
    #10;
    $display("Test Case 2: Active-Low Reset");
    $display("Expected Output: 0xAF");
    $display("Actual Output: %h", data);
    reset = 1;
    #10;
    reset = 0;
    #10;
    $display("Expected Output: 0xAF");
    $display("Actual Output: %h", data);
    
    // Test enable signal low
    #10;
    $display("Test Case 3: Enable Signal Low");
    $display("Expected Output: No output");
    $display("Actual Output: %h", data);
    enable = 0;
    #10;
    $display("Expected Output: No output");
    $display("Actual Output: %h", data);
    
    // Test sequence generation
    #10;
    $display("Test Case 4: Sequence Generation");
    $display("Expected Output: 0xBC");
    $display("Actual Output: %h", data);
    #10;
    $display("Expected Output: 0xE2");
    $display("Actual Output: %h", data);
    #10;
    $display("Expected Output: 0x78");
    $display("Actual Output: %h", data);
    
    // Test sequence repetition
    #10;
    $display("Test Case 5: Sequence Repetition");
    $display("Expected Output: 0xFF");
    $display("Actual Output: %h", data);
    #10;
    $display("Expected Output: 0xE2");
    $display("Actual Output: %h", data);
    #10;
    $display("Expected Output: 0x0B");
    $display("Actual Output: %h", data);
    #10;
    $display("Expected Output: 0x8D");
    $display("Actual Output: %h", data);
    #10;
    $display("Expected Output: 0xAF");
    $display("Actual Output: %h", data);
  end
  
  // Stop simulation
  initial begin
    #100;
    $finish;
  end
  
endmodule
