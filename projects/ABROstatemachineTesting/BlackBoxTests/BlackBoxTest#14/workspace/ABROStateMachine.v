module ABROStateMachine(
  input wire clk,
  input wire reset,
  input wire A,
  input wire B,
  output wire O,
  output wire [N-1:0] State
);

  // State definition
  parameter STATE_INITIAL = 2'b00;
  parameter STATE_A_HIGH = 2'b01;
  parameter STATE_B_HIGH = 2'b10;
  parameter STATE_AB_HIGH = 2'b11;

  // Internal state register
  reg [N-1:0] state_reg;
  // Next state logic
  always @(posedge clk or posedge reset) begin
    if (reset) begin
      state_reg <= STATE_INITIAL;
    end else begin
      case (state_reg)
        STATE_INITIAL: begin
          if (A && B) begin
            state_reg <= STATE_AB_HIGH;
          end else if (A) begin
            state_reg <= STATE_A_HIGH;
          end else if (B) begin
            state_reg <= STATE_B_HIGH;
          end
        end
        STATE_A_HIGH: begin
          if (A && B) begin
            state_reg <= STATE_AB_HIGH;
          end
        end
        STATE_B_HIGH: begin
          if (A && B) begin
            state_reg <= STATE_AB_HIGH;
          end
        end
        STATE_AB_HIGH: begin
          state_reg <= STATE_INITIAL;
        end
      endcase
    end
  end

  // Output logic
  assign O = (state_reg == STATE_AB_HIGH) ? 1'b1 : 1'b0;
  assign State = state_reg;

endmodule
