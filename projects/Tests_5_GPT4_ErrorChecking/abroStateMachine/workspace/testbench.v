`timescale 1ns / 1ps

module ABROStateMachine_tb;
    // Inputs
    reg clk;
    reg reset_n;
    reg A;
    reg B;

    // Outputs
    wire O;
    wire [3:0] State;

    // Instantiate the Unit Under Test (UUT)
    ABROStateMachine uut (
        .clk(clk), 
        .reset_n(reset_n), 
        .A(A), 
        .B(B), 
        .O(O), 
        .State(State)
    );

    initial begin
        // Initialize Inputs
        clk = 0;
        reset_n = 0;
        A = 0;
        B = 0;

        // Wait for 100 ns for global reset
        #100;
        reset_n = 1;

        // Dump waveforms
        $dumpfile("WaveOutput.vcd");
        $dumpvars(0, ABROStateMachine_tb);

        // Test Case 1: Both A and B inputs are received at the same time
        A = 1;
        B = 1;
        #10;
        if (O == 1'b1 && State == 4'b0001)
            $display("Test Case 1: Passed");
        else
            $display("Test Case 1: Failed");

        // Test Case 2: A input is received before B input
        A = 1;
        B = 0;
        #10;
        B = 1;
        #10;
        if (O == 1'b1 && State == 4'b0010)
            $display("Test Case 2: Passed");
        else
            $display("Test Case 2: Failed");

        // Test Case 3: B input is received before A input
        A = 0;
        B = 1;
        #10;
        A = 1;
        #10;
        if (O == 1'b1 && State == 4'b0100)
            $display("Test Case 3: Passed");
        else
            $display("Test Case 3: Failed");

        // Test Case 4: The reset signal is triggered while the state machine is in the middle of transitioning between states
        A = 1;
        B = 0;
        #10;
        reset_n = 0;
        #10;
        reset_n = 1;
        #10;
        if (O == 1'b0 && State == 4'b1000)
            $display("Test Case 4: Passed");
        else
            $display("Test Case 4: Failed");

        // Test Case 5: The clock signal changes while the state machine is in the middle of transitioning between states
        A = 1;
        B = 1;
        #10;
        clk = 1;
        #10;
        if (O == 1'b1 && State == 4'b0001)
            $display("Test Case 5: Passed");
        else
            $display("Test Case 5: Failed");
        #20
        // End of tests
        $finish;
    end

    // Clock generator
    always #5 clk = ~clk;
endmodule
