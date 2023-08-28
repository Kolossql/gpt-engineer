module testbench;
  
  // Parameters
  parameter CLOCK_PERIOD = 20; // Clock period in ns
  
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
  always #((CLOCK_PERIOD)/2) clk = ~clk;
  
  // Initial state
  initial begin
    clk = 0;
    reset = 1;
    #10;
    reset = 0;
    #10;
    
    // Test initial state
    $display("Initial State Test:");
    $display("Expected Output: 10001010");
    $display("Actual Output: %b", data_out);
    $display("");
    
    // Test clock signal
    $display("Clock Signal Test:");
    $display("Clock Period: %d ns", CLOCK_PERIOD);
    #100;
    
    // Test reset signal
    $display("Reset Signal Test:");
    reset = 1;
    #50;
    reset = 0;
    #100;
    
    // Test taps
    $display("Taps Test:");
    $display("Expected Output: 10001010");
    $display("Actual Output: %b", data_out);
    #100;
    
    // Test output sequence
    $display("Output Sequence Test:");
    $display("Output for 10 clock cycles:");
    repeat (10) begin
      #CLOCK_PERIOD;
      $display("%b", data_out);
    end
    
    // End simulation
    $finish;
  end
  
endmodule
