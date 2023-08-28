module ABRO_StateMachine (
  input wire clk,
  input wire reset_n,
  input wire A,
  input wire B,
  output wire O,
  output wire [3:0] state
);

  // Internal state register
  reg [3:0] current_state;

  // Next state logic
  always @(posedge clk or negedge reset_n) begin
    if (!reset_n) begin
      current_state <= 4'b0001; // Set initial state
    end else begin
      case (current_state)
        4'b0001: begin // State 1
          if (A) begin
            current_state <= 4'b0010; // Transition to State 2
          end
        end
        4'b0010: begin // State 2
          if (B) begin
            current_state <= 4'b0100; // Transition to State 4
          end
        end
        4'b0100: begin // State 4
          if (A) begin
            current_state <= 4'b1000; // Transition to State 8
          end
        end
        4'b1000: begin // State 8
          if (B) begin
            current_state <= 4'b0001; // Transition to State 1
          end
        end
      endcase
    end
  end

  // Output logic
  assign O = (current_state == 4'b1000) ? 1'b1 : 1'b0;
  assign state = current_state;

endmodule
