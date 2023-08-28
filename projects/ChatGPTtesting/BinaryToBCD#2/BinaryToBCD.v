module binary_to_bcd
  (
    input [7:0] binary_input,
    input reset,
    input clk,
    output reg [3:0] hundreds,
    output reg [3:0] tens,
    output reg [3:0] ones
  );

  reg [11:0] bcd;
  integer i;

  always @ (posedge clk or negedge reset) begin
    if (!reset) begin
      hundreds <= 4'b0;
      tens <= 4'b0;
      ones <= 4'b0;
    end
    else begin
      bcd = 12'b0;
      for(i=0; i<8; i=i+1) begin
        // Shift bcd and input left by 1 bit
        bcd = bcd << 1;
        bcd[0] = binary_input[7];
        binary_input = binary_input << 1;

        // If any BCD digit is 5 or above, add 3 to that digit
        if(bcd[3:0] >= 5)
          bcd[3:0] = bcd[3:0] + 3;
        if(bcd[7:4] >= 5)
          bcd[7:4] = bcd[7:4] + 3;
        if(bcd[11:8] >= 5)
          bcd[11:8] = bcd[11:8] + 3;
      end

      // Update outputs
      hundreds <= bcd[11:8];
      tens <= bcd[7:4];
      ones <= bcd[3:0];
    end
  end
endmodule