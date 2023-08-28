module dice_roller (
  input wire clk,
  input wire reset_n,
  input wire [1:0] die_select,
  input wire roll,
  output wire [7:0] rolled_number
);
  wire [7:0] modulus;
  wire [7:0] lfsr_out;
  // Instantiate modules
  RandomGenerator random_gen (
    .clk(clk),
    .reset_n(reset_n),
    .roll(roll),
    .random_number(lfsr_out)
  );

  DieSelector die_selector (
    .die_select(die_select),
    .sides(modulus)
  );

  assign rolled_number = lfsr_out % modulus;

endmodule
