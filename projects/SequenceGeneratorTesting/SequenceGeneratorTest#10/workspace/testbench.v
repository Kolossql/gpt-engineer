module testbench;
  reg clk;
  reg rst_n;
  reg enable;
  wire [7:0] data;
  
  // Instantiate SequenceGenerator module
  SequenceGenerator dut (
    .clk(clk),
    .rst_n(rst_n),
    .enable(enable),
    .data(data)
  );
  
  // Clock generator
  always begin
    clk = 1'b0;
    #5;
    clk = 1'b1;
    #5;
  end
  
  // Reset generator
  initial begin
    rst_n = 1'b0;
    #10;
    rst_n = 1'b1;
    #10;
  end
  
  // Enable generator
  initial begin
    enable = 1'b0;
    #20;
    enable = 1'b1;
    #20;
    enable = 1'b0;
    #20;
    enable = 1'b1;
    #20;
  end
  
  // Data checker
  initial begin
    // Test case 1: Enable signal asserted, clock frequency = 10
    #10;
    if (data === 8'hAF)
      $display("Test case 1 Passed");
    else
      $display("Test case 1 Failed");
    
    // Test case 2: Enable signal de-asserted, clock frequency = 10
    enable = 1'b0;
    #10;
    if (data === 8'hAF)
      $display("Test case 2 Passed");
    else
      $display("Test case 2 Failed");
    
    // Test case 3: Active-low reset signal asserted, clock frequency = 10
    rst_n = 1'b0;
    #10;
    if (data === 8'hAF)
      $display("Test case 3 Passed");
    else
      $display("Test case 3 Failed");
    
    // Test case 4: Enable signal asserted, active-low reset signal asserted, clock frequency = 10
    enable = 1'b1;
    rst_n = 1'b0;
    #10;
    if (data === 8'hAF)
      $display("Test case 4 Passed");
    else
      $display("Test case 4 Failed");
    
    // Test case 5: Enable signal de-asserted, active-low reset signal asserted, clock frequency = 10
    enable = 1'b0;
    #10;
    if (data === 8'hAF)
      $display("Test case 5 Passed");
    else
      $display("Test case 5 Failed");
    
    // End simulation
    $finish;
  end
  
  // Dump waveform
  initial begin
    $dumpfile("WaveOutput.vcd");
    $dumpvars(0, testbench);
  end
endmodule
