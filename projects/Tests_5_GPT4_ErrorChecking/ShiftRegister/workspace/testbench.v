`timescale 1ns / 1ps

module ShiftRegister_tb;

    // Inputs
    reg clk;
    reg reset_n;
    reg data_in;
    reg shift_enable;

    // Outputs
    wire [7:0] data_out;

    // Instantiate the Unit Under Test (UUT)
    ShiftRegister uut (
        .clk(clk), 
        .reset_n(reset_n), 
        .data_in(data_in), 
        .shift_enable(shift_enable), 
        .data_out(data_out)
    );

    initial begin

        $dumpfile("Waveout.vcd");
        $dumpvars(0, ShiftRegister_tb);

        // Initialize Inputs
        clk = 0;
        reset_n = 0;
        data_in = 0;
        shift_enable = 0;

        // Wait for 100 ns for global reset to finish
        #100;
        
        reset_n = 1;
        shift_enable = 1;

        // Test Case 1: Shift in a 1
        data_in = 1;
        #10;
        if (data_out == 1'b1) begin
            $display("Test Case 1 Passed");
        end else begin
            $display("Test Case 1 Failed");
        end

        // Test Case 2: Shift in a 0
        data_in = 0;
        #20; // Wait for a clock cycle before checking the output
        if (data_out == 1'b0) begin
            $display("Test Case 2 Passed");
        end else begin
            $display("Test Case 2 Failed");
        end

        // Test Case 3: Disable shift
        shift_enable = 0;
        data_in = 1;
        #20; // Wait for a clock cycle before checking the output
        if (data_out == 1'b0) begin
            $display("Test Case 3 Passed");
        end else begin
            $display("Test Case 3 Failed");
        end

        // Test Case 4: Enable shift with clock low
        clk = 0;
        shift_enable = 1;
        #20; // Wait for a clock cycle before checking the output
        if (data_out == 1'b0) begin
            $display("Test Case 4 Passed");
        end else begin
            $display("Test Case 4 Failed");
        end

        // Test Case 5: Reset module
        reset_n = 0;
        #10;
        if (data_out == 8'b00000000) begin
            $display("Test Case 5 Passed");
        end else begin
            $display("Test Case 5 Failed");
        end

        $finish;
    end
      
    always #5 clk = ~clk;

endmodule
