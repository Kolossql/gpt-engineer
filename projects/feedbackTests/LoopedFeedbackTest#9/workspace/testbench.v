`timescale 1ns / 1ps

module BinaryToBCD_Test;

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
        $dumpvars(0, BinaryToBCD_Test);

        // Test Case 1: Binary input is at the lower limit (0)
        binary_input = 8'b0;
        #200;
        if (BCD_output == 12'b0000_0000_0000) begin
            $display("Test Case 1 Passed");
        end else begin
            $display("Test Case 1 Failed");
            $display("BCD_output = %b", BCD_output);
        end

        // Test Case 2: Binary input is at the upper limit (255)
        binary_input = 8'b1111_1111;
        #200;
        if (BCD_output == 12'b0010_0101_0101) begin
            $display("Test Case 2 Passed");
        end else begin
            $display("Test Case 2 Failed");
            $display("BCD_output = %b", BCD_output);
        end

        // Test Case 3: Binary input is in the middle of the range (128)
        binary_input = 8'b1000_0000;
        #200;
        if (BCD_output == 12'b0001_0010_1000) begin
            $display("Test Case 3 Passed");
        end else begin
            $display("Test Case 3 Failed");
            $display("BCD_output = %b", BCD_output);
        end

        // Test Case 4: Binary input is just above the lower limit (1)
        binary_input = 8'b0000_0001;
        #200;
        if (BCD_output == 12'b0000_0000_0001) begin
            $display("Test Case 4 Passed");
        end else begin
            $display("Test Case 4 Failed");
            $display("BCD_output = %b", BCD_output);
        end

        // Test Case 5: Binary input is just below the upper limit (254)
        binary_input = 8'b1111_1110;
        #200;
        if (BCD_output == 12'b0010_0101_0100) begin
            $display("Test Case 5 Passed");
        end else begin
            $display("Test Case 5 Failed");
            $display("BCD_output = %b", BCD_output);
        end

        // Finish the simulation
        #100;
        $finish;
    end

endmodule
