module reset_logic(
    input rst_n,
    input enable,
    output reg active_reset
);
    always @(rst_n, enable) begin
        if (!rst_n || !enable) begin
            active_reset <= 1'b0;
        end else begin
            active_reset <= 1'b1;
        end
    end
endmodule