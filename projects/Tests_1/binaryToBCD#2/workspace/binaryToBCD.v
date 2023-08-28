module binary_to_bcd (
  input [4:0] binary_input,
  output reg [7:0] bcd_output
);

  always @(*) begin
    case (binary_input)
      5'b00000: bcd_output = 8'b0000_0000;
      5'b00001: bcd_output = 8'b0000_0001;
      5'b00010: bcd_output = 8'b0000_0010;
      5'b00011: bcd_output = 8'b0000_0011;
      5'b00100: bcd_output = 8'b0000_0100;
      5'b00101: bcd_output = 8'b0000_0101;
      5'b00110: bcd_output = 8'b0000_0110;
      5'b00111: bcd_output = 8'b0000_0111;
      5'b01000: bcd_output = 8'b0000_1000;
      5'b01001: bcd_output = 8'b0000_1001;
      5'b01010: bcd_output = 8'b0001_0000;
      5'b01011: bcd_output = 8'b0001_0001;
      5'b01100: bcd_output = 8'b0001_0010;
      5'b01101: bcd_output = 8'b0001_0011;
      5'b01110: bcd_output = 8'b0001_0100;
      5'b01111: bcd_output = 8'b0001_0101;
      5'b10000: bcd_output = 8'b0001_0110;
      5'b10001: bcd_output = 8'b0001_0111;
      5'b10010: bcd_output = 8'b0001_1000;
      5'b10011: bcd_output = 8'b0001_1001;
      5'b10100: bcd_output = 8'b0010_0000;
      5'b10101: bcd_output = 8'b0010_0001;
      5'b10110: bcd_output = 8'b0010_0010;
      5'b10111: bcd_output = 8'b0010_0011;
      5'b11000: bcd_output = 8'b0010_0100;
      5'b11001: bcd_output = 8'b0010_0101;
      5'b11010: bcd_output = 8'b0010_0110;
      5'b11011: bcd_output = 8'b0010_0111;
      5'b11100: bcd_output = 8'b0010_1000;
      5'b11101: bcd_output = 8'b0010_1001;
      default: bcd_output = 8'b0000_0000;
    endcase
  end

endmodule
