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
    .clock(clk),
    .reset(reset),
    .die_select(die_select),
    .roll(roll),
    .rolled_number(rolled_number)
  );

  // Clock generation
  always #((CLK_PERIOD)/2) clk = ~clk;

  // Test stimulus
  initial begin

    $dumpfile("test.vcd");
    $dumpvars;
    // Initialize inputs
    reset = 1;
    die_select = 2'b00;
    roll = 0;

    // Release reset
    #((CLK_PERIOD)*2) reset = 0;

    // Test case 1: Initial state of 4-sided die
    #((CLK_PERIOD)*2) roll = 1;
    #((CLK_PERIOD)*10) roll = 0;
    $display("Test case 1: Initial state of 4-sided die");
    $display("Rolled Number: %d", rolled_number);
    $display("");

    // Test case 2: Roll input is low
    #((CLK_PERIOD)*2) roll = 0;
    $display("Test case 2: Roll input is low");
    $display("Rolled Number: %d", rolled_number);
    $display("");

    // Test case 3: Active-low reset
    #((CLK_PERIOD)*2) roll = 1;
    #((CLK_PERIOD)*2) reset = 1;
    #((CLK_PERIOD)*2) reset = 0;
    #((CLK_PERIOD)*10) roll = 0;
    $display("Test case 3: Active-low reset");
    $display("Rolled Number: %d", rolled_number);
    $display("");

    // Test case 4: Invalid die select input
    #((CLK_PERIOD)*2) roll = 1;
    #((CLK_PERIOD)*2) die_select = 2'b11;
    #((CLK_PERIOD)*10) roll = 0;
    $display("Test case 4: Invalid die select input");
    $display("Rolled Number: %d", rolled_number);
    $display("");

    // Test case 5: Random number generation
    #((CLK_PERIOD)*2) roll = 1;
    #((CLK_PERIOD)*10) roll = 0;
    $display("Test case 5: Random number generation");
    $display("Rolled Number: %d", rolled_number);
    $display("");

    // End simulation
    $finish;
  end

endmodule
