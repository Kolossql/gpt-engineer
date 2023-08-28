module testbench;

  // Parameters
  parameter CLK_PERIOD = 10; // Clock period in ns

  // Inputs
  reg clk;
  reg reset;
  reg [2:0] data;

  // Outputs
  wire sequence_found;

  // Instantiate the sequence detector module
  sequence_detector dut (
    .clk(clk),
    .reset(reset),
    .data(data),
    .sequence_found(sequence_found)
  );

  // Clock generation
  always #((CLK_PERIOD)/2) clk = ~clk;

  // Stimulus generation
  initial begin
    // Initialize inputs
    reset = 1;
    data = 3'b000;

    // Wait for a few clock cycles
    #((CLK_PERIOD)*10);

    // Deassert reset
    reset = 0;

    // Test case 1: Initial state
    #((CLK_PERIOD)*10);
    $display("Test Case 1: Initial state");
    $display("Sequence Found: %b", sequence_found);

    // Test case 2: Sequence at the beginning
    #((CLK_PERIOD)*10);
    $display("Test Case 2: Sequence at the beginning");
    data = 3'b001;
    #((CLK_PERIOD)*10);
    $display("Sequence Found: %b", sequence_found);

    // Test case 3: Sequence in the middle
    #((CLK_PERIOD)*10);
    $display("Test Case 3: Sequence in the middle");
    data = 3'b101;
    #((CLK_PERIOD)*10);
    $display("Sequence Found: %b", sequence_found);

    // Test case 4: Sequence at the end
    #((CLK_PERIOD)*10);
    $display("Test Case 4: Sequence at the end");
    data = 3'b011;
    #((CLK_PERIOD)*10);
    $display("Sequence Found: %b", sequence_found);

    // Test case 5: Non-detection of sequence
    #((CLK_PERIOD)*10);
    $display("Test Case 5: Non-detection of sequence");
    data = 3'b111;
    #((CLK_PERIOD)*10);
    $display("Sequence Found: %b", sequence_found);

    // End simulation
    $finish;
  end

endmodule
