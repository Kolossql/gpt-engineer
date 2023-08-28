module sequence_generator (
  input wire clk,
  input wire reset_n,
  input wire enable,
  output wire [7:0] data
);

  // Instantiate sequence_counter module
  sequence_counter counter (
    .clk(clk),
    .reset_n(reset_n),
    .enable(enable),
    .count(count)
  );

  // Instantiate sequence_memory module
  sequence_memory memory (
    .count(count),
    .data(data)
  );

  // Output the sequence value
  assign data = memory.data;

endmodule
