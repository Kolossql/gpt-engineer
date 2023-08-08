module ABROStateMachine (
  input wire clk,
  input wire reset,
  input wire A,
  input wire B,
  output wire O,
  output reg [3:0] state
);

  // State Register
  always @(posedge clk or negedge reset) begin
    if (!reset) begin
      state <= 4'b0000; // Initial state
    end else begin
      state <= next_state;
    end
  end

  // State Decoder
  always @(state) begin
    case (state)
      4'b0000: O = 1'b0; // Output is 0 in initial state
      4'b1111: O = 1'b1; // Output is 1 when both A and B have been high at least once
      default: O = 1'b0; // Output is 0 for all other states
    endcase
  end

  // State Transition Logic
  reg [3:0] next_state;
  always @(state, A, B) begin
    case (state)
      4'b0000: begin
        if (A && B) begin
          next_state = 4'b1111; // Transition to final state when both A and B are high in any order
        end else if (A) begin
          next_state = 4'b0001; // Transition to state 1 when A is high
        end else if (B) begin
          next_state = 4'b0010; // Transition to state 2 when B is high
        end else begin
          next_state = 4'b0000; // Stay in initial state if neither A nor B is high
        end
      end
      4'b0001: begin
        if (B) begin
          next_state = 4'b0011; // Transition to state 3 when B is high after A
        end else begin
          next_state = 4'b0001; // Stay in state 1 if B is not high
        end
      end
      4'b0010: begin
        if (A) begin
          next_state = 4'b0011; // Transition to state 3 when A is high after B
        end else begin
          next_state = 4'b0010; // Stay in state 2 if A is not high
        end
      end
      4'b0011: begin
        if (A && B) begin
          next_state = 4'b1111; // Transition to final state when both A and B are high after state 3
        end else begin
          next_state = 4'b0011; // Stay in state 3 if either A or B is not high
        end
      end
      default: next_state = 4'b0000; // Reset to initial state for all other states
    endcase
  end

endmodule
