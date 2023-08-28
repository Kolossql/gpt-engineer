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
    // Test case 1: Initial state where A and B are not entered
    #((CLK_PERIOD)*10) A = 0; B = 0;
    
    // Test case 2: State transition when A is entered before B
    #((CLK_PERIOD)*10) A = 1; B = 0;
    
    // Test case 3: State transition when B is entered before A
    #((CLK_PERIOD)*10) A = 0; B = 1;
    
    // Test case 4: State transition when A and B are entered in the required order
    #((CLK_PERIOD)*10) A = 1; B = 1;
    
    // Test case 5: State transition when A and B are entered in the required order multiple times
    #((CLK_PERIOD)*10) A = 1; B = 1;
    #((CLK_PERIOD)*10) A = 0; B = 0;
    #((CLK_PERIOD)*10) A = 1; B = 1;
    #((CLK_PERIOD)*10) A = 0; B = 0;
    #((CLK_PERIOD)*10) A = 1; B = 1;
  end
  
endmodule
