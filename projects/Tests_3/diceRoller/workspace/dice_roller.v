module DiceRoller (
  input wire initial_state,
  input wire clock,
  input wire reset,
  input wire [1:0] die_select,
  input wire roll,
  output wire [7:0] rolled_number
);

  reg [7:0] current_number;

  always @(posedge clock or negedge reset) begin
    if (!reset) begin
      current_number <= initial_state;
    end else if (roll) begin
      case (die_select)
        2'b00: current_number <= $random % 4;
        2'b01: current_number <= $random % 6;
        2'b10: current_number <= $random % 8;
        2'b11: current_number <= $random % 20;
        default: current_number <= 8'b0;
      endcase
    end
  end

  assign rolled_number = current_number;

endmodule
