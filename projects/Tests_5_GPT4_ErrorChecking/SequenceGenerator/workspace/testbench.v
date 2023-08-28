`timescale 1ns / 1ps

module SequenceGenerator_tb;

    // Inputs
    reg clk;
    reg reset_n;
    reg enable;

    // Outputs
    wire [7:0] data;

    // Instantiate the Unit Under Test (UUT)
    SequenceGenerator uut (
        .clk(clk), 
        .reset_n(reset_n), 
        .enable(enable), 
        .data(data)
    );

    initial begin
        // Initialize Inputs
        clk = 0;
        reset_n = 0;
        enable = 0;

        // Dump waveforms
        $dumpfile("WaveOutput.vcd");
        $dumpvars(0, SequenceGenerator_tb);

        // Test Case 1: Toggle enable while sequence is being outputted
        #10 enable = 1;
        #10 enable = 0;
        #10 enable = 1;
        if (data == 8'hAF) $display("Test Case 1: Passed");
        else $display("Test Case 1: Failed");

        // Test Case 2: Trigger active-low reset while sequence is being outputted
        #10 enable = 1;
        #10 reset_n = 1;
        #10 reset_n = 0;
        if (data == 8'hAF) $display("Test Case 2: Passed");
        else $display("Test Case 2: Failed");

        // Test Case 3: Clock has a rising edge but enable is not high
        #10 clk = 1;
        #10 clk = 0;
        if (data == 8'hAF) $display("Test Case 3: Passed");
        else $display("Test Case 3: Failed");

        // Test Case 4: Sequence ends
        #80 enable = 1;
        if (data == 8'hAF) $display("Test Case 4: Passed");
        else $display("Test Case 4: Failed");

        // Test Case 5: Initial state
        #10 reset_n = 1;
        if (data == 8'hAF) $display("Test Case 5: Passed");
        else $display("Test Case 5: Failed");

        // End of tests
        $finish;
    end

    // Clock generator
    always #5 clk = ~clk;

endmodule
