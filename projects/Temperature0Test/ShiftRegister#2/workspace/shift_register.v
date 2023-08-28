module ShiftRegister (
  input wire clk,
  input wire reset,
  input wire shift_enable,
  input wire data_in,
  output wire [7:0] data_out
);

  reg [7:0] data;

  always @(posedge clk or posedge reset) begin
    if (reset) begin
      data <= 8'b00000000;
    end else if (shift_enable) begin
      data <= {data[6:0], data_in};
    end
  end

  assign data_out = data;

endmodule
