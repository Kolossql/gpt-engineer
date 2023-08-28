module testbench;
  
  // Parameters
  parameter CLK_PERIOD = 10; // Clock period in ns
  
  // Signals
  reg clk;
  reg reset;
  reg a;
  reg b;
  wire o;
  wire [3:0] state;
  
  // Instantiate ABRO state machine module
  ABRO_StateMachine uut (
    .clk(clk),
    .reset_n(reset),
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
    // Test case 1: A and B inputs are entered in the correct order and the output state is reached
    a = 1;
    b = 1;
    #((CLK_PERIOD)*4) a = 0;
    #((CLK_PERIOD)*4) b = 0;
    
    // Test case 2: A and B inputs are entered in the incorrect order and the output state is not reached
    a = 1;
    b = 0;
    #((CLK_PERIOD)*4) a = 0;
    #((CLK_PERIOD)*4) b = 1;
    
    // Test case 3: A and B inputs are entered in the correct order, but the active-low reset signal is asserted before the output state is reached
    a = 1;
    b = 1;
    #((CLK_PERIOD)*2) reset = 1;
    #((CLK_PERIOD)*2) reset = 0;
    #((CLK_PERIOD)*4) a = 0;
    #((CLK_PERIOD)*4) b = 0;
    
    // Test case 4: A and B inputs are entered in the correct order, but the active-low reset signal is asserted after the output state is reached
    a = 1;
    b = 1;
    #((CLK_PERIOD)*4) a = 0;
    #((CLK_PERIOD)*4) b = 0;
    #((CLK_PERIOD)*2) reset = 1;
    #((CLK_PERIOD)*2) reset = 0;
    
    // Test case 5: A and B inputs are entered in the correct order, but the clock signal is not provided
    a = 1;
    b = 1;
    #((CLK_PERIOD)*4) a = 0;
    #((CLK_PERIOD)*4) b = 0;
    #((CLK_PERIOD)*4) $finish;
  end
  
  // Monitor
  always @(posedge clk) begin
    $display("Output: %b, State: %b", o, state);
  end
  
endmodule
