module clock_gating(
    input clk,
    input enable,
    output reg gated_clk
);
    always @(posedge clk) begin
        if (enable) begin
            gated_clk <= clk;
        end else begin
            gated_clk <= 1'b0;
        end
    end
endmodule