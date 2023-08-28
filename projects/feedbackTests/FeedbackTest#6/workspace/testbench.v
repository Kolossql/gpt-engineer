module testbench;

  // Inputs
  reg clk;
  reg reset;
  reg enable;

  // Outputs
  wire [7:0] data;

  // Instantiate SequenceGenerator module
  SequenceGenerator dut (
    .clk(clk),
    .reset(reset),
    .enable(enable),
    .data(data)
  );

  // Clock generator
  always #5 clk = ~clk;

  // Reset generator
  initial begin
    reset = 1;
    #10 reset = 0;
  end

  // Enable generator
  initial begin
    enable = 0;
    #20 enable = 1;
    #100 enable = 0;
    #50 enable = 1;
    #200 enable = 0;
    #30 enable = 1;
    #150 enable = 0;
  end

  // Data checker
  initial begin
    // Test 1: Initial state
    #10;
    if (data === 8'hAF) begin
      $display("Test 1 Passed");
    end else begin
      $display("Test 1 Failed");
    end

    // Test 2: Enable low
    #100;
    if (data === 8'hAF) begin
      $display("Test 2 Passed");
    end else begin
      $display("Test 2 Failed");
    end

    // Test 3: Enable high
    #100;
    if (data === 8'hBC) begin
      $display("Test 3 Passed");
    end else begin
      $display("Test 3 Failed");
    end

    // Test 4: Clock frequency
    #100;
    if (data === 8'hE2) begin
      $display("Test 4 Passed");
    end else begin
      $display("Test 4 Failed");
    end

    // Test 5: Reset timing
    #100;
    if (data === 8'hAF) begin
      $display("Test 5 Passed");
    end else begin
      $display("Test 5 Failed");
    end

    // Finish simulation
    $finish;
  end

  // Dump waveform
  initial begin
    $dumpfile("WaveOutput.vcd");
    $dumpvars(0, testbench);
  end

endmodule
