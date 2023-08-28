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
  ABRO_StateMachine dut (
    .clk(clk),
    .reset(reset),
    .a(a),
    .b(b),
    .o(o),
    .state(state)
  );

  // Clock generator
  always #((CLK_PERIOD)/2) clk = ~clk;

  // Stimulus generator
  initial begin
    // Test case 1: Initial state
    reset = 1;
    a = 0;
    b = 0;
    #10;
    reset = 0;
    #20;

    // Test case 2: Single input
    reset = 1;
    a = 1;
    b = 0;
    #10;
    reset = 0;
    #20;

    // Test case 3: Both inputs in different order
    reset = 1;
    a = 0;
    b = 1;
    #10;
    reset = 0;
    #20;

    // Test case 4: Multiple inputs
    reset = 1;
    a = 1;
    b = 0;
    #10;
    a = 0;
    b = 1;
    #10;
    a = 1;
    b = 1;
    #10;
    reset = 0;
    #20;

    // Test case 5: Output and reset
    reset = 1;
    a = 1;
    b = 1;
    #10;
    reset = 0;
    #20;
  end

  // Monitor
  always @(posedge clk) begin
    $display("Output: %b, State: %b", o, state);
  end

endmodule
