module testbench;
  
  // Parameters
  parameter CLK_PERIOD = 10; // Clock period in ns
  
  // Signals
  reg clk;
  reg reset;
  reg [1:0] die_select;
  reg roll;
  wire [7:0] rolled_number;
  
  // Instantiate the module under test
  dice_roller dut (
    .clk(clk),
    .reset(reset),
    .die_select(die_select),
    .roll(roll),
    .rolled_number(rolled_number)
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
    // Test case 1: roll input is low
    die_select = 2'b00; // 4-sided die
    roll = 0;
    #((CLK_PERIOD)*10);
    
    // Test case 2: roll input is high but clock rising edge does not occur
    die_select = 2'b01; // 6-sided die
    roll = 1;
    #((CLK_PERIOD)*5);
    roll = 0;
    #((CLK_PERIOD)*10);
    
    // Test case 3: roll input is high and clock rising edge occurs
    die_select = 2'b10; // 8-sided die
    roll = 1;
    #((CLK_PERIOD)*5);
    roll = 0;
    #((CLK_PERIOD)*10);
    
    // Test case 4: active-low reset
    die_select = 2'b11; // 20-sided die
    roll = 1;
    #((CLK_PERIOD)*5);
    reset = 1;
    #((CLK_PERIOD)*2) reset = 0;
    #((CLK_PERIOD)*10);
    
    // Test case 5: different die select values
    die_select = 2'b00; // 4-sided die
    roll = 1;
    #((CLK_PERIOD)*5);
    roll = 0;
    #((CLK_PERIOD)*10);
    
    die_select = 2'b01; // 6-sided die
    roll = 1;
    #((CLK_PERIOD)*5);
    roll = 0;
    #((CLK_PERIOD)*10);
    
    die_select = 2'b10; // 8-sided die
    roll = 1;
    #((CLK_PERIOD)*5);
    roll = 0;
    #((CLK_PERIOD)*10);
    
    die_select = 2'b11; // 20-sided die
    roll = 1;
    #((CLK_PERIOD)*5);
    roll = 0;
    #((CLK_PERIOD)*10);
    
    $finish;
  end
  
  // Monitor
  always @(posedge clk) begin
    $display("Rolled Number: %d", rolled_number);
  end
  
endmodule
