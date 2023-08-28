module testbench;
  
  // Inputs
  reg clk;
  reg reset;
  reg enable;
  
  // Outputs
  wire [7:0] data;
  
  // Instantiate the sequence generator module
  sequence_generator dut (
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
    #20 enable = 1;
    #100 enable = 0;
    #20 enable = 1;
    #100 enable = 0;
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
  
  // Simulation end
  initial begin
    #500 $finish;
  end
  
  // Dump waveform
  initial begin
    $dumpfile("WaveOutput.vcd");
    $dumpvars(0, testbench);
  end
  
endmodule
