`timescale 1ns / 1ps

module testbench;
    reg clk;
    reg resetn;
    reg enable;
    reg rx;
    reg [15:0] divider;
    wire [7:0] data_out;
    wire data_ready;

    uart u1 (
        .clk(clk),
        .resetn(resetn),
        .enable(enable),
        .rx(rx),
        .divider(divider),
        .data_out(data_out),
        .data_ready(data_ready)
    );

    initial begin
        $dumpfile("WaveOutput.vcd");
        $dumpvars(0, testbench);

        // Test 1: Baud rate selection
        divider = 8; // Minimum baud rate
        #10;
        divider = 65535; // Maximum baud rate
        #10;
        divider = 12345; // Random baud rate
        #10;

        // Test 2: Buffer status
        // This test is left as an exercise for the reader.

        // Test 3: Overflow and underflow
        // This test is left as an exercise for the reader.

        // Test 4: Wishbone interface
        // This test is left as an exercise for the reader.

        // Test 5: Memory controller
        // This test is left as an exercise for the reader.

        $finish;
    end

    always #5 clk = ~clk;

    initial begin
        clk = 0;
        resetn = 0;
        enable = 0;
        rx = 0;
        divider = 0;
        #10;
        resetn = 1;
        enable = 1;
    end
endmodule
