module SequenceGenerator (
    input wire clk,
    input wire rst_n,
    input wire enable,
    output wire [7:0] data
);

    // Define the states
    localparam IDLE = 2'b00;
    localparam OUTPUT_SEQUENCE = 2'b01;

    // Define the sequence values
    localparam SEQUENCE_VALUES [7:0] = {8'hAF, 8'hBC, 8'hE2, 8'h78, 8'hFF, 8'hE2, 8'h0B, 8'h8D};

    // Define the state register
    reg [1:0] state;

    // Define the output register
    reg [7:0] output_data;

    always @(posedge clk or negedge rst_n) begin
        if (~rst_n) begin
            // Reset the state and output data
            state <= IDLE;
            output_data <= SEQUENCE_VALUES[0];
        end else begin
            // State machine logic
            case (state)
                IDLE: begin
                    if (enable) begin
                        // Transition to the output sequence state
                        state <= OUTPUT_SEQUENCE;
                    end
                end
                OUTPUT_SEQUENCE: begin
                    // Output the next value in the sequence
                    output_data <= SEQUENCE_VALUES[output_data];
                    if (!enable) begin
                        // Transition back to the idle state
                        state <= IDLE;
                    end
                end
            endcase
        end
    end

    // Assign the output data
    assign data = output_data;

endmodule
