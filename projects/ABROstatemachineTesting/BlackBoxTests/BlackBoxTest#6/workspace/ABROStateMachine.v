module ABROStateMachine (
    input wire Clock,
    input wire Reset,
    input wire A,
    input wire B,
    output wire O,
    output wire [1:0] State
);

    // State Register
    reg [1:0] state_reg;
    always @(posedge Clock or posedge Reset) begin
        if (Reset == 1'b0) begin
            state_reg <= 2'b00; // Initial state
        end else begin
            state_reg <= next_state;
        end
    end
    
    // State Decoder
    assign O = (state_reg == 2'b11) ? 1'b1 : 1'b0;
    assign State = state_reg;
    
    // State Transition Logic
    reg [1:0] next_state;
    always @(state_reg or A or B) begin
        case (state_reg)
            2'b00: begin
                if (A && B) begin
                    next_state = 2'b01;
                end else begin
                    next_state = 2'b00;
                end
            end
            2'b01: begin
                if (A && B) begin
                    next_state = 2'b11;
                end else begin
                    next_state = 2'b01;
                end
            end
            2'b11: begin
                next_state = 2'b00;
            end
            default: begin
                next_state = 2'b00;
            end
        endcase
    end

endmodule
