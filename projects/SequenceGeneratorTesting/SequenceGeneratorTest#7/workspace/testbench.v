module testbench;
  
  // Parameters
  parameter CLK_PERIOD = 10; // Clock period in ns
  
  // Inputs
  reg clk;
  reg reset;
  reg enable;
  
  // Outputs
  wire [7:0] data;
  
  // Instantiate the sequence generator module
  SequenceGenerator dut (
    .clk(clk),
    .reset(reset),
    .enable(enable),
    .data(data)
  );
  
  // Clock generation
  always #((CLK_PERIOD)/2) clk = ~clk;
  
  // Testbench stimulus
  initial begin
    $dumpfile("waves.vcd");
    $dumpvars(1, testbench);

    // Initialize inputs
    reset = 1;
    enable = 0;
    clk = 0;
    
    // Wait for a few clock cycles
    #((CLK_PERIOD)*10);
    
    // Deassert reset
    reset = 0;
    
    // Enable the sequence generator
    enable = 1;
    
    // Monitor the data output and verify correctness
    $display("Data Output:");
    repeat (8) begin
      #((CLK_PERIOD)*2);
      $display("Data: %h", data);
    end
    
    // Stop simulation
    $finish;
  end
  
endmodule
