`timescale 1ns / 1ps

module TrafficLightStateMachine_tb;

    // Inputs
    reg clk;
    reg reset_n;
    reg enable;

    // Outputs
    wire red;
    wire yellow;
    wire green;

    // Instantiate the Unit Under Test (UUT)
    TrafficLightStateMachine uut (
        .clk(clk), 
        .reset_n(reset_n), 
        .enable(enable), 
        .red(red), 
        .yellow(yellow), 
        .green(green)
    );

    initial begin
        // Initialize Inputs
        clk = 0;
        reset_n = 0;
        enable = 0;

        // Dump waveforms
        $dumpfile("WaveOutput.vcd");
        $dumpvars(0, TrafficLightStateMachine_tb);

        // Test Cases
        #10 reset_n = 1; enable = 1; // Test case 1: Normal operation
        #320 if (!green) $display("Test 1 Failed"); else $display("Test 1 Passed"); // Check if green after 32 cycles
        #200 if (!yellow) $display("Test 2 Failed"); else $display("Test 2 Passed"); // Check if yellow after 20 cycles
        #70 if (!red) $display("Test 3 Failed"); else $display("Test 3 Passed"); // Check if red after 7 cycles
        reset_n = 0; #10 reset_n = 1; // Test case 2: Reset while operating
        if (!red) $display("Test 4 Failed"); else $display("Test 4 Passed"); // Check if red after reset
        enable = 0; #100 enable = 1; // Test case 3: Pause and resume
        if (!red) $display("Test 5 Failed"); else $display("Test 5 Passed"); // Check if red after resume
        reset_n = 0; enable = 1; #10 reset_n = 1; // Test case 4: Reset and enable simultaneously
        if (!red) $display("Test 6 Failed"); else $display("Test 6 Passed"); // Check if red after reset and enable
        enable = 0; #100 if (red || yellow || green) $display("Test 7 Failed"); else $display("Test 7 Passed"); // Test case 5: Pause with 'Enable' low

        $finish;
    end

    // Clock generator
    always #5 clk = ~clk;

endmodule
