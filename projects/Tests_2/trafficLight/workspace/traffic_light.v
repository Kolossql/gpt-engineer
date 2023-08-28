module traffic_light (
  input wire clk,
  input wire reset_n,
  input wire enable,
  output wire red,
  output wire yellow,
  output wire green
);

  // State definitions
  localparam [1:0]
    STATE_RED = 2'b00,
    STATE_GREEN = 2'b01,
    STATE_YELLOW = 2'b10;

  // Internal signals
  reg [1:0] state;
  reg [4:0] red_counter;
  reg [4:0] green_counter;
  reg [4:0] yellow_counter;

  // Output assignments
  assign red = (state == STATE_RED) ? 1'b1 : 1'b0;
  assign yellow = (state == STATE_YELLOW) ? 1'b1 : 1'b0;
  assign green = (state == STATE_GREEN) ? 1'b1 : 1'b0;

  // State machine logic
  always @(posedge clk or negedge reset_n) begin
    if (!reset_n) begin
      state <= STATE_RED;
      red_counter <= 5'b0;
      green_counter <= 5'b0;
      yellow_counter <= 5'b0;
    end else if (enable) begin
      case (state)
        STATE_RED: begin
          if (red_counter == 5'b11111) begin
            state <= STATE_GREEN;
            red_counter <= 5'b0;
          end else begin
            red_counter <= red_counter + 1;
          end
        end
        STATE_GREEN: begin
          if (green_counter == 5'b10011) begin
            state <= STATE_YELLOW;
            green_counter <= 5'b0;
          end else begin
            green_counter <= green_counter + 1;
          end
        end
        STATE_YELLOW: begin
          if (yellow_counter == 5'b00111) begin
            state <= STATE_RED;
            yellow_counter <= 5'b0;
          end else begin
            yellow_counter <= yellow_counter + 1;
          end
        end
      endcase
    end
  end

endmodule
