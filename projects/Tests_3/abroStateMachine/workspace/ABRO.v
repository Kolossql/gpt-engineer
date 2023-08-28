module ABRO (
  input wire clk,
  input wire reset,
  input wire A,
  input wire B,
  output reg O,
  output wire [3:0] state
);
  reg [3:0] current_state;
  
  always @(posedge clk or negedge reset) begin
    if (!reset) begin
      current_state <= 4'b0001; // Initial state
      O <= 1'b0;
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
          O <= 1'b1; // Output state reached
        end
      endcase
    end
  end

  assign state = current_state;

endmodule
