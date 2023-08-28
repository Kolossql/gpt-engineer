module sequence_generator (
  input wire clk,
  input wire reset,
  input wire enable,
  output reg [7:0] data
);

  // Internal state variable to keep track of the current index in the sequence
  reg [2:0] index;

  // Sequence of hexadecimal values
 // reg [7:0] sequence [0:7] = {8'hAF, 8'hBC, 8'hE2, 8'h78, 8'hFF, 8'hE2, 8'h0B, 8'h8D};
  reg [7:0] sequence [0:7];
  

  always @(posedge clk or posedge reset) begin
    if (reset == 1'b0) begin
      // Reset to the initial state (first element of the sequence)
      index <= 3'b000;
      sequence[0] <= 8'hAF ;
      sequence[1] <= 8'hBC;
      sequence[2] <=  8'hE2;
      sequence[3] <= 8'h78;
      sequence[4] <=  8'hFF;
      sequence[5] <=  8'hE2;
      sequence[6] <=  8'h0B;
      sequence[7] <=  8'h8D;
    end else if (enable == 1'b1) begin
      // Increment the index and output the corresponding value from the sequence
      index <= index + 1;
    end
  end

  // Output the data based on the current index
  always @(index) begin
    data <= sequence[index];
  end

endmodule
