module testbench;
  // Parameters
  parameter CLK_PERIOD = 10; // Clock period in ns

  // Signals
  reg clk;
  reg reset;
  reg A;
  reg B;
  wire O;
  wire [1:0] CurrentState;

  // Instantiate ABRO module
  ABRO abro (
    .clk(clk),
    .reset(reset),
    .A(A),
    .B(B),
    .O(O),
    .State(CurrentState)
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
    #((CLK_PERIOD)*5);
    $display("Test case 1: Initial state");
    $display("A = %b, B = %b, O = %b, CurrentState = %b", A, B, O, CurrentState);
    $display("");

    // Test case 2: A entered before B
    A = 1;
    B = 0;
    #((CLK_PERIOD)*5);
    $display("Test case 2: A entered before B");
    $display("A = %b, B = %b, O = %b, CurrentState = %b", A, B, O, CurrentState);
    $display("");

    // Test case 3: B entered before A
    A = 0;
    B = 1;
    #((CLK_PERIOD)*5);
    $display("Test case 3: B entered before A");
    $display("A = %b, B = %b, O = %b, CurrentState = %b", A, B, O, CurrentState);
    $display("");

    // Test case 4: A and B entered simultaneously
    A = 1;
    B = 1;
    #((CLK_PERIOD)*5);
    $display("Test case 4: A and B entered simultaneously");
    $display("A = %b, B = %b, O = %b, CurrentState = %b", A, B, O, CurrentState);
    $display("");

    // Test case 5: Active-low reset triggered
    reset = 1;
    #((CLK_PERIOD)*5);
    $display("Test case 5: Active-low reset triggered");
    $display("A = %b, B = %b, O = %b, CurrentState = %b", A, B, O, CurrentState);
    $display("");

    $finish;
  end

  // Output monitor
  always @(posedge clk) begin
    $display("A = %b, B = %b, O = %b, CurrentState = %b", A, B, O, CurrentState);
  end
endmodule
