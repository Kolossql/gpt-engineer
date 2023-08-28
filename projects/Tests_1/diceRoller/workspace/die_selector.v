module DieSelector (
  input wire [1:0] die_select,
  output reg [7:0] sides
);

  always @(*) begin
    case (die_select)
      2'b00: sides = 4; // 4-sided die
      2'b01: sides = 6; // 6-sided die
      2'b10: sides = 8; // 8-sided die
      2'b11: sides = 20; // 20-sided die
      default: sides = 4; // Default to 4-sided die
    endcase
  end

endmodule
