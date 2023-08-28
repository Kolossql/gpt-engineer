module sequence_generator_tb;

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

  // Clock generator
  always #((CLK_PERIOD)/2) clk = ~clk;

  // Stimulus generator
  initial begin
    reset = 1;
    enable = 0;
    clk = 0;
    #10 reset = 0;
    #20 enable = 1;
    #100 enable = 0;
    #100 enable = 1;
    #100 enable = 0;
    #100 $finish;
  end

  // Expected output generator
  reg [7:0] expected_output;
  initial begin
    expected_output = 8'hAF;
    #10 expected_output = 8'hBC;
    #10 expected_output = 8'hE2;
    #10 expected_output = 8'h78;
    #10 expected_output = 8'hFF;
    #10 expected_output = 8'hE2;
    #10 expected_output = 8'h0B;
    #10 expected_output = 8'h8D;
  end

  // Monitor the output and compare with expected values
  always @(posedge clk) begin
    if (enable) begin
      if (data !== expected_output) begin
        $display("Mismatch: Expected: %h, Got: %h", expected_output, data);
      end
    end
  end

  // Dump waveform to VCD file
  initial begin
    $dumpfile("WaveOutput.vcd");
    $dumpvars(1, sequence_generator_tb);
  end

endmodule
