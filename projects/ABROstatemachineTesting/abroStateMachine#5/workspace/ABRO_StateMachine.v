module ABRO_StateMachine (
  input wire clk,
  input wire reset,
  input wire A,
  input wire B,
  output wire [1:0] next_state,
  output wire output_sent
);

  reg [1:0] current_state;

  always @(posedge clk or posedge reset) begin
    if (reset) begin
      current_state <= 2'b00;
      output_sent <= 1'b0;
    end else begin
      case (current_state)
        2'b00: begin
          if (A && B) begin
            next_state <= 2'b01;
          end else begin
            next_state <= 2'b00;
          end
        end
        2'b01: begin
          if (A && B) begin
            next_state <= 2'b10;
            output_sent <= 1'b1;
          end else begin
            next_state <= 2'b01;
          end
        end
        2'b10: begin
          next_state <= 2'b00;
        end
        default: begin
          next_state <= 2'b00;
        end
      endcase
    end
  end

endmodule
