module LFSR_Module (
    input wire clk,
    input wire reset,
    output wire [7:0] data
);

    reg [7:0] shift_reg;

    always @(posedge clk or negedge reset) begin
        if (~reset) begin
            shift_reg <= 8'b10001010;
        end else begin
            shift_reg <= {shift_reg[6:0], shift_reg[0]^shift_reg[3]^shift_reg[5]^shift_reg[6]};
        end
    end

    assign data = shift_reg;

endmodule
