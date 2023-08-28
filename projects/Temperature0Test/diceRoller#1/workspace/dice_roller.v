module DiceRoller(
  input wire clk,
  input wire reset,
  input wire [1:0] die_select,
  input wire roll,
  output reg [7:0] rolled_number
);

  // Internal registers
  reg [1:0] current_die_select;
  reg [7:0] current_rolled_number;

  // Initial state
  initial begin
    current_die_select = 2'b00;
    current_rolled_number = 8'b00000000;
  end

  // Roll logic
  always @(posedge clk or posedge reset) begin
    if (reset) begin
      current_die_select <= 2'b00;
      current_rolled_number <= 8'b00000000;
    end else if (roll && (current_die_select != die_select)) begin
      current_die_select <= die_select;
      case (die_select)
        2'b00: current_rolled_number <= $random % 4 + 1;
        2'b01: current_rolled_number <= $random % 6 + 1;
        2'b10: current_rolled_number <= $random % 8 + 1;
        2'b11: current_rolled_number <= $random % 20 + 1;
        default: current_rolled_number <= 8'b00000000;
      endcase
    end
  end

  // Output assignment
  always @(posedge clk) begin
    if (reset) begin
      rolled_number <= 8'b00000000;
    end else begin
      rolled_number <= current_rolled_number;
    end
  end

endmodule
