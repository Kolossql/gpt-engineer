module state_register #(
  parameter n = 4
) (
  input wire clk,
  input wire reset,
  input wire A,
  input wire B,
  output wire [n-1:0] state
);

  reg [n-1:0] current_state;

  always @(posedge clk or negedge reset) begin
    if (!reset) begin
      current_state <= 0;
    end else begin
      case (current_state)
        0: begin
          if (A && B) begin
            current_state <= 1;
          end
        end
        1: begin
          if (A) begin
            current_state <= 2;
          end
        end
        2: begin
          if (B) begin
            current_state <= 3;
          end
        end
        3: begin
          current_state <= 0;
        end
      endcase
    end
  end

  assign state = current_state;

endmodule
