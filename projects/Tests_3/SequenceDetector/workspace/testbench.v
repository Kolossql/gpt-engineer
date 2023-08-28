module testbench;
  
  // Parameters
  parameter CLK_PERIOD = 10;
  
  // Inputs
  reg clk;
  reg reset;
  reg [2:0] data;
  
  // Outputs
  wire sequence_found;
  
  // Instantiate the sequence detector module
  sequence_detector dut (
    .clk(clk),
    .rst_n(reset),
    .data(data),
    .seq_found(sequence_found)
  );
  
  // Clock generation
  always begin
    clk = 0;
    #(CLK_PERIOD/2);
    clk = 1;
    #(CLK_PERIOD/2);
  end
  
  // Reset generation
  initial begin
    reset = 1;
    #CLK_PERIOD;
    reset = 0;
  end
  
  // Test cases
  initial begin
    // Test case 1: Minimum input values
    data = 3'b001;
    #(CLK_PERIOD*10);
    if (sequence_found)
      $display("Test case 1: Passed");
    else
      $display("Test case 1: Failed");
    
    // Test case 2: Maximum input values
    data = 3'b101;
    #(CLK_PERIOD*10);
    if (sequence_found)
      $display("Test case 2: Passed");
    else
      $display("Test case 2: Failed");
    
    // Test case 3: Sequence not present
    data = 3'b111;
    #(CLK_PERIOD*10);
    if (!sequence_found)
      $display("Test case 3: Passed");
    else
      $display("Test case 3: Failed");
    
    // Test case 4: Overlapping sequences
    data = 3'b001;
    #(CLK_PERIOD*10);
    if (!sequence_found)
      $display("Test case 4: Passed");
    else
      $display("Test case 4: Failed");
    
    data = 3'b101;
    #(CLK_PERIOD*10);
    if (sequence_found)
      $display("Test case 4: Passed");
    else
      $display("Test case 4: Failed");
    
    // Test case 5: Multiple sequences in a row
    data = 3'b001;
    #(CLK_PERIOD*10);
    if (sequence_found)
      $display("Test case 5: Passed");
    else
      $display("Test case 5: Failed");
    
    data = 3'b101;
    #(CLK_PERIOD*10);
    if (sequence_found)
      $display("Test case 5: Passed");
    else
      $display("Test case 5: Failed");
    
    data = 3'b110;
    #(CLK_PERIOD*10);
    if (sequence_found)
      $display("Test case 5: Passed");
    else
      $display("Test case 5: Failed");
  end
  
  // Dump waveform for GTKWave
  initial begin
    $dumpfile("WaveOutput.vcd");
    $dumpvars(0, testbench);
  end
  
endmodule
