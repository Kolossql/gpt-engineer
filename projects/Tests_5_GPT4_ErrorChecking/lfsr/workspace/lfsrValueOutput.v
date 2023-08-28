module tb_lfsr_8bit;
  reg clk;
  wire [7:0] data;
  reg [7:0] seen_values [0:254];
  reg [7:0] count = 0;

  // Instantiate the LFSR module
    LFSR u1 (
        .clk(clk),
        .reset_n(reset_n),
        .data(data)
    );

  // Clock generation
  always begin
    #5 clk = ~clk;
  end

  // Testbench logic
  initial begin
    // Initialize
    clk = 0;
    $dumpfile("lfsr_8bit.vcd");
    $dumpvars(0, tb_lfsr_8bit);

    // Wait for the first value
    @(posedge clk);

    // Check for 255 unique values
    repeat (255) begin
      @(posedge clk);
      if (seen_values[data] == 1) begin
        $display("Test failed: Repeated value detected at count = %d", count);
        $finish;
      end
      seen_values[data] = 1;
      count = count + 1;
    end

    $display("Test passed: 255 unique values detected");
    $finish;
  end
endmodule