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

        // Initialization
        clk = 0;
        resetn = 0;
        enable = 0;
        rx = 0;
        divider = 16'h0008;

        // Baud Rate Test
        divider = 16'h0007;
        if (divider == 16'h0008) begin
            $display("Baud Rate Test: Passed");
        end else begin
            $display("Baud Rate Test: Failed");
        end

        // Buffer Test
        // Assume buffer is implemented and can be tested

        // Wishbone Interface Test
        // Assume wishbone interface is implemented and can be tested

        // UART Receive Test
        rx = 1;
        if (data_ready) begin
            $display("UART Receive Test: Passed");
        end else begin
            $display("UART Receive Test: Failed");
        end

        $finish;
    end

    always #10 clk = ~clk;
endmodule
