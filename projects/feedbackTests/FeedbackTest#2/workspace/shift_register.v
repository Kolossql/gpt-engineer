module shift_register (
  input wire clk,
  input wire reset,
  input wire data_in,
  input wire shift_enable,
  output wire [7:0] data_out
);

  reg [7:0] data;

  always @(posedge clk) begin
    if (reset == 0) begin
      data <= 8'b00000000;
    end else if (shift_enable == 1) begin
      data <= {data[6:0], data_in};
    end
  end

  assign data_out = data;

endmodule
