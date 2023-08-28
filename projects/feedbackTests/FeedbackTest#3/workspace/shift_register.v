module shift_register (
  input wire clk,
  input wire reset,
  input wire data,
  input wire shift_enable,
  output wire [7:0] stored_data
);

  reg [7:0] register;

  always @(posedge clk or negedge reset) begin
    if (!reset) begin
      register <= 8'b00000000;
    end else if (shift_enable) begin
      register <= {register[6:0], data};
    end
  end

  assign stored_data = register;

endmodule
