module ABROStateMachine (
  input wire clk,
  input wire reset,
  input wire A,
  input wire B,
  output wire O,
  output wire [1:0] State
);

  // State definition
  parameter S0 = 2'b00;  // Initial state
  parameter S1 = 2'b01;  // A high state
  parameter S2 = 2'b10;  // B high state
  parameter S3 = 2'b11;  // A and B high state

  // Internal state register
  reg [1:0] current_state;

  // Output register
  reg O_reg;

  always @(posedge clk or negedge reset) begin
    if (!reset) begin
      // Reset to initial state
      current_state <= S0;
      O_reg <= 1'b0;
    end else begin
      // State transitions
      case (current_state)
        S0: begin
          if (A && B) begin
            current_state <= S3;
            O_reg <= 1'b1;
          end else if (A) begin
            current_state <= S1;
          end else if (B) begin
            current_state <= S2;
          end
        end
        S1: begin
          if (B) begin
            current_state <= S3;
            O_reg <= 1'b1;
          end
        end
        S2: begin
          if (A) begin
            current_state <= S3;
            O_reg <= 1'b1;
          end
        end
        S3: begin
          // Output sent, reset to initial state
          current_state <= S0;
          O_reg <= 1'b0;
        end
      endcase
    end
  end

  // Assign outputs
  assign O = O_reg;
  assign State = current_state;

endmodule
