`timescale 1ns / 1ps

module ShiftRegister_tb;
    reg clk;
    reg reset_n;
    reg data_in;
    reg shift_enable;
    wire [7:0] data_out;

    ShiftRegister uut (
        .clk(clk),
        .reset_n(reset_n),
        .data_in(data_in),
        .shift_enable(shift_enable),
        .data_out(data_out)
    );

    initial begin
        $dumpfile("WaveOutput.vcd");
        $dumpvars(0, ShiftRegister_tb);

        // Initialize inputs
        clk = 0;
        reset_n = 0;
        data_in = 0;
        shift_enable = 0;

        // Test Case 1: Reset
        #10 reset_n = 1;
        if (data_out == 8'b00000000) begin
            $display("Test Case 1: Passed");
        end else begin
            $display("Test Case 1: Failed");
        end

        // Test Case 2: Shift enable is low, no shifting operation should occur
        #10 shift_enable = 0;
        data_in = 1;
        #10 clk = 1;
        if (data_out == 8'b00000000) begin
            $display("Test Case 2: Passed");
        end else begin
            $display("Test Case 2: Failed");
        end

        // Test Case 3: Clock is not on the rising edge, no operations should be performed
        #10 clk = 0;
        shift_enable = 1;
        if (data_out == 8'b00000000) begin
            $display("Test Case 3: Passed");
        end else begin
            $display("Test Case 3: Failed");
        end

        // Test Case 4: Active-low reset is engaged, the module should reset to its initial state
        #10 reset_n = 0;
        if (data_out == 8'b00000000) begin
            $display("Test Case 4: Passed");
        end else begin
            $display("Test Case 4: Failed");
        end

        // Test Case 5: Data bit is inputted, the stored data should change and the output process should be triggered
        #10 reset_n = 1;
        data_in = 1;
        shift_enable = 1;
        #10 clk = 1;
        if (data_out == 8'b10000000) begin
            $display("Test Case 5: Passed");
        end else begin
            $display("Test Case 5: Failed");
        end

        $finish;
    end

    always #5 clk = ~clk;
endmodule
