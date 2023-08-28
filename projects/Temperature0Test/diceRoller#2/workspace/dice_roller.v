module DiceRoller(
  input wire initial_state,
  input wire clock,
  input wire reset,
  input wire [1:0] die_select,
  input wire roll,
  output reg [7:0] rolled_number
);

  reg [1:0] current_die_select;
  reg [7:0] current_rolled_number;

  always @(posedge clock or posedge reset) begin
    if (reset) begin
      current_die_select <= 2'b00;
      current_rolled_number <= 8'b0;
    end else begin
      current_die_select <= die_select;
      if (roll) begin
        case (current_die_select)
          2'b00: current_rolled_number <= $random % 4;
          2'b01: current_rolled_number <= $random % 6;
          2'b10: current_rolled_number <= $random % 8;
          2'b11: current_rolled_number <= $random % 20;
        endcase
      end
    end
  end

  always @(posedge clock) begin
    if (roll) begin
      rolled_number <= current_rolled_number;
    end
  end

endmodule
