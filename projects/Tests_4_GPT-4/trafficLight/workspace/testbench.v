`timescale 1ns / 1ps

module Testbench;
    reg clk;
    reg reset_n;
    reg enable;
    wire red;
    wire yellow;
    wire green;

    TrafficLightStateMachine u1 (
        .clk(clk), 
        .reset_n(reset_n), 
        .enable(enable), 
        .red(red), 
        .yellow(yellow), 
        .green(green)
    );

    initial begin
        $dumpfile("WaveOutput.vcd");
        $dumpvars(0, Testbench);

        // Initialization
        clk = 0;
        reset_n = 0;
        enable = 0;

        // Test Case 1: Initial State
        reset_n = 1;
        enable = 1;
        #32;
        if (red == 1 && yellow == 0 && green == 0) begin
            $display("Test Case 1: Passed");
        end else begin
            $display("Test Case 1: Failed");
        end

        // Test Case 2: Red to Green Transition
        #32;
        if (red == 0 && yellow == 0 && green == 1) begin
            $display("Test Case 2: Passed");
        end else begin
            $display("Test Case 2: Failed");
        end

        // Test Case 3: Green to Yellow Transition
        #20;
        if (red == 0 && yellow == 1 && green == 0) begin
            $display("Test Case 3: Passed");
        end else begin
            $display("Test Case 3: Failed");
        end

        // Test Case 4: Yellow to Red Transition
        #7;
        if (red == 1 && yellow == 0 && green == 0) begin
            $display("Test Case 4: Passed");
        end else begin
            $display("Test Case 4: Failed");
        end

        // Test Case 5: Enable Switching
        enable = 0;
        #10;
        enable = 1;
        #32;
        if (red == 0 && yellow == 0 && green == 1) begin
            $display("Test Case 5: Passed");
        end else begin
            $display("Test Case 5: Failed");
        end

        $finish;
    end

    always #10 clk = ~clk;
endmodule
