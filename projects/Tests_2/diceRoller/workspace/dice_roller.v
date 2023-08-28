module dice_roller (
  input wire initial_state,
  input wire clock,
  input wire reset,
  input wire [1:0] die_select,
  input wire roll,
  output wire [7:0] rolled_number
);

  reg [7:0] rolled_number_reg;
  reg [1:0] current_die_select;

  always @(posedge clock or negedge reset) begin
    if (!reset) begin
      rolled_number_reg <= 8'b0;
      current_die_select <= 2'b00;
    end else begin
      if (roll && (current_die_select != die_select)) begin
        case (die_select)
          2'b00: rolled_number_reg <= $random % 4;
          2'b01: rolled_number_reg <= $random % 6;
          2'b10: rolled_number_reg <= $random % 8;
          2'b11: rolled_number_reg <= $random % 20;
          default: rolled_number_reg <= 8'b0;
        endcase
        current_die_select <= die_select;
      end
    end
  end

  assign rolled_number = rolled_number_reg;

endmodule
