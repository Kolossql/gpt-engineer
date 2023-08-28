module testbench;
  
  // Parameters
  parameter CLK_PERIOD = 10; // Clock period in ns
  
  // Signals
  reg clk;
  reg reset;
  reg a;
  reg b;
  wire o;
  wire [1:0] state;
  
  // Instantiate ABRO state machine module
  abro_state_machine dut (
    .clk(clk),
    .reset(reset),
    .A(a),
    .B(b),
    .O(o),
    .state(state)
  );
  
  // Clock generator
  always #((CLK_PERIOD)/2) clk = ~clk;
  
  // Reset generator
  initial begin
    reset = 1;
    #((CLK_PERIOD)*2) reset = 0;
  end
  
  // Stimulus generator
  initial begin
    // Test case 1: Initial state
    #((CLK_PERIOD)*5) a = 0; b = 0;
    
    // Test case 2: Single input
    #((CLK_PERIOD)*5) a = 1; b = 0;
    #((CLK_PERIOD)*5) a = 0; b = 1;
    
    // Test case 3: Both inputs entered
    #((CLK_PERIOD)*5) a = 1; b = 1;
    
    // Test case 4: Reset
    #((CLK_PERIOD)*5) reset = 1;
    #((CLK_PERIOD)*5) reset = 0;
    
    // Test case 5: State transition
    #((CLK_PERIOD)*5) a = 1; b = 0;
    #((CLK_PERIOD)*5) a = 0; b = 1;
    #((CLK_PERIOD)*5) a = 1; b = 1;
    $finish
  end
  
  // Output monitor
  always @(posedge clk) begin
    $display("Output: %b, State: %b", o, state);
  end
  
endmodule
