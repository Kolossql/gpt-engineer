module ABRO_Module (
  input wire clk,
  input wire reset,
  input wire A,
  input wire B,
  output reg O,
  output reg [1:0] state
);

  // Internal state variable
  reg [1:0] current_state;

  // State machine logic
  always @(posedge clk or posedge reset) begin
    if (reset) begin
      current_state <= 2'b00; // Reset to initial state
      O <= 0; // Reset output
    end else begin
      case (current_state)
        2'b00: begin
          if (A && B) begin
            current_state <= 2'b01; // Transition to next state
            O <= 1; // Set output
          end
        end
        2'b01: begin
          if (A) begin
            current_state <= 2'b10; // Transition to next state
          end
        end
        2'b10: begin
          if (B) begin
            current_state <= 2'b11; // Transition to next state
          end
        end
        2'b11: begin
          // Stay in the final state
        end
      endcase
    end
  end

  // Output current state
  always @(posedge clk) begin
    state <= current_state;
  end

endmodule
