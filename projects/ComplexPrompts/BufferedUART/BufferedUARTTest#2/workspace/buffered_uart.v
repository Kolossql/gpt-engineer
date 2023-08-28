module buffered_uart (
    input wire clk,
    input wire resetn,
    input wire enable,
    input wire rx,
    input wire [15:0] divider,
    output wire [7:0] data_out,
    output wire data_ready
);
    // UART logic here
endmodule
