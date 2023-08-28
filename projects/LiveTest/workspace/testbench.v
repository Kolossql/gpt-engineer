`timescale 1ns / 1ps

module ABROStateMachine_tb;
    // Inputs
    reg clk;
    reg reset_n;
    reg A;
    reg B;

    // Outputs
    wire O;
    wire [1:0] state;

    // Instantiate the Unit Under Test (UUT)
    ABROStateMachine uut (
        .clk(clk), 
        .reset_n(reset_n), 
        .A(A), 
        .B(B), 
        .O(O), 
        .state(state)
    );

    initial begin
        // Initialize Inputs
        clk = 0;
        reset_n = 0;
        A = 0;
        B = 0;

        // Dump waveforms
        $dumpfile("WaveOutput.vcd");
        $dumpvars(0, ABROStateMachine_tb);

        // Test Case 1: Both inputs are 0
        #10 A = 0; B = 0;
        #10 if (O == 0 && state == 2'b00) $display("Test Case 1: Passed");
        else $display("Test Case 1: Failed");

        // Test Case 2: Both inputs are 1
        #10 A = 1; B = 1;
        #10 if (O == 1 && state == 2'b11) $display("Test Case 2: Passed");
        else $display("Test Case 2: Failed");

        // Test Case 3: A is 1 and B is 0
        #10 A = 1; B = 0;
        #10 if (O == 0 && state == 2'b10) $display("Test Case 3: Passed");
        else $display("Test Case 3: Failed");

        // Test Case 4: A is 0 and B is 1
        #10 A = 0; B = 1;
        #10 if (O == 0 && state == 2'b01) $display("Test Case 4: Passed");
        else $display("Test Case 4: Failed");

        // Test Case 5: Active-low reset is triggered
        #10 reset_n = 1;
        #10 if (O == 0 && state == 2'b00) $display("Test Case 5: Passed");
        else $display("Test Case 5: Failed");

        // End of tests
        $finish;
    end

    // Clock generator
    always #5 clk = ~clk;
endmodule
