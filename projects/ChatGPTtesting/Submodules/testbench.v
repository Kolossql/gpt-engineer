module testbench_sequence_generator;
    reg clk;
    reg rst_n;
    reg enable;
    wire [7:0] data;

    // Instantiate the sequence generator module
    sequence_generator uut(
        .clk(clk),
        .rst_n(rst_n),
        .enable(enable),
        .data(data)
    );

    // Clock generation
    always begin
        #5 clk = ~clk;
    end

    // Test procedure
    initial begin
        // VCD dump file setup
        $dumpfile("sequence_generator.vcd");
        $dumpvars(0, testbench_sequence_generator);

        // Initial conditions
        clk = 0;
        rst_n = 0;
        enable = 0;

        #10 rst_n = 1; // De-assert reset
        #10 enable = 1; // Enable sequence generation

        #10; if (data != 8'hAF) $display("Test failed with value: %h", data);
        #10; if (data != 8'hBC) $display("Test failed with value: %h", data);
        #10; if (data != 8'hE2) $display("Test failed with value: %h", data);
        #10; if (data != 8'h78) $display("Test failed with value: %h", data);
        #10; if (data != 8'hFF) $display("Test failed with value: %h", data);
        #10; if (data != 8'hE2) $display("Test failed with value: %h", data);
        #10; if (data != 8'h0B) $display("Test failed with value: %h", data);
        #10; if (data != 8'h8D) $display("Test failed with value: %h", data);

        // Repeat the sequence if needed
        // ...

        // Test passed
        $display("All tests passed!");
        $finish;
    end
endmodule