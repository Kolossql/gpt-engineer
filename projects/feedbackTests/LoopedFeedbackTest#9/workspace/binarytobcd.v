module BinaryToBCD (
    input wire [7:0] binary_input,
    output wire [11:0] BCD_output
);

    reg [19:0] shift_register; // Shift Register
    reg [11:0] BCD_register; // BCD Register
    integer i;

    always @(binary_input)
    begin
        shift_register = {12'b0, binary_input}; // Initialize Shift Register with binary input
        BCD_register = 12'b0; // Initialize BCD Register with 0

        for (i = 0; i < 8; i = i + 1)
        begin
            shift_register = shift_register << 1; // Shift Shift Register to left

            BCD_register = BCD_register << 1; // Shift BCD Register to left
            BCD_register[0] = shift_register[19]; // Copy MSB of Shift Register to LSB of BCD Register

            if (BCD_register[3:0] > 4)
                BCD_register[3:0] = BCD_register[3:0] + 3;

            if (BCD_register[7:4] > 4)
                BCD_register[7:4] = BCD_register[7:4] + 3;

            if (BCD_register[11:8] > 4)
                BCD_register[11:8] = BCD_register[11:8] + 3;
        end
    end

    assign BCD_output = BCD_register;

endmodule
