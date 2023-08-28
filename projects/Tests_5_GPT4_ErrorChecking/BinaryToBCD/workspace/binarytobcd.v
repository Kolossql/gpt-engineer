module BinaryToBCD (
    input wire [7:0] binary_input,
    output wire [11:0] BCD_output
);

    reg [11:0] BCD_register = 12'b0;
    reg [7:0] shift_register;
    integer i;

    always @(binary_input) begin
        shift_register = binary_input;
        for(i = 0; i < 8; i = i + 1) begin
            // Shift left operation
            shift_register = shift_register << 1;
            BCD_register = BCD_register << 1;
            BCD_register[0] = shift_register[7];

            // Check if any BCD digit is greater than 4
            if(BCD_register[3:0] > 4) BCD_register[3:0] = BCD_register[3:0] + 3;
            if(BCD_register[7:4] > 4) BCD_register[7:4] = BCD_register[7:4] + 3;
            if(BCD_register[11:8] > 4) BCD_register[11:8] = BCD_register[11:8] + 3;
        end
    end

    assign BCD_output = BCD_register;

endmodule
