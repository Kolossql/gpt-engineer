`timescale 1ns / 1ps

module BinaryToBCD_tb;

    // Inputs
    reg [7:0] binary_input;

    // Outputs
    wire [11:0] BCD_output;

    // Instantiate the Unit Under Test (UUT)
    BinaryToBCD uut (
        .binary_input(binary_input), 
        .BCD_output(BCD_output)
    );

    initial begin
        // Initialize Inputs
        binary_input = 8'b0;

        // Dump waveforms
        $dumpfile("WaveOutput.vcd");
        $dumpvars(0, BinaryToBCD_tb);

        // Test Case 1: Minimum input value
        binary_input = 8'b0;
        #10;
        if (BCD_output == 12'b000000000000) $display("Test Case 1: Passed");
        else $display("Test Case 1: Failed");

        // Test Case 2: Maximum input value
        binary_input = 8'b11111111;
        #10;
        if (BCD_output == 12'b001001010101) $display("Test Case 2: Passed");
        else $display("Test Case 2: Failed");

        // Test Case 3: Middle of the range
        binary_input = 8'b10000000;
        #10;
        if (BCD_output == 12'b000100101000) $display("Test Case 3: Passed");
        else $display("Test Case 3: Failed");

        // Test Case 4: Power of 2
        binary_input = 8'b01000000;
        #10;
        if (BCD_output == 12'b000001100100) $display("Test Case 4: Passed");
        else $display("Test Case 4: Failed");

        // Test Case 5: Not a power of 2
        binary_input = 8'b00001010;
        #10;
        if (BCD_output == 12'b000000001010) $display("Test Case 5: Passed");
        else $display("Test Case 5: Failed");

        // End of tests
        $finish;
    end
endmodule
