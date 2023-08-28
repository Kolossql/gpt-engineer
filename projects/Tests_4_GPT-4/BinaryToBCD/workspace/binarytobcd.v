module BinaryToBCD (
    input wire [7:0] binary_input,
    output wire [11:0] BCD_output
);

    reg [11:0] BCD_register;
    reg [7:0] shift_register;
    integer i;

    always @ (binary_input) begin
        BCD_register = 12'b0;
        shift_register = binary_input;

        for (i = 0; i < 8; i = i + 1) begin
            if (BCD_register[3:0] >= 5) BCD_register[3:0] = BCD_register[3:0] + 3;
            if (BCD_register[7:4] >= 5) BCD_register[7:4] = BCD_register[7:4] + 3;
            if (BCD_register[11:8] >= 5) BCD_register[11:8] = BCD_register[11:8] + 3;

            BCD_register = BCD_register << 1;
            BCD_register[0] = shift_register[7];
            shift_register = shift_register << 1;
        end
    end

    assign BCD_output = BCD_register;
endmodule
