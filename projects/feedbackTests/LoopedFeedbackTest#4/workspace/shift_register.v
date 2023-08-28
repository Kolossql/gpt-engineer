module shift_register (
  input wire clk,
  input wire reset,
  input wire data,
  input wire shift_enable,
  output wire [7:0] stored_data
);
  reg [7:0] data_register;

  always @(posedge clk) begin
    if (reset == 0) begin
      data_register <= 8'b00000000;
    end else if (shift_enable == 1) begin
      data_register <= {data_register[6:0], data};
    end
  end

  assign stored_data = data_register;

endmodule
