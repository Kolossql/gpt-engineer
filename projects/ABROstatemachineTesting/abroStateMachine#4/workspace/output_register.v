module output_register (
  input wire clk,
  input wire reset,
  input wire A,
  input wire B,
  output wire O
);

  reg O_reg;

  always @(posedge clk or negedge reset) begin
    if (!reset) begin
      O_reg <= 0;
    end else begin
      case (O_reg)
        0: begin
          if (A && B) begin
            O_reg <= 1;
          end
        end
        1: begin
          O_reg <= 0;
        end
      endcase
    end
  end

  assign O = O_reg;

endmodule
