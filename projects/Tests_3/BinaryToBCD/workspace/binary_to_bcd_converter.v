module binary_to_bcd_converter (
  input clk,
  input [7:0] binary_input,
  output reg [11:0] bcd_output
);

  // Intermediate signals
  reg [7:0] shift_register;
  reg [3:0] shift_counter;
  reg [3:0] bcd_digit;

  // Initialize signals
  initial begin
    shift_register = 8'b0;
    shift_counter = 4'b0;
    bcd_digit = 4'b0;
  end

  // Double Dabble algorithm
  always @(posedge clk) begin
    // Shift the binary input into the shift register
    shift_register <= {shift_register[6:0], binary_input[7]};

    // Perform the conversion for each shift
    case (shift_counter)
      0: bcd_digit <= shift_register[3:0];
      1: bcd_digit <= {bcd_digit[2:0], shift_register[7:4]};
      2: bcd_digit <= {bcd_digit[1:0], shift_register[6:5]};
      3: bcd_digit <= {bcd_digit[0], shift_register[7:6]};
      4: bcd_digit <= {bcd_digit[3:1], shift_register[5]};
      5: bcd_digit <= {bcd_digit[2:0], shift_register[7:6]};
      6: bcd_digit <= {bcd_digit[1:0], shift_register[5:4]};
      7: bcd_digit <= {bcd_digit[0], shift_register[7:5]};
      8: bcd_digit <= {bcd_digit[3:2], shift_register[4]};
      9: bcd_digit <= {bcd_digit[2:0], shift_register[7:5]};
      10: bcd_digit <= {bcd_digit[1:0], shift_register[4:3]};
      11: bcd_digit <= {bcd_digit[0], shift_register[7:4]};
      12: bcd_digit <= {bcd_digit[3:1], shift_register[3]};
      13: bcd_digit <= {bcd_digit[2:0], shift_register[7:3]};
      14: bcd_digit <= {bcd_digit[1:0], shift_register[2:1]};
      15: bcd_digit <= {bcd_digit[0], shift_register[7:2]};
      default: bcd_digit <= bcd_digit;
    endcase

    // Increment the shift counter
    shift_counter <= shift_counter + 1;
  end

  // Assign the BCD output
  always @(posedge clk) begin
    bcd_output <= {bcd_digit, shift_register[1:0]};
  end

endmodule
