module input_handler (
  input wire A,
  input wire B,
  output wire valid_input
);

  reg a_entered;
  reg b_entered;

  always @(A) begin
    if (A) begin
      a_entered <= 1'b1;
    end
  end

  always @(B) begin
    if (B) begin
      b_entered <= 1'b1;
    end
  end

  assign valid_input = a_entered & b_entered;

endmodule
