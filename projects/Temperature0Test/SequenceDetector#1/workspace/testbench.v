module testbench;
  
  // Parameters
  parameter CLK_PERIOD = 10;
  
  // Signals
  reg clk;
  reg reset;
  reg [2:0] data;
  wire sequence_found;
  
  // Instantiate Sequence Detector
  sequence_detector dut (
    .clk(clk),
    .reset(reset),
    .data(data),
    .sequence_found(sequence_found)
  );
  
  // Clock Generator
  always #((CLK_PERIOD)/2) clk = ~clk;
  
  // Reset Generator
  initial begin
    reset = 1;
    #((CLK_PERIOD)*2) reset = 0;
  end
  
  // Data Generator
  initial begin
    #((CLK_PERIOD)*4) data = 3'b001;
    #((CLK_PERIOD)*6) data = 3'b101;
    #((CLK_PERIOD)*8) data = 3'b110;
    #((CLK_PERIOD)*10) data = 3'b000;
    #((CLK_PERIOD)*12) data = 3'b110;
    #((CLK_PERIOD)*14) data = 3'b110;
    #((CLK_PERIOD)*16) data = 3'b011;
    #((CLK_PERIOD)*18) data = 3'b101;
    #((CLK_PERIOD)*20) $finish;
  end
  
  // Monitor
  always @(posedge clk) begin
    $display("Data: %b, Sequence Found: %b", data, sequence_found);
  end
  
endmodule
