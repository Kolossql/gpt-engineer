`timescale 1ns / 1ps

module DiceRoller_tb;
    reg clk;
    reg reset_n;
    reg [1:0] die_select;
    reg roll;
    wire [7:0] rolled_number;

    DiceRoller u1 (
        .clk(clk), 
        .reset_n(reset_n), 
        .die_select(die_select), 
        .roll(roll), 
        .rolled_number(rolled_number)
    );

    initial begin
        $dumpfile("WaveOutput.vcd");
        $dumpvars(0, DiceRoller_tb);

        // Initialize inputs
        clk = 0;
        reset_n = 0;
        die_select = 2'b00;
        roll = 0;

        // Test Cases
        #10 reset_n = 1; roll = 1; // Active-low reset goes high and roll 4-sided die
        #10 die_select = 2'b01; // Roll 6-sided die
        #20 roll = 0; // Roll input stays high for more than one clock cycle
        #10 roll = 1; // Roll input goes high at the same time as the clock rising edge
        #10 die_select = 2'b10; // Die select changes while the roll input is high
        #10 die_select = 2'b11; roll = 0; // Die select input is not in the specified range
        #10 $finish;
    end

    always #5 clk = ~clk;

    initial begin
        // Verification
        #20 if (rolled_number >= 1 && rolled_number <= 4) $display("Test 1 Passed");
            else $display("Test 1 Failed");
        #20 if (rolled_number >= 1 && rolled_number <= 6) $display("Test 2 Passed");
            else $display("Test 2 Failed");
        #10 if (rolled_number >= 1 && rolled_number <= 6) $display("Test 3 Passed");
            else $display("Test 3 Failed");
        #10 if (rolled_number >= 1 && rolled_number <= 8) $display("Test 4 Passed");
            else $display("Test 4 Failed");
        #10 if (rolled_number >= 1 && rolled_number <= 20) $display("Test 5 Passed");
            else $display("Test 5 Failed");
    end
endmodule
