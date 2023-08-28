module ABRO_StateMachine (
  input wire clk,
  input wire reset,
  input wire A,
  input wire B,
  output wire O,
  output wire [1:0] state
);

  // Define the states
  parameter S0 = 2'b00;
  parameter S1 = 2'b01;
  parameter S2 = 2'b10;
  parameter S3 = 2'b11;

  // Define the state register
  reg [1:0] current_state;
  always @(posedge clk or negedge reset) begin
    if (!reset) begin
      current_state <= S0; // Reset to initial state
    end else begin
      case (current_state)
        S0: begin
          if (A && B) begin
            current_state <= S1;
          end
        end
        S1: begin
          if (A && !B) begin
            current_state <= S2;
          end
        end
        S2: begin
          if (!A && B) begin
            current_state <= S3;
          end
        end
        S3: begin
          if (A && B) begin
            current_state <= S1;
          end
        end
      endcase
    end
  end

  // Define the output logic
  assign O = (current_state == S3) ? 1'b1 : 1'b0;

  // Output the current state
  assign state = current_state;

endmodule
