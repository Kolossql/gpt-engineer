module ABROStateMachine (
  input wire Clock,
  input wire Reset,
  input wire A,
  input wire B,
  output wire O,
  output wire [N-1:0] State
);
  // Internal signals
  reg [N-1:0] state_reg;
  reg [N-1:0] state_next;

  // State machine states
  parameter STATE_INITIAL = 0;
  parameter STATE_A_HIGH = 1;
  parameter STATE_B_HIGH = 2;
  parameter STATE_OUTPUT_SENT = 3;

  // State machine transitions and outputs
  always @(posedge Clock or negedge Reset) begin
    if (!Reset) begin
      state_reg <= STATE_INITIAL;
    end else begin
      state_reg <= state_next;
    end
  end

  always @(state_reg or A or B) begin
    state_next = state_reg;
    case (state_reg)
      STATE_INITIAL: begin
        if (A && B) begin
          state_next = STATE_A_HIGH;
        end
      end
      STATE_A_HIGH: begin
        if (B) begin
          state_next = STATE_B_HIGH;
        end
      end
      STATE_B_HIGH: begin
        if (A) begin
          state_next = STATE_OUTPUT_SENT;
        end
      end
      STATE_OUTPUT_SENT: begin
        state_next = STATE_INITIAL;
      end
    endcase
  end

  // Output logic
  assign O = (state_reg == STATE_OUTPUT_SENT) ? 1'b1 : 1'b0;
  assign State = state_reg;
endmodule
