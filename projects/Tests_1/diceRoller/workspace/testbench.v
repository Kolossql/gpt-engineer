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
    .reset_n(reset),
    .die_select(die_select),
    .roll(roll),
    .rolled_number(rolled_number)
  );
  
  // Clock generator
  always begin
    clk = 0;
    #(CLK_PERIOD/2);
    clk = 1;
    #(CLK_PERIOD/2);
  end
  
  // Reset generator
  initial begin
    reset = 1;
    #10;
    reset = 0;
    #20;
    reset = 1;
  end
  
  // Stimulus generator
  initial begin
    $dumpfile("testbench.vcd");
    $dumpvars(0,testbench);

    //Set Default Values

    die_select ='b00;
    roll = 0;

    // Test initial state
    #10;
    $display("Initial state:");
    $display("Die select: %b", die_select);
    $display("Roll: %b", roll);
    $display("Rolled number: %d", rolled_number);
    
    // Test clock edge
    #10;
    $display("Clock edge:");
    roll = 1;
    #10;
    roll = 0;
    #10;
    roll = 1;
    #10;
    roll = 0;
    
    // Test roll input low
    #10;
    $display("Roll input low:");
    roll = 0;
    #10;
    roll = 1;
    #10;
    roll = 0;
    
    // Test invalid die select
    #10;
    $display("Invalid die select:");
    die_select = 2'b11;
    roll = 1;
    #10;
    die_select = 2'b00;
    roll = 1;
    #10;
    die_select = 2'b01;
    roll = 1;
    #10;
    die_select = 2'b10;
    roll = 1;
    
    // Test random number generation
    #10;
    $display("Random number generation:");
    die_select = 2'b00;
    roll = 1;
    #10;
    die_select = 2'b01;
    roll = 1;
    #10;
    die_select = 2'b10;
    roll = 1;
    #10;
    die_select = 2'b11;
    roll = 1;
    
    // End simulation
    #10;
    $finish;
  end
  
  // Monitor
  always @(posedge clk) begin
    $display("Rolled number: %d", rolled_number);
  end
  
endmodule
