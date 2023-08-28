`timescale 1ns / 1ps

module Testbench;

    reg clk;
    reg reset_n;
    reg enable;
    wire [7:0] data;

    // Instantiate the module to be tested
    SequenceGenerator uut (
        .clk(clk),
        .reset_n(reset_n),
        .enable(enable),
        .data(data)
    );

    initial begin
        // Initialize the inputs and outputs
        clk = 0;
        reset_n = 0;
        enable = 0;

        // Dump the waveforms to a file
        $dumpfile("WaveOutput.vcd");
        $dumpvars(0, Testbench);

        // Test case 1: The sequence generator is enabled and the clock has a rising edge
        enable = 1;
        #10 clk = 1;
        #10 if (data == 8'hAF) $display("Test case 1: Passed"); else $display("Test case 1: Failed");

        // Test case 2: The sequence generator is enabled and the clock does not have a rising edge
        #10 clk = 0;
        #10 if (data == 8'hAF) $display("Test case 2: Passed"); else $display("Test case 2: Failed");

        // Test case 3: The sequence generator is not enabled and the clock has a rising edge
        enable = 0;
        #10 clk = 1;
        #10 if (data == 8'hAF) $display("Test case 3: Passed"); else $display("Test case 3: Failed");

        // Test case 4: The sequence generator is not enabled and the clock does not have a rising edge
        #10 clk = 0;
        #10 if (data == 8'hAF) $display("Test case 4: Passed"); else $display("Test case 4: Failed");

        // Test case 5: The active-low reset is triggered while the sequence is being outputted
        enable = 1;
        #10 clk = 1;
        #10 reset_n = 1;
        #10 if (data == 8'hAF) $display("Test case 5: Passed"); else $display("Test case 5: Failed");

        // Finish the simulation
        $finish;
    end

    // Generate the clock signal
    always #5 clk = ~clk;

endmodule
