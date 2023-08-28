`timescale 1ns / 1ps

module Testbench;
    reg clk;
    reg reset_n;
    reg enable;
    wire [7:0] data;

    // Instantiate the module under test
    SequenceGenerator MUT (
        .clk(clk),
        .reset_n(reset_n),
        .enable(enable),
        .data(data)
    );

    initial begin
        // Open VCD file
        $dumpfile("WaveOutput.vcd");
        $dumpvars(0, Testbench);

        // Initialize inputs
        clk = 0;
        reset_n = 0;
        enable = 0;

        // Apply stimulus
        #10 reset_n = 1;
        #10 enable = 1;
        #10 clk = 1;
        #10 clk = 0;
        #10 clk = 1;
        #10 clk = 0;
        #10 enable = 0;
        #10 enable = 1;
        #10 reset_n = 0;
        #10 reset_n = 1;
        #10 clk = 1;
        #10 clk = 0;
        #10 clk = 1;
        #10 clk = 0;
        #10 enable = 0;
        #10 enable = 1;
        #10 reset_n = 0;
        #10 reset_n = 1;

        // Finish simulation
        #10 $finish;
    end

    always @(posedge clk) begin
        if (enable) begin
            #5; // Add delay to allow sequence generator to update data output
            case (data)
                8'hAF: if (data != 8'hAF) $display("Failed: data = %h, expected = AF", data); else $display("Passed: data = %h", data);
                8'hBC: if (data != 8'hBC) $display("Failed: data = %h, expected = BC", data); else $display("Passed: data = %h", data);
                8'hE2: if (data != 8'hE2) $display("Failed: data = %h, expected = E2", data); else $display("Passed: data = %h", data);
                8'h78: if (data != 8'h78) $display("Failed: data = %h, expected = 78", data); else $display("Passed: data = %h", data);
                8'hFF: if (data != 8'hFF) $display("Failed: data = %h, expected = FF", data); else $display("Passed: data = %h", data);
                8'h0B: if (data != 8'h0B) $display("Failed: data = %h, expected = 0B", data); else $display("Passed: data = %h", data);
                8'h8D: if (data != 8'h8D) $display("Failed: data = %h, expected = 8D", data); else $display("Passed: data = %h", data);
                default: $display("Failed: Unexpected data = %h", data);
            endcase
        end
    end
endmodule
