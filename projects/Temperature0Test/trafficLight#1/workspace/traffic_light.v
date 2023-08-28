module TrafficLight (
  input wire clk,
  input wire reset,
  input wire enable,
  output wire red,
  output wire yellow,
  output wire green
);

  // State definition
  typedef enum logic [1:0] {
    RED,
    GREEN,
    YELLOW
  } State;

  // Internal signals
  reg [4:0] counter;
  State current_state, next_state;

  // State machine logic
  always @(posedge clk or posedge reset) begin
    if (reset) begin
      counter <= 0;
      current_state <= RED;
    end else if (enable) begin
      counter <= counter + 1;
      current_state <= next_state;
    end
  end

  // Output logic
  always @(current_state) begin
    case (current_state)
      RED: begin
        red <= 1;
        yellow <= 0;
        green <= 0;
        if (counter == 32)
          next_state <= GREEN;
        else
          next_state <= RED;
      end
      GREEN: begin
        red <= 0;
        yellow <= 0;
        green <= 1;
        if (counter == 20)
          next_state <= YELLOW;
        else
          next_state <= GREEN;
      end
      YELLOW: begin
        red <= 0;
        yellow <= 1;
        green <= 0;
        if (counter == 7)
          next_state <= RED;
        else
          next_state <= YELLOW;
      end
      default: begin
        red <= 0;
        yellow <= 0;
        green <= 0;
        next_state <= RED;
      end
    endcase
  end

endmodule
