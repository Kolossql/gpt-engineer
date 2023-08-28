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
    .clock(clk),
    .reset(reset),
    .data(data),
    .sequence_found(sequence_found)
  );

  // Clock generation
  always #((CLK_PERIOD)/2) clk = ~clk;

  // Test stimulus
  initial begin
    // Initialize inputs
    reset = 1;
    data = 0;

    // Wait for a few clock cycles
    #((CLK_PERIOD)*10);

    // Deassert reset
    reset = 0;

    // Test case 1: Sequence is found
    #((CLK_PERIOD)*10);
    data = 3'b001;
    #((CLK_PERIOD)*10);
    data = 3'b101;
    #((CLK_PERIOD)*10);
    data = 3'b110;
    #((CLK_PERIOD)*10);
    data = 3'b000;
    #((CLK_PERIOD)*10);
    data = 3'b110;
    #((CLK_PERIOD)*10);
    data = 3'b110;
    #((CLK_PERIOD)*10);
    data = 3'b011;
    #((CLK_PERIOD)*10);
    data = 3'b101;
    #((CLK_PERIOD)*10);

    // Test case 2: Sequence is not found
    data = 3'b000;
    #((CLK_PERIOD)*10);
    data = 3'b001;
    #((CLK_PERIOD)*10);
    data = 3'b010;
    #((CLK_PERIOD)*10);
    data = 3'b011;
    #((CLK_PERIOD)*10);

    // Test case 3: Partial sequence is found
    data = 3'b001;
    #((CLK_PERIOD)*10);
    data = 3'b101;
    #((CLK_PERIOD)*10);
    data = 3'b010;
    #((CLK_PERIOD)*10);
    data = 3'b011;
    #((CLK_PERIOD)*10);

    // Test case 4: Sequence is found multiple times
    data = 3'b001;
    #((CLK_PERIOD)*10);
    data = 3'b101;
    #((CLK_PERIOD)*10);
    data = 3'b110;
    #((CLK_PERIOD)*10);
    data = 3'b000;
    #((CLK_PERIOD)*10);
    data = 3'b110;
    #((CLK_PERIOD)*10);
    data = 3'b110;
    #((CLK_PERIOD)*10);
    data = 3'b011;
    #((CLK_PERIOD)*10);
    data = 3'b101;
    #((CLK_PERIOD)*10);
    data = 3'b001;
    #((CLK_PERIOD)*10);
    data = 3'b101;
    #((CLK_PERIOD)*10);
    data = 3'b110;
    #((CLK_PERIOD)*10);
    data = 3'b000;
    #((CLK_PERIOD)*10);
    data = 3'b110;
    #((CLK_PERIOD)*10);
    data = 3'b110;
    #((CLK_PERIOD)*10);
    data = 3'b011;
    #((CLK_PERIOD)*10);
    data = 3'b101;
    #((CLK_PERIOD)*10);

    // Test case 5: Different input sequences
    data = 3'b001;
    #((CLK_PERIOD)*10);
    data = 3'b101;
    #((CLK_PERIOD)*10);
    data = 3'b110;
    #((CLK_PERIOD)*10);
    data = 3'b000;
    #((CLK_PERIOD)*10);
    data = 3'b110;
    #((CLK_PERIOD)*10);
    data = 3'b110;
    #((CLK_PERIOD)*10);
    data = 3'b011;
    #((CLK_PERIOD)*10);
    data = 3'b101;
    #((CLK_PERIOD)*10);
    data = 3'b010;
    #((CLK_PERIOD)*10);
    data = 3'b110;
    #((CLK_PERIOD)*10);
    data = 3'b011;
    #((CLK_PERIOD)*10);
    data = 3'b101;
    #((CLK_PERIOD)*10);
    data = 3'b001;
    #((CLK_PERIOD)*10);
    data = 3'b101;
    #((CLK_PERIOD)*10);
    data = 3'b110;
    #((CLK_PERIOD)*10);
    data = 3'b000;
    #((CLK_PERIOD)*10);
    data = 3'b110;
    #((CLK_PERIOD)*10);
    data = 3'b110;
    #((CLK_PERIOD)*10);
    data = 3'b011;
    #((CLK_PERIOD)*10);
    data = 3'b101;
    #((CLK_PERIOD)*10);

    // End simulation
    $finish;
  end

endmodule
