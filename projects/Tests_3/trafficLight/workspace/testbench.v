module testbench;
  
  // Inputs
  reg clk;
  reg reset;
  reg enable;
  
  // Outputs
  wire red;
  wire yellow;
  wire green;
  
  // Instantiate the traffic light module
  traffic_light uut (
    .clk(clk),
    .reset(reset),
    .enable(enable),
    .red(red),
    .yellow(yellow),
    .green(green)
  );
  
  // Clock generator
  always #5 clk = ~clk;
  
  // Stimulus generator
  initial begin
    reset = 1;
    enable = 0;
    #10 reset = 0;
    #50 enable = 1;
    #200 enable = 0;
    #100 reset = 1;
    #10 reset = 0;
    #50 enable = 1;
    #200 enable = 0;
    #100 reset = 1;
    #10 reset = 0;
    #50 enable = 1;
    #200 enable = 0;
    #100 $finish;
  end
  
  // Monitor
  always @(posedge clk) begin
    $display("Red: %b, Yellow: %b, Green: %b", red, yellow, green);
    if (red && !yellow && !green) begin
      if ($time == 32) $display("Passed: Red to Green transition");
      else $display("Failed: Red to Green transition");
    end
    if (!red && !yellow && green) begin
      if ($time == 52) $display("Passed: Green to Yellow transition");
      else $display("Failed: Green to Yellow transition");
    end
    if (!red && yellow && !green) begin
      if ($time == 59) $display("Passed: Yellow to Red transition");
      else $display("Failed: Yellow to Red transition");
    end
  end
  
  // Dump waveform
  initial begin
    $dumpfile("WaveOutput.vcd");
    $dumpvars(0, testbench);
  end
  
endmodule
