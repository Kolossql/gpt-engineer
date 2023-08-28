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

        // Wait for 100 ns for global reset to finish
        #100;
        
        // Dump waveforms
        $dumpfile("WaveOutput.vcd");
        $dumpvars(0, TrafficLightStateMachine_tb);

        // Test Case 1: Enable input is switched from low to high
        enable = 1;
        #50;
        if (red == 1'b1 && yellow == 1'b0 && green == 1'b0)
            $display("Test Case 1 Passed");
        else
            $display("Test Case 1 Failed");

        // Test Case 2: Active-low reset is triggered while the traffic light is operating
        reset_n = 1;
        #50;
        if (red == 1'b1 && yellow == 1'b0 && green == 1'b0)
            $display("Test Case 2 Passed");
        else
            $display("Test Case 2 Failed");

        // Test Case 3: Active-low reset is triggered while the 'Enable' input is low
        enable = 0;
        reset_n = 1;
        #50;
        if (red == 1'b1 && yellow == 1'b0 && green == 1'b0)
            $display("Test Case 3 Passed");
        else
            $display("Test Case 3 Failed");

        // Test Case 4: 'Enable' input is switched from high to low during different light signals
        enable = 1;
        #50;
        enable = 0;
        #50;
        if (red == 1'b1 && yellow == 1'b0 && green == 1'b0)
            $display("Test Case 4 Passed");
        else
            $display("Test Case 4 Failed");

        // Test Case 5: 'Enable' input is switched from high to low and then back to high during a single light signal
        enable = 1;
        #50;
        enable = 0;
        #50;
        enable = 1;
        #50;
        if (red == 1'b1 && yellow == 1'b0 && green == 1'b0)
            $display("Test Case 5 Passed");
        else
            $display("Test Case 5 Failed");

        // Finish the simulation
        $finish;
    end
      
    // Clock generator
    always #10 clk = ~clk;

endmodule
