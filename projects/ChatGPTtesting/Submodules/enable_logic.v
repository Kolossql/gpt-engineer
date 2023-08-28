module enable_logic(
    input enable,
    input [2:0] state, // Assume the state where the system must hold
    output reg active_enable
);
    always @(enable, state) begin
        if (enable && state != 3'b111) begin // Example condition
            active_enable <= 1'b1;
        end else begin
            active_enable <= 1'b0;
        end
    end
endmodule