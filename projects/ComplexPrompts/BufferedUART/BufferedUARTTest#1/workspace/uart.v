module uart (
    input wire clk,
    input wire resetn,
    input wire enable,
    input wire rx,
    input wire [15:0] divider,
    output reg [7:0] data_out,
    output wire data_ready
);
    // UART implementation goes here
endmodule
