module testbench;
  // Inputs
  reg initial_state;
  reg clock;
  reg reset;
  reg [1:0] die_select;
  reg roll;
  
  // Outputs
  wire [7:0] rolled_number;
  
  // Instantiate the module under test
  DiceRoller dut (
    .initial_state(initial_state),
    .clock(clock),
    .reset(reset),
    .die_select(die_select),
    .roll(roll),
    .rolled_number(rolled_number)
  );
  
  // Clock generation
  always begin
    clock = 0;
    #5;
    clock = 1;
    #5;
  end
  
  // Reset generation
  initial begin
    reset = 0;
    #10;
    reset = 1;
    #10;
    reset = 0;
  end
  
  // Test cases
  initial begin
    // Test case 1: 4-sided die, roll input high, clock rising edge
    initial_state = 1;
    die_select = 2'b00;
    roll = 1;
    #20;
    if (rolled_number === 4'b0000)
      $display("Test case 1 Passed");
    else
      $display("Test case 1 Failed");
    
    // Test case 2: 6-sided die, roll input high, clock rising edge
    initial_state = 1;
    die_select = 2'b01;
    roll = 1;
    #20;
    if (rolled_number >= 4'b0001 && rolled_number <= 4'b0110)
      $display("Test case 2 Passed");
    else
      $display("Test case 2 Failed");
    
    // Test case 3: 8-sided die, roll input high, clock rising edge
    initial_state = 1;
    die_select = 2'b10;
    roll = 1;
    #20;
    if (rolled_number >= 4'b0001 && rolled_number <= 4'b1000)
      $display("Test case 3 Passed");
    else
      $display("Test case 3 Failed");
    
    // Test case 4: 20-sided die, roll input high, clock rising edge
    initial_state = 1;
    die_select = 2'b11;
    roll = 1;
    #20;
    if (rolled_number >= 4'b0001 && rolled_number <= 5'b10100)
      $display("Test case 4 Passed");
    else
      $display("Test case 4 Failed");
    
    // Test case 5: Roll input low, clock rising edge
    initial_state = 1;
    die_select = 2'b00;
    roll = 0;
    #20;
    if (rolled_number === 4'b0000)
      $display("Test case 5 Passed");
    else
      $display("Test case 5 Failed");
    
    $finish;
  end
  
  // Dump waveform for debugging
  initial begin
    $dumpfile("WaveOutput.vcd");
    $dumpvars(0, testbench);
  end
endmodule
