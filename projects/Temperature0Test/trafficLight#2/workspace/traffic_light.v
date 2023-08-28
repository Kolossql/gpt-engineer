module TrafficLight (
  input wire clk,
  input wire reset,
  input wire enable,
  output wire red,
  output wire yellow,
  output wire green
);

  // Define the states of the traffic light state machine
  typedef enum logic [1:0] {
    STATE_RED,
    STATE_GREEN,
    STATE_YELLOW
  } State;

  // Define the state register and initialize it to STATE_RED
  reg State current_state = STATE_RED;

  // Define the counter for each state
  reg [5:0] red_counter = 32;
  reg [4:0] green_counter = 20;
  reg [3:0] yellow_counter = 7;

  // Output signals
  assign red = (current_state == STATE_RED) ? 1'b1 : 1'b0;
  assign yellow = (current_state == STATE_YELLOW) ? 1'b1 : 1'b0;
  assign green = (current_state == STATE_GREEN) ? 1'b1 : 1'b0;

  always @(posedge clk or posedge reset) begin
    if (reset) begin
      // Reset the state machine to initial state
      current_state <= STATE_RED;
      red_counter <= 32;
      green_counter <= 20;
      yellow_counter <= 7;
    end else if (enable) begin
      // State machine transitions
      case (current_state)
        STATE_RED:
          if (red_counter == 0) begin
            current_state <= STATE_GREEN;
            green_counter <= 20;
          end else begin
            red_counter <= red_counter - 1;
          end
        STATE_GREEN:
          if (green_counter == 0) begin
            current_state <= STATE_YELLOW;
            yellow_counter <= 7;
          end else begin
            green_counter <= green_counter - 1;
          end
        STATE_YELLOW:
          if (yellow_counter == 0) begin
            current_state <= STATE_RED;
            red_counter <= 32;
          end else begin
            yellow_counter <= yellow_counter - 1;
          end
      endcase
    end
  end

endmodule
