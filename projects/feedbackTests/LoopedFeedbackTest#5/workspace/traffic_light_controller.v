module TrafficLightController(
  input wire clk,
  input wire reset,
  input wire enable,
  output wire red,
  output wire yellow,
  output wire green
);

  // Define the states
  parameter RED_STATE = 2'b00;
  parameter GREEN_STATE = 2'b01;
  parameter YELLOW_STATE = 2'b10;

  // Define the state register
  reg [1:0] state;

  // Define the state transition counters
  reg [5:0] red_counter;
  reg [4:0] green_counter;
  reg [3:0] yellow_counter;

  // State transition logic
  always @(posedge clk or posedge reset) begin
    if (reset) begin
      state <= RED_STATE;
      red_counter <= 6'd0;
      green_counter <= 5'd0;
      yellow_counter <= 4'd0;
    end else if (enable) begin
      case (state)
        RED_STATE: begin
          if (red_counter == 6'd31) begin
            state <= GREEN_STATE;
            red_counter <= 6'd0;
          end else begin
            red_counter <= red_counter + 1;
          end
        end
        GREEN_STATE: begin
          if (green_counter == 5'd19) begin
            state <= YELLOW_STATE;
            green_counter <= 5'd0;
          end else begin
            green_counter <= green_counter + 1;
          end
        end
        YELLOW_STATE: begin
          if (yellow_counter == 4'd6) begin
            state <= RED_STATE;
            yellow_counter <= 4'd0;
          end else begin
            yellow_counter <= yellow_counter + 1;
          end
        end
      endcase
    end
  end

  // Output logic
  assign red = (state == RED_STATE) ? 1'b1 : 1'b0;
  assign yellow = (state == YELLOW_STATE) ? 1'b1 : 1'b0;
  assign green = (state == GREEN_STATE) ? 1'b1 : 1'b0;

endmodule
