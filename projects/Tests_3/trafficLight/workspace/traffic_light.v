module traffic_light (
  input wire clk,
  input wire reset,
  input wire enable,
  output reg red,
  output reg yellow,
  output reg green
);

  // State definition
  
  parameter  RED = 2'b00,
              GREEN = 2'b01,
              YELLOW = 2'b0;
  

  // Internal signals
  reg [4:0] counter;
  //state_t current_state, next_state;
  reg [1:0] current_state;
  reg [1:0] next_state;

  // State machine logic
  always @(posedge clk or negedge reset) begin
    if (!reset) begin
      // Reset to initial state
      counter <= 0;
      current_state <= RED;
    end else if (enable) begin
      // State transitions
      case (current_state)
        RED: begin
          if (counter == 32) begin
            next_state <= GREEN;
            counter <= 0;
          end else begin
            next_state <= RED;
            counter <= counter + 1;
          end
        end
        GREEN: begin
          if (counter == 20) begin
            next_state <= YELLOW;
            counter <= 0;
          end else begin
            next_state <= GREEN;
            counter <= counter + 1;
          end
        end
        YELLOW: begin
          if (counter == 7) begin
            next_state <= RED;
            counter <= 0;
          end else begin
            next_state <= YELLOW;
            counter <= counter + 1;
          end
        end
        default: next_state <= RED;
      endcase
    end else begin
      // Pause operation when enable is low
      next_state <= current_state;
      counter <= counter;
    end
  end

  // Output logic
  always @(posedge clk or negedge reset) begin
    if (!reset) begin
      // Reset outputs to initial state
      red <= 1;
      yellow <= 0;
      green <= 0;
    end else if (enable) begin
      // Update outputs based on current state
      case (current_state)
        RED: begin
          red <= 1;
          yellow <= 0;
          green <= 0;
        end
        GREEN: begin
          red <= 0;
          yellow <= 0;
          green <= 1;
        end
        YELLOW: begin
          red <= 0;
          yellow <= 1;
          green <= 0;
        end
        default: begin
          red <= 1;
          yellow <= 0;
          green <= 0;
        end
      endcase
    end else begin
      // Pause operation when enable is low
      red <= red;
      yellow <= yellow;
      green <= green;
    end
  end

endmodule
