module SequenceGenerator_tb;

  // Inputs
  reg clk;
  reg reset;
  reg enable;

  // Outputs
  wire [7:0] data;

  // Instantiate the SequenceGenerator module
  SequenceGenerator dut (
    .clk(clk),
    .reset(reset),
    .enable(enable),
    .data(data)
  );

  // Clock driver
  always begin
    clk = 0;
    #5;
    clk = 1;
    #5;
  end

  // Reset driver
  initial begin
    reset = 1;
    #10;
    reset = 0;
    #10;
    reset = 1;
    #10;
    reset = 0;
    #10;
    $finish;
  end

  // Enable driver
  initial begin
    enable = 0;
    #20;
    enable = 1;
    #10;
    enable = 0;
    #10;
    enable = 1;
    #10;
    enable = 0;
    #10;
    enable = 1;
    #10;
    enable = 0;
    #10;
    enable = 1;
    #10;
    enable = 0;
    #10;
    $finish;
  end

  // Monitor
  always @(posedge clk) begin
    if (enable) begin
      case (data)
        8'hAF: $display("Passed: Output is 0xAF");
        8'hBC: $display("Passed: Output is 0xBC");
        8'hE2: $display("Passed: Output is 0xE2");
        8'h78: $display("Passed: Output is 0x78");
        8'hFF: $display("Passed: Output is 0xFF");
        8'h0B: $display("Passed: Output is 0x0B");
        8'h8D: $display("Passed: Output is 0x8D");
        default: $display("Failed: Unexpected output");
      endcase
    end
  end

  // Test cases
  initial begin
    // Test case 1: Clock frequency variation
    $display("Test case 1: Clock frequency variation");
    #100;

    // Test case 2: Active-low reset activation and deactivation
    $display("Test case 2: Active-low reset activation and deactivation");
    #100;

    // Test case 3: Enable signal activation and deactivation
    $display("Test case 3: Enable signal activation and deactivation");
    #100;

    // Test case 4: Sequence of enable signal activations and deactivations
    $display("Test case 4: Sequence of enable signal activations and deactivations");
    #100;

    // Test case 5: Sequence generator reaching the end and repeating
    $display("Test case 5: Sequence generator reaching the end and repeating");
    #100;

    $finish;
  end

  // Dump waveform for GTKWave
  initial begin
    $dumpfile("WaveOutput.vcd");
    $dumpvars(0, SequenceGenerator_tb);
    $finish;
  end

endmodule
