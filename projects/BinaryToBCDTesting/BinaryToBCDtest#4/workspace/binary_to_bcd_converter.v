module binary_to_bcd_converter (
  input [7:0] binary_input,
  output reg [11:0] bcd_output
);

  // Internal registers
  reg [7:0] shift_register;
  reg [3:0] digit_counter;
  reg [3:0] bcd_digit;

  // Initialize registers
  initial begin
    shift_register = 8'b0;
    digit_counter = 4'b0;
    bcd_digit = 4'b0;
  end

  // Binary to BCD conversion using Double Dabble algorithm
  always @(posedge clk) begin
    // Shift the binary input into the shift register
    shift_register <= {shift_register[6:0], binary_input[7]};

    // Perform the Double Dabble algorithm
    if (digit_counter < 4) begin
      if (shift_register[3:0] >= 5) begin
        bcd_digit = bcd_digit + 4'b3;
      end
      if (shift_register[4:0] >= 5) begin
        bcd_digit = bcd_digit + 4'b3;
      end
      if (shift_register[5:0] >= 5) begin
        bcd_digit = bcd_digit + 4'b3;
      end
      if (shift_register[6:0] >= 5) begin
        bcd_digit = bcd_digit + 4'b3;
      end
      if (bcd_digit >= 10) begin
        bcd_digit = bcd_digit + 4'b3;
      end
      bcd_output[digit_counter*4 +: 4] <= bcd_digit;
      digit_counter <= digit_counter + 1;
    end
  end

endmodule
