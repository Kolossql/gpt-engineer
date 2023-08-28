`timescale 1ns / 1ps

module DiceRollerTestbench;

    reg clk;
    reg reset_n;
    reg [1:0] die_select;
    reg roll;
    wire [7:0] rolled_number;

    DiceRoller uut (
        .clk(clk),
        .reset_n(reset_n),
        .die_select(die_select),
        .roll(roll),
        .rolled_number(rolled_number)
    );

    initial begin
        $dumpfile("WaveOutput.vcd");
        $dumpvars(0, DiceRollerTestbench);

        // Initialize inputs
        clk = 0;
        reset_n = 0;
        die_select = 2'b00;
        roll = 0;

        // Wait for 100ns for the system to stabilize
        #100;

        // Release reset
        reset_n = 1;

        // Test case 1: Roll a 4-sided die
        die_select = 2'b00;
        roll = 1;
        #10;
        roll = 0;
        if (rolled_number >= 1 && rolled_number <= 4)
            $display("Test case 1: Passed");
        else
            $display("Test case 1: Failed");

        // Test case 2: Roll a 6-sided die
        die_select = 2'b01;
        roll = 1;
        #10;
        roll = 0;
        if (rolled_number >= 1 && rolled_number <= 6)
            $display("Test case 2: Passed");
        else
            $display("Test case 2: Failed");

        // Test case 3: Roll an 8-sided die
        die_select = 2'b10;
        roll = 1;
        #10;
        roll = 0;
        if (rolled_number >= 1 && rolled_number <= 8)
            $display("Test case 3: Passed");
        else
            $display("Test case 3: Failed");

        // Test case 4: Roll a 20-sided die
        die_select = 2'b11;
        roll = 1;
        #10;
        roll = 0;
        if (rolled_number >= 1 && rolled_number <= 20)
            $display("Test case 4: Passed");
        else
            $display("Test case 4: Failed");

        // Test case 5: Roll a die with the roll input going high and then low before the next clock rising edge
        die_select = 2'b00;
        roll = 1;
        #5;
        roll = 0;
        #5;
        if (rolled_number == 0)
            $display("Test case 5: Passed");
        else
            $display("Test case 5: Failed");

        $finish;
    end

    always #5 clk = ~clk;

endmodule
