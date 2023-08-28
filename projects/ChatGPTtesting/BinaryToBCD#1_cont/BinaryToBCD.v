module Binary_to_BCD(
    input wire [7:0] binary_input,
    input wire clk,
    input wire reset_n,
    output reg [11:0] BCD_output
);

reg [19:0] shift_register;

always @(posedge clk or negedge reset_n)
begin
    if (~reset_n) 
        shift_register <= {12'b0, binary_input};
    else 
    begin
        // Shifting the binary input into shift_register and applying the Double Dabble Algorithm
        for(integer i = 0; i < 8; i = i + 1) begin
            shift_register <= shift_register << 1;
            
            // Correcting BCD after shift if needed
            if(shift_register[19:16] >= 5)
                shift_register[19:16] <= shift_register[19:16] + 3;
            if(shift_register[15:12] >= 5)
                shift_register[15:12] <= shift_register[15:12] + 3;
            if(shift_register[11:8] >= 5)
                shift_register[11:8] <= shift_register[11:8] + 3;
        end
    end
end

always @(shift_register)
    BCD_output = shift_register[15:4];

endmodule