`timescale 1ns / 1ps

module LFSR_Testbench;
    reg clk;
    reg reset_n;
    wire [7:0] data;

    // Instantiate the LFSR module
    LFSR u1 (
        .clk(clk),
        .reset_n(reset_n),
        .data(data)
    );

    // Initialize the LFSR module
    initial begin
        clk = 0;
        reset_n = 0;
        #10 reset_n = 1;
    end

    // Generate the clock signal
    always #5 clk = ~clk;

    // Test case 1: Reset in the middle of a sequence
    initial begin
        #50 reset_n = 0;
        #10 reset_n = 1;
        #100;
        if (data == 8'b10001010) begin
            $display("Test case 1: Passed");
        end else begin
            $display("Test case 1: Failed");
        end
    end

    // Test case 2: Reset at the initial state
    initial begin
        #200 reset_n = 0;
        #10 reset_n = 1;
        #100;
        if (data == 8'b10001010) begin
            $display("Test case 2: Passed");
        end else begin
            $display("Test case 2: Failed");
        end
    end

    // Test case 3: Reset at a state other than the initial state or the middle of a sequence
    initial begin
        #350 reset_n = 0;
        #10 reset_n = 1;
        #100;
        if (data == 8'b10001010) begin
            $display("Test case 3: Passed");
        end else begin
            $display("Test case 3: Failed");
        end
    end

    // Dump the waveforms
    initial begin
        $dumpfile("WaveOutput.vcd");
        $dumpvars(0, LFSR_Testbench);
    end

    // Finish the simulation
    initial begin
        #500;
        $finish;
    end
endmodule
