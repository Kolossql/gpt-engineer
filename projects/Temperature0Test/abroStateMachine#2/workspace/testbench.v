module testbench;
  
  // Parameters
  parameter CLK_PERIOD = 10; // Clock period in ns
  
  // Signals
  reg clk;
  reg reset;
  reg A;
  reg B;
  wire O;
  wire [1:0] state;
  
  // Instantiate ABRO module
  ABRO abro (
    .clk(clk),
    .reset(reset),
    .A(A),
    .B(B),
    .O(O),
    .state(state)
  );
  
  // Clock generator
  always #((CLK_PERIOD)/2) clk = ~clk;
  
  // Reset generator
  initial begin
    reset = 1;
    #((CLK_PERIOD)*2) reset = 0;
  end
  
  // Test cases
  initial begin
    // Case 1: Initial state (A and B not entered)
    A = 0;
    B = 0;
    #((CLK_PERIOD)*5);
    $display("Case 1: A=0, B=0, O=%b, state=%b", O, state);
    
    // Case 2: A entered before B
    A = 1;
    B = 0;
    #((CLK_PERIOD)*5);
    $display("Case 2: A=1, B=0, O=%b, state=%b", O, state);
    
    // Case 3: B entered before A
    A = 0;
    B = 1;
    #((CLK_PERIOD)*5);
    $display("Case 3: A=0, B=1, O=%b, state=%b", O, state);
    
    // Case 4: A and B entered simultaneously
    A = 1;
    B = 1;
    #((CLK_PERIOD)*5);
    $display("Case 4: A=1, B=1, O=%b, state=%b", O, state);
    
    // Case 5: Active-low reset triggered
    reset = 1;
    #((CLK_PERIOD)*5);
    $display("Case 5: Reset triggered, O=%b, state=%b", O, state);
    
    $finish;
  end
  
endmodule
