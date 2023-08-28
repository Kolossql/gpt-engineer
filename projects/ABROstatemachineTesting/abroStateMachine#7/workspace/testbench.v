module testbench;

  // Parameters
  parameter CLK_PERIOD = 10; // Clock period in ns

  // Signals
  reg clk;
  reg reset;
  reg A;
  reg B;
  wire O;
  wire [1:0] State;
  wire [3:0] CurrentState;

  // Instantiate ABRO module
  ABRO_StateMachine abro (
    .clk(clk),
    .reset(reset),
    .A(A),
    .B(B),
    .O(O),
    .State(State)
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
    A = 0;
    B = 0;
    #((CLK_PERIOD)*10);
    
    // Test case 2: A before B
    A = 1;
    B = 0;
    #((CLK_PERIOD)*10);
    
    // Test case 3: B before A
    A = 0;
    B = 1;
    #((CLK_PERIOD)*10);
    
    // Test case 4: A and B in correct order
    A = 1;
    B = 1;
    #((CLK_PERIOD)*10);
    
    // Test case 5: A and B in incorrect order
    A = 1;
    B = 0;
    #((CLK_PERIOD)*10);
    
    $finish;
  end

  // Monitor
  always @(posedge clk) begin
    $display("O = %b, State = %b, CurrentState = %b", O, State, CurrentState);
  end

endmodule
