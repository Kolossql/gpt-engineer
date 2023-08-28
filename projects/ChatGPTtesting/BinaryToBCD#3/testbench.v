`timescale 1ns / 1ps

module testbench;
    // Declare reg and wire
    reg [7:0] bin;
    wire [11:0] bcd;
    reg [11:0] expected_bcd;
    integer i;

    // Instantiate the bin2bcd module
    bin2bcd u1 (
        .bin(bin),
        .bcd(bcd)
    );

    initial begin
        // Initialize binary input
        bin = 8'b0;

        // Apply binary inputs and display BCD outputs
        for (i = 0; i < 256; i = i + 1) begin
            #10 bin = i;
            expected_bcd[3:0] = i % 10;
            expected_bcd[7:4] = (i / 10) % 10;
            expected_bcd[11:8] = (i / 100) % 10;
            #10 if (bcd === expected_bcd) begin
                $display("Test passed for input %b. Expected: %b, Actual: %b", bin, expected_bcd, bcd);
            end else begin
                $display("Test failed for input %b. Expected: %b, Actual: %b", bin, expected_bcd, bcd);
            end
        end

        // Finish the simulation
        #10 $finish;
    end
endmodule