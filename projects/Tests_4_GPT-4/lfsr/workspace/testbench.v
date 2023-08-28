`timescale 1ns / 1ps

module LFSR_Module_tb;
    reg clk;
    reg reset;
    wire [7:0] data;

    // Instantiate the module under test
    LFSR_Module uut (
        .clk(clk),
        .reset(reset),
        .data(data)
    );

    // Initialize inputs
    initial begin
        clk = 0;
        reset = 0;
    end

    // Generate clock signal
    always #5 clk = ~clk;

    // Dump waveforms
    initial begin
        $dumpfile("WaveOutput.vcd");
        $dumpvars(0, LFSR_Module_tb);
    end

    // Test cases
    initial begin
        // Test case 1: Clock signal at rising edge
        #10;
        if (data !== 8'b10001010) $display("Test 1 Failed");
        else $display("Test 1 Passed");

        // Test case 2: Reset signal is active-low
        reset = 1;
        #10;
        if (data !== 8'b10001010) $display("Test 2 Failed");
        else $display("Test 2 Passed");

        // Test case 3: Reset signal is not active-low
        reset = 0;
        #10;
        if (data === 8'b10001010) $display("Test 3 Failed");
        else $display("Test 3 Passed");

        // Test case 4: Module in initial state
        reset = 1;
        #10;
        reset = 0;
        #10;
        if (data !== 8'b10001010) $display("Test 4 Failed");
        else $display("Test 4 Passed");

        // Test case 5: Module has been running for some time
        #50;
        if (data === 8'b10001010) $display("Test 5 Failed");
        else $display("Test 5 Passed");

        // Finish simulation
        $finish;
    end
endmodule
