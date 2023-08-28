module testbench;
  // Parameters
  parameter CLK_PERIOD = 10; // Clock period in ns

  // Signals
  reg clk;
  reg reset;
  reg A;
  reg B;
  wire O;
  wire [3:0] state;

  // Instantiate ABRO module
  abro abro (
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

  // Stimulus generator
  initial begin
    // Test case 1: A and B not entered in required order
    A = 1;
    B = 1;
    #((CLK_PERIOD)*10);
    A = 0;
    B = 0;
    #((CLK_PERIOD)*10);

    // Test case 2: A entered before B
    A = 1;
    #((CLK_PERIOD)*10);
    A = 0;
    #((CLK_PERIOD)*10);
    B = 1;
    #((CLK_PERIOD)*10);
    B = 0;
    #((CLK_PERIOD)*10);

    // Test case 3: B entered before A
    B = 1;
    #((CLK_PERIOD)*10);
    B = 0;
    #((CLK_PERIOD)*10);
    A = 1;
    #((CLK_PERIOD)*10);
    A = 0;
    #((CLK_PERIOD)*10);

    // Test case 4: A and B entered simultaneously
    A = 1;
    B = 1;
    #((CLK_PERIOD)*10);
    A = 0;
    B = 0;
    #((CLK_PERIOD)*10);

    // Test case 5: Active-low reset triggered
    reset = 1;
    #((CLK_PERIOD)*10);
    reset = 0;
    #((CLK_PERIOD)*10);
  end

  // Display statements for verification
  always @(posedge clk) begin
    $display("A = %b, B = %b, O = %b, State = %b", A, B, O, state);
  end

  // Stop simulation after all test cases are executed
  initial begin
    #((CLK_PERIOD)*100);
    $finish;
  end
endmodule
