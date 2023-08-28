module abro_state_machine (
  input wire clk,
  input wire reset,
  input wire A,
  input wire B,
  output wire O,
  output wire [1:0] state
);

  // Internal state register
  reg [1:0] current_state;

  // Next state logic
  always @(posedge clk or negedge reset) begin
    if (!reset) begin
      current_state <= 2'b00; // Reset to initial state
    end else begin
      case (current_state)
        2'b00: begin // State 00
          if (A && B) begin
            current_state <= 2'b01; // Transition to State 01
          end
        end
        2'b01: begin // State 01
          if (A && B) begin
            current_state <= 2'b10; // Transition to State 10
          end
        end
        2'b10: begin // State 10
          if (A && B) begin
            current_state <= 2'b11; // Transition to State 11
          end
        end
        2'b11: begin // State 11
          if (A && B) begin
            current_state <= 2'b11; // Remain in State 11
          end
        end
      endcase
    end
  end

  // Output logic
  assign O = (current_state == 2'b11) ? 1'b1 : 1'b0;
  assign state = current_state;

endmodule
