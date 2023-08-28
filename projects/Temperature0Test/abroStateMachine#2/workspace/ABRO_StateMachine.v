module ABRO_StateMachine (
  input wire clk,
  input wire reset,
  input wire A,
  input wire B,
  output wire [1:0] next_state,
  output wire [1:0] current_state
);

  reg [1:0] state;

  always @(posedge clk or negedge reset) begin
    if (!reset) begin
      state <= 2'b00;
    end else begin
      case (state)
        2'b00: begin
          if (A && B) begin
            state <= 2'b01;
          end
        end
        2'b01: begin
          if (A && B) begin
            state <= 2'b10;
          end
        end
        2'b10: begin
          if (A && B) begin
            state <= 2'b11;
          end
        end
        2'b11: begin
          if (!A || !B) begin
            state <= 2'b00;
          end
        end
      endcase
    end
  end

  assign next_state = state;
  assign current_state = state;

endmodule
