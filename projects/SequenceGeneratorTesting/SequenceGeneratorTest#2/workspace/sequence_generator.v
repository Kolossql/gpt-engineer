module sequence_generator (
  input wire clk,
  input wire reset,
  input wire enable,
  output reg [7:0] data_out
);

  // Instantiate the clock divider
  wire slow_clk;
  clock_divider clk_divider_inst (
    .clk(clk),
    .reset(reset),
    .slow_clk(slow_clk)
  );

  // Instantiate the sequence counter
  reg [2:0] counter;
  sequence_counter counter_inst (
    .clk(slow_clk),
    .reset(reset),
    .enable(enable),
    .counter(counter)
  );

  // Instantiate the output logic
  output_logic output_logic_inst (
    .counter(counter),
    .data_out(data_out)
  );

endmodule
