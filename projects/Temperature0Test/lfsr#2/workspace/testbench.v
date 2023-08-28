module testbench;
  
  // Parameters
  parameter CLK_PERIOD = 10; // Clock period in ns
  
  // Signals
  reg clk;
  reg reset;
  wire [7:0] data_out;
  
  // Instantiate LFSR module
  LFSR lfsr (
    .clk(clk),
    .reset(reset),
    .data_out(data_out)
  );
  
  // Clock generation
  always begin
    #CLK_PERIOD/2 clk = ~clk;
  end
  
  // Reset generation
  initial begin
    reset = 1;
    #10 reset = 0;
  end
  
  // Monitor output
  always @(posedge clk) begin
    $display("Data Out: %b", data_out);
  end
  
  // Test cases
  initial begin
    // Case 1: Initial state
    $display("Test Case 1: Initial state");
    #10;
    
    // Case 2: Clock edge
    $display("Test Case 2: Clock edge");
    #CLK_PERIOD;
    
    // Case 3: Active-low reset
    $display("Test Case 3: Active-low reset");
    reset = 1;
    #CLK_PERIOD;
    reset = 0;
    #CLK_PERIOD;
    
    // Case 4: Output data
    $display("Test Case 4: Output data");
    #CLK_PERIOD;
    
    // Case 5: Continuous operation
    $display("Test Case 5: Continuous operation");
    #CLK_PERIOD * 10;
    
    // End simulation
    $finish;
  end
  
endmodule
