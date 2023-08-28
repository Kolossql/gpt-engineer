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
    // Test case 1: Initial state with a 4-sided die
    die_select = 2'b00;
    roll = 0;
    #((CLK_PERIOD)*10);
    roll = 1;
    #((CLK_PERIOD)*10);
    roll = 0;
    #((CLK_PERIOD)*10);
    $display("Test case 1: Initial state with a 4-sided die");
    $display("Rolled number: %d", rolled_number);
    $display("");

    // Test case 2: Roll with a 6-sided die
    die_select = 2'b01;
    roll = 0;
    #((CLK_PERIOD)*10);
    roll = 1;
    #((CLK_PERIOD)*10);
    roll = 0;
    #((CLK_PERIOD)*10);
    $display("Test case 2: Roll with a 6-sided die");
    $display("Rolled number: %d", rolled_number);
    $display("");

    // Test case 3: Roll with an 8-sided die
    die_select = 2'b10;
    roll = 0;
    #((CLK_PERIOD)*10);
    roll = 1;
    #((CLK_PERIOD)*10);
    roll = 0;
    #((CLK_PERIOD)*10);
    $display("Test case 3: Roll with an 8-sided die");
    $display("Rolled number: %d", rolled_number);
    $display("");

    // Test case 4: Roll with a 20-sided die
    die_select = 2'b11;
    roll = 0;
    #((CLK_PERIOD)*10);
    roll = 1;
    #((CLK_PERIOD)*10);
    roll = 0;
    #((CLK_PERIOD)*10);
    $display("Test case 4: Roll with a 20-sided die");
    $display("Rolled number: %d", rolled_number);
    $display("");

    // Test case 5: Active-low reset
    die_select = 2'b01;
    roll = 0;
    #((CLK_PERIOD)*10);
    roll = 1;
    #((CLK_PERIOD)*10);
    reset = 1;
    #((CLK_PERIOD)*2);
    reset = 0;
    #((CLK_PERIOD)*10);
    roll = 0;
    #((CLK_PERIOD)*10);
    $display("Test case 5: Active-low reset");
    $display("Rolled number: %d", rolled_number);
    $display("");

    $finish;
  end

endmodule
