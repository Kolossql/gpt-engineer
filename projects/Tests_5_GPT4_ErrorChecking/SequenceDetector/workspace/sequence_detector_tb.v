`timescale 1ns / 1ps

module SequenceDetector_tb;

    reg clk;
    reg reset_n;
    reg [2:0] data_in;
    wire sequence_found;

    SequenceDetector uut (
        .clk(clk),
        .reset_n(reset_n),
        .data_in(data_in),
        .sequence_found(sequence_found)
    );

    initial begin
        $dumpfile("WaveOutput.vcd");
        $dumpvars(0, SequenceDetector_tb);

        // Initialize inputs
        clk = 0;
        reset_n = 1;
        data_in = 3'b000;

        // Test case 1: Correct sequence
        #10 data_in = 3'b001; #10 data_in = 3'b101; #10 data_in = 3'b110; #10 data_in = 3'b000; #10 data_in = 3'b110; #10 data_in = 3'b110; #10 data_in = 3'b011; #10 data_in = 3'b101;
        if (sequence_found) $display("Test case 1: Passed"); else $display("Test case 1: Failed");

        // Test case 2: Interrupted sequence
        #10 data_in = 3'b001; #10 data_in = 3'b101; #10 data_in = 3'b110; #10 data_in = 3'b000; #10 data_in = 3'b110; #10 data_in = 3'b110; #10 data_in = 3'b011; #10 data_in = 3'b100;
        if (!sequence_found) $display("Test case 2: Passed"); else $display("Test case 2: Failed");

        // Test case 3: Repeated sequence
        #10 data_in = 3'b001; #10 data_in = 3'b101; #10 data_in = 3'b110; #10 data_in = 3'b000; #10 data_in = 3'b110; #10 data_in = 3'b110; #10 data_in = 3'b011; #10 data_in = 3'b101;
        #10 data_in = 3'b001; #10 data_in = 3'b101; #10 data_in = 3'b110; #10 data_in = 3'b000; #10 data_in = 3'b110; #10 data_in = 3'b110; #10 data_in = 3'b011; #10 data_in = 3'b101;
        if (sequence_found) $display("Test case 3: Passed"); else $display("Test case 3: Failed");

        // Test case 4: Reset during sequence
        #10 data_in = 3'b001; #10 data_in = 3'b101; #10 reset_n = 0; #10 reset_n = 1; #10 data_in = 3'b110; #10 data_in = 3'b000; #10 data_in = 3'b110; #10 data_in = 3'b110; #10 data_in = 3'b011; #10 data_in = 3'b101;
        if (!sequence_found) $display("Test case 4: Passed"); else $display("Test case 4: Failed");

        // Test case 5: Not enabled during sequence
        #10 data_in = 3'b001; #10 data_in = 3'b101; #10 clk = 0; #10 data_in = 3'b110; #10 data_in = 3'b000; #10 data_in = 3'b110; #10 data_in = 3'b110; #10 data_in = 3'b011; #10 data_in = 3'b101; #10 clk = 1;
        if (!sequence_found) $display("Test case 5: Passed"); else $display("Test case 5: Failed");

        $finish;
    end

    always #5 clk = ~clk;

endmodule
