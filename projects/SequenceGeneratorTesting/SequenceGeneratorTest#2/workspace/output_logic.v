module output_logic (
  input wire [2:0] counter,
  output reg [7:0] data_out
);

  always @* begin
    case (counter)
      3'b000: data_out <= 8'hAF;
      3'b001: data_out <= 8'hBC;
      3'b010: data_out <= 8'hE2;
      3'b011: data_out <= 8'h78;
      3'b100: data_out <= 8'hFF;
      3'b101: data_out <= 8'hE2;
      3'b110: data_out <= 8'h0B;
      3'b111: data_out <= 8'h8D;
      default: data_out <= 8'h00;
    endcase
  end

endmodule
