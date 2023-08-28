module RandomGenerator (
  input wire clk,
  input wire reset_n,
  input wire roll,
  output wire [7:0] random_number
);

  //reg [7:0] seed;
  reg [7:0] lfsr;

  always @(posedge clk or negedge reset_n) begin
    if (~reset_n) begin
      lfsr <= 8'b00100110; // Initial seed value
      //lfsr <= seed;
    end else if (roll) begin
      lfsr <= {lfsr[6:0], lfsr[7] ^ lfsr[2]}; // LFSR algorithm
    end
  end

  assign random_number = lfsr;

endmodule
