module Binary_to_BCD(
    input wire [7:0] binary_input,
    input wire clk,
    input wire reset_n,
    output reg [11:0] BCD_output
);

reg [19:0] shift_register;
reg [7:0] temp_input;

always @(posedge clk or negedge reset_n)
begin
    if (~reset_n) 
        shift_register <= 20'b0;
    else 
    begin
        temp_input = binary_input;
        // Shifting the binary input into shift_register
        for(integer i = 0; i < 8; i = i + 1) begin
            shift_register <= {shift_register[18:0], temp_input[7]};
            temp_input = temp_input << 1;

            // Applying the Double Dabble Algorithm
            if(shift_register[19:16] >= 5)
                shift_register[19:16] = shift_register[19:16] + 3;
            if(shift_register[15:12] >= 5)
                shift_register[15:12] = shift_register[15:12] + 3;
            if(shift_register[11:8] >= 5)
                shift_register[11:8] = shift_register[11:8] + 3;
            shift_register = shift_register << 1;
            if(i < 7)
                shift_register[0] = temp_input[7];
        end
    end
end

always @(shift_register)
begin
    BCD_output = shift_register[15:4];
end

endmodule