module top (
  input wire clk,
  input wire reset,
  output wire [7:0] data
);

  lfsr lfsr_inst (
    .clk(clk),
    .reset(reset),
    .data(data)
  );

endmodule
