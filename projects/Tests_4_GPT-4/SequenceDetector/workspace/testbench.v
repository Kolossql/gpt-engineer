`timescale 1ns / 1ps

module testbench;
    reg clk;
    reg reset_n;
    reg [2:0] data;
    wire sequence_found;

    // Instantiate the module under test
    SequenceDetector MUT (
        .clk(clk),
        .reset_n(reset_n),
        .data(data),
        .sequence_found(sequence_found)
    );

    initial begin
        // Initialize inputs
        clk = 0;
        reset_n = 0;
        data = 3'b000;

        // Dump waveforms
        $dumpfile("WaveOutput.vcd");
        $dumpvars(0, testbench);

        // Apply reset
        #10 reset_n = 1;

        // Test case 1: Detect sequence
        data = 3'b001; #10;
        data = 3'b101; #10;
        data = 3'b110; #10;
        data = 3'b000; #10;
        data = 3'b110; #10;
        data = 3'b110; #10;
        data = 3'b011; #10;
        data = 3'b101; #10;
        if (sequence_found) $display("Test case 1: Passed");
        else $display("Test case 1: Failed");

        // Test case 2: Do not detect sequence when it is not present
        data = 3'b000; #10;
        if (!sequence_found) $display("Test case 2: Passed");
        else $display("Test case 2: Failed");

        // Test case 3: Reset sequence detection when sequence is interrupted
        data = 3'b001; #10;
        data = 3'b101; #10;
        data = 3'b110; #10;
        data = 3'b000; #10;
        data = 3'b110; #10;
        data = 3'b110; #10;
        data = 3'b011; #10;
        data = 3'b000; #10; // Interrupt sequence
        if (!sequence_found) $display("Test case 3: Passed");
        else $display("Test case 3: Failed");

        // Test case 4: Continue sequence detection when sequence is detected more than once
        data = 3'b001; #10;
        data = 3'b101; #10;
        data = 3'b110; #10;
        data = 3'b000; #10;
        data = 3'b110; #10;
        data = 3'b110; #10;
        data = 3'b011; #10;
        data = 3'b101; #10;
        data = 3'b001; #10;
        data = 3'b101; #10;
        data = 3'b110; #10;
        data = 3'b000; #10;
        data = 3'b110; #10;
        data = 3'b110; #10;
        data = 3'b011; #10;
        data = 3'b101; #10;
        if (sequence_found) $display("Test case 4: Passed");
        else $display("Test case 4: Failed");

        // Test case 5: Do not detect sequence when detector is not enabled
        reset_n = 0; #10; // Disable detector
        data = 3'b001; #10;
        data = 3'b101; #10;
        data = 3'b110; #10;
        data = 3'b000; #10;
        data = 3'b110; #10;
        data = 3'b110; #10;
        data = 3'b011; #10;
        data = 3'b101; #10;
        if (!sequence_found) $display("Test case 5: Passed");
        else $display("Test case 5: Failed");

        // Finish simulation
        $finish;
    end

    // Clock generator
    always #5 clk = ~clk;
endmodule
