`timescale 1ns / 1ps

module ABROStateMachine_tb;

    // Inputs
    reg clk;
    reg reset_n;
    reg A;
    reg B;

    // Outputs
    wire O;
    wire [1:0] State;

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
        reset_n = 1;
        A = 0;
        B = 0;

        // Dump to wave file
        $dumpfile("WaveOutput.vcd");
        $dumpvars(0, ABROStateMachine_tb);

        // Apply stimulus
        #10 A = 1; B = 0; // Test case 1: Only A is high
        #10 A = 0; B = 1; // Test case 2: Only B is high
        #10 A = 1; B = 1; // Test case 3: Both A and B are high
        #10 A = 0; B = 0; // Test case 4: Both A and B are low
        #10 reset_n = 0;  // Test case 5: Reset is low

        #10 $finish;
    end

    always #5 clk = ~clk; // Clock generator

    // Monitor block
    always @(posedge clk or negedge reset_n) begin
        if (!reset_n) begin
            if (O != 0 || State != 2'b00) $display("Test Failed");
            else $display("Test Passed");
        end else begin
            if (A && B && O != 1 || State != 2'b11) $display("Test Failed");
            else if (!A && !B && O != 0 || State != 2'b00) $display("Test Failed");
            else if (A && !B && O != 0 || State != 2'b01) $display("Test Failed");
            else if (!A && B && O != 0 || State != 2'b10) $display("Test Failed");
            else $display("Test Passed");
        end
    end

endmodule
