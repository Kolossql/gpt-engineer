module sequence_rom(
    input [2:0] addr,
    output reg [7:0] data
);
    always @(addr) begin
        case (addr)
            3'b000: data <= 8'hAF;
            3'b001: data <= 8'hBC;
            3'b010: data <= 8'hE2;
            3'b011: data <= 8'h78;
            3'b100: data <= 8'hFF;
            3'b101: data <= 8'hE2;
            3'b110: data <= 8'h0B;
            3'b111: data <= 8'h8D;
        endcase
    end
endmodule