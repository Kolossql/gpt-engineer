module StateRegister (
  input wire clk,
  input wire reset,
  input wire A,
  input wire B,
  output wire [3:0] state
);

  reg [3:0] current_state;

  always @(posedge clk or negedge reset) begin
    if (!reset) begin
      current_state <= 4'b0001; // Reset to initial state
    end else begin
      case (current_state)
        4'b0001: begin // Waiting for A and B
          if (A && B) begin
            current_state <= 4'b0010; // Transition to waiting for A only
          end
        end
        4'b0010: begin // Waiting for A only
          if (A) begin
            current_state <= 4'b0100; // Transition to waiting for B only
          end
        end
        4'b0100: begin // Waiting for B only
          if (B) begin
            current_state <= 4'b1000; // Transition to output state
          end
        end
        4'b1000: begin // Output state
          current_state <= 4'b0001; // Transition back to waiting for A and B
        end
      endcase
    end
  end

  assign state = current_state;

endmodule
