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
    .a(a),
    .b(b),
    .o(o),
    .state(state)
  );
  
  // Clock generation
  always #((CLK_PERIOD)/2) clk = ~clk;
  
  // Test stimulus
  initial begin
    // Case 1: A and B are both high before the active-low reset is released
    reset = 0;
    a = 1;
    b = 1;
    #10;
    reset = 1;
    #10;
    reset = 0;
    #10;
    a = 0;
    b = 0;
    #10;
    
    // Case 2: A and B are both low before the active-low reset is released
    reset = 0;
    a = 0;
    b = 0;
    #10;
    reset = 1;
    #10;
    reset = 0;
    #10;
    a = 1;
    b = 1;
    #10;
    
    // Case 3: A is high before the active-low reset is released, but B remains low
    reset = 0;
    a = 1;
    b = 0;
    #10;
    reset = 1;
    #10;
    reset = 0;
    #10;
    a = 0;
    b = 0;
    #10;
    
    // Case 4: B is high before the active-low reset is released, but A remains low
    reset = 0;
    a = 0;
    b = 1;
    #10;
    reset = 1;
    #10;
    reset = 0;
    #10;
    a = 0;
    b = 0;
    #10;
    
    // Case 5: A and B transition from low to high after the active-low reset is released
    reset = 0;
    a = 0;
    b = 0;
    #10;
    reset = 1;
    #10;
    reset = 0;
    #10;
    a = 1;
    b = 0;
    #10;
    a = 0;
    b = 1;
    #10;
    a = 1;
    b = 1;
    #10;
    a = 0;
    b = 0;
    #10;
    
    $finish;
  end
  
endmodule
