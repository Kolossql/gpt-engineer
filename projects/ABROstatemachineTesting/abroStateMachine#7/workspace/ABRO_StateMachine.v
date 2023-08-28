module ABRO_StateMachine (
  input wire clk,
  input wire reset,
  input wire A,
  input wire B,
  output wire O,
  output wire [1:0] State
);

  reg [1:0] current_state;
  reg [1:0] next_state;

  always @(posedge clk or negedge reset) begin
    if (!reset) begin
      current_state <= 2'b00;
    end else begin
      current_state <= next_state;
    end
  end

  always @* begin
    case (current_state)
      2'b00: begin
        if (A && B) begin
          next_state = 2'b01;
        end else begin
          next_state = current_state;
        end
      end
      2'b01: begin
        if (A && B) begin
          next_state = 2'b10;
        end else begin
          next_state = current_state;
        end
      end
      2'b10: begin
        if (A && B) begin
          next_state = 2'b11;
        end else begin
          next_state = current_state;
        end
      end
      2'b11: begin
        if (A && B) begin
          next_state = 2'b11;
        end else begin
          next_state = 2'b00;
        end
      end
      default: next_state = 2'b00;
    endcase
  end

  assign O = (current_state == 2'b11) ? 1'b1 : 1'b0;
  assign State = current_state;

endmodule
