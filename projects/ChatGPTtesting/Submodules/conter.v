module counter(
    input clk,
    input rst_n,
    input enable,
    output reg [2:0] count
);
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            count <= 3'b000; // Initial count
        end else if (enable) begin
            count <= (count == 3'b111) ? 3'b000 : count + 1;
        end
    end
endmodule