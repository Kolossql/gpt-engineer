module testbench;

  // Inputs
  reg [7:0] binary_input;
  
  // Outputs
  wire [11:0] bcd_output;
  
      reg [11:0] expected_bcd_output [5:1];

  // Instantiate the binary to BCD converter module
  binary_to_bcd_converter dut (
    .clk(clk),
    .binary_input(binary_input),
    .bcd_output(bcd_output)
  );
  
  // Clock signal generation
  reg clk;
  always #5 clk = ~clk;
  
  // Stimulus generation
  initial begin
    // Initialize inputs
    binary_input = 0;
    
    // Apply stimulus
    #10 binary_input = 0; // Test case 1: Minimum input value (0)
    #10 binary_input = 255; // Test case 2: Maximum input value (255)
    #10 binary_input = 42; // Test case 3: Random input value
    #10 binary_input = 6; // Test case 4: Input value with leading zeros
    #10 binary_input = 255; // Test case 5: Input value with all ones
    
    // Finish simulation
    #10 $finish;
  end
  
  // Monitor outputs and verify correctness
  always @(posedge clk) begin
    // Expected BCD values for the test cases
    
    expected_bcd_output[1] <= 12'b000000000000; // Expected BCD output for test case 1
    expected_bcd_output[2] <= 12'b000000000111; // Expected BCD output for test case 2
    expected_bcd_output[3] <= 12'b000000010010; // Expected BCD output for test case 3
    expected_bcd_output[4] <= 12'b000000000110; // Expected BCD output for test case 4
    expected_bcd_output[5] <= 12'b000000000111;  // Expected BCD output for test case 5
  
    
    // Verify correctness of the BCD output
    #20
    if (bcd_output === expected_bcd_output[1]) begin
      $display("Test case 1: Passed");
    end else begin
      $display("Test case 1: Failed");
    end
    #20
    if (bcd_output === expected_bcd_output[2]) begin
      $display("Test case 2: Passed");
    end else begin
      $display("Test case 2: Failed");
    end
    #20
    if (bcd_output === expected_bcd_output[3]) begin
      $display("Test case 3: Passed");
    end else begin
      $display("Test case 3: Failed");
    end
    #20
    if (bcd_output === expected_bcd_output[4]) begin
      $display("Test case 4: Passed");
    end else begin
      $display("Test case 4: Failed");
    end
    #20
    if (bcd_output === expected_bcd_output[5]) begin
      $display("Test case 5: Passed");
    end else begin
      $display("Test case 5: Failed");
    end
  end
  
  // Dump waveform for visualization
  initial begin
    $dumpfile("WaveOutput.vcd");
    $dumpvars(0, testbench);
  end
  
endmodule
