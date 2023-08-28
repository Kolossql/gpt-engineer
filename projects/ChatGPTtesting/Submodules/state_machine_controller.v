module state_machine_controller(
    input clk,
    input rst_n,
    input enable,
    output reg [2:0] state
);
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            state <= 3'b000; // Initial state
        end else if (enable) begin
            state <= (state == 3'b111) ? 3'b000 : state + 1;
        end
    end
endmodule