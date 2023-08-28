module testbench;
  
  // Parameters
  parameter CLK_PERIOD = 10; // Clock period in ns
  
  // Inputs
  reg clk;
  reg reset;
  reg [2:0] data;
  
  // Outputs
  wire sequence_found;
  
  // Instantiate sequence detector module
  sequence_detector dut (
    .clk(clk),
    .reset(reset),
    .data(data),
    .sequence_found(sequence_found)
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
    // Test case 1: Sequence occurs at the beginning
    #((CLK_PERIOD)*2) data = 3'b001;
    #((CLK_PERIOD)*2) data = 3'b101;
    #((CLK_PERIOD)*2) data = 3'b110;
    #((CLK_PERIOD)*2) data = 3'b000;
    #((CLK_PERIOD)*2) data = 3'b110;
    #((CLK_PERIOD)*2) data = 3'b110;
    #((CLK_PERIOD)*2) data = 3'b011;
    #((CLK_PERIOD)*2) data = 3'b101;
    
    // Test case 2: Sequence occurs in the middle
    #((CLK_PERIOD)*2) data = 3'b111;
    #((CLK_PERIOD)*2) data = 3'b001;
    #((CLK_PERIOD)*2) data = 3'b101;
    #((CLK_PERIOD)*2) data = 3'b110;
    #((CLK_PERIOD)*2) data = 3'b000;
    #((CLK_PERIOD)*2) data = 3'b110;
    #((CLK_PERIOD)*2) data = 3'b110;
    #((CLK_PERIOD)*2) data = 3'b011;
    #((CLK_PERIOD)*2) data = 3'b101;
    
    // Test case 3: Sequence occurs at the end
    #((CLK_PERIOD)*2) data = 3'b111;
    #((CLK_PERIOD)*2) data = 3'b001;
    #((CLK_PERIOD)*2) data = 3'b101;
    #((CLK_PERIOD)*2) data = 3'b110;
    #((CLK_PERIOD)*2) data = 3'b000;
    #((CLK_PERIOD)*2) data = 3'b110;
    #((CLK_PERIOD)*2) data = 3'b110;
    #((CLK_PERIOD)*2) data = 3'b011;
    #((CLK_PERIOD)*2) data = 3'b101;
    #((CLK_PERIOD)*2) data = 3'b001;
    #((CLK_PERIOD)*2) data = 3'b101;
    #((CLK_PERIOD)*2) data = 3'b110;
    
    // Test case 4: Sequence occurs multiple times
    #((CLK_PERIOD)*2) data = 3'b001;
    #((CLK_PERIOD)*2) data = 3'b101;
    #((CLK_PERIOD)*2) data = 3'b110;
    #((CLK_PERIOD)*2) data = 3'b000;
    #((CLK_PERIOD)*2) data = 3'b110;
    #((CLK_PERIOD)*2) data = 3'b110;
    #((CLK_PERIOD)*2) data = 3'b011;
    #((CLK_PERIOD)*2) data = 3'b101;
    #((CLK_PERIOD)*2) data = 3'b001;
    #((CLK_PERIOD)*2) data = 3'b101;
    #((CLK_PERIOD)*2) data = 3'b110;
    #((CLK_PERIOD)*2) data = 3'b000;
    #((CLK_PERIOD)*2) data = 3'b110;
    #((CLK_PERIOD)*2) data = 3'b110;
    #((CLK_PERIOD)*2) data = 3'b011;
    #((CLK_PERIOD)*2) data = 3'b101;
    
    // Test case 5: No sequence match
    #((CLK_PERIOD)*2) data = 3'b111;
    #((CLK_PERIOD)*2) data = 3'b000;
    #((CLK_PERIOD)*2) data = 3'b111;
    #((CLK_PERIOD)*2) data = 3'b000;
    #((CLK_PERIOD)*2) data = 3'b111;
    #((CLK_PERIOD)*2) data = 3'b000;
    #((CLK_PERIOD)*2) data = 3'b111;
    #((CLK_PERIOD)*2) data = 3'b000;
    
    // End simulation
    $finish;
  end
  
  // Monitor
  always @(posedge clk) begin
    $display("Data: %b, Sequence Found: %b", data, sequence_found);
  end
  
endmodule
